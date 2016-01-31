% Implements the Baum-Welch algorithm for 2-dimensional HMM's
% (see http://en.wikipedia.org/wiki/Baum-Welch_algorithm )
% author: Joshua Slocum

% Inputs:
% packed_2d_guess: the initial guess for model training. See utils/pack2DHNM.m for more details
% seq1: the data sequence that model 1 should be fitted to.
% seq2: the data sequence that model 2 should be fitted to.

% Outputs:
% packed_trained: the trained model in packed form
% logLs: training history of the log-likelihood of the model.
function [packed_trained, logLs] = ...
    hmmtrain2d(packed_guess, seq1, seq2, varargin)

[tr1_guess, tr2_guess, em1_guess, em2_guess] = unpack2DHMM(packed_guess);

CONVERGENCE_LIMIT = 500;
EPSILON = 1e-5;
if(length(varargin) >= 1)
  CONVERGENCE_LIMIT = varargin{1};
end
if(length(varargin) >= 2)
  EPSILON = varargin{2};
end

tr1_trained = tr1_guess;
tr2_trained = tr2_guess;
em1_trained = em1_guess;
em2_trained = em2_guess;
num_states1 = size(tr1_guess, 1);
num_states2 = size(tr2_guess, 1);
num_emissions1 = size(em1_guess, 2);
num_emissions2 = size(em2_guess, 2);
num_events = length(seq1);


[forward_probabilities, backward_probabilities, normalization_factors] = forward_backward2d(packed_guess, seq1, seq2);
old_logL = sum(log(normalization_factors));
logLs = [old_logL];

convergence = false;
%make seqs line up with forward/backward probabilities - forward_backward
%adds padding
seq1 = [1, seq1];
seq2 = [1, seq2];
for iter = 1:CONVERGENCE_LIMIT
    
    little_chi = zeros(num_states1, num_states2, num_states1, num_states2, num_events);
    
    %use logs and addition/subtraction to avoid floating-point restrictions
    loglik = log(normalization_factors);
    logf = log(forward_probabilities);
    logb = log(backward_probabilities);
    logE1 = log(em1_trained);
    logE2 = log(em2_trained);
    logTR1 = log(tr1_trained);
    logTR2 = log(tr2_trained);
    
    for k = 1:num_states1
        for l = 1:num_states2
            for i = 1:num_states1
                for j = 1:num_states2
                    for t = 1:num_events
                        little_chi(k,l,i,j,t) = ...
                            exp(logf(k,l,t) + logTR1(k,i,l) + logTR2(l,j,k) + ...
                            logE1(i, seq1(t+1)) + logE2(j, seq2(t+1)) + logb(i,j,t+1) - ...
                            loglik(t+1));
                    end
                end
            end
        end
    end
    
    fb_products = exp(logf + logb); %same as little-theta, in theory: for a given t, P(k,l | X, Y)
    fb_products(:,:,1) = 1;
    
    log_fbp = log(fb_products);
    
    big_pi = log(squeeze(sum(little_chi, 4))); %for a given t, P(k,l,i | X,Y)
    big_psi = log(squeeze(sum(little_chi, 3))); %for a given t, P(k,l,j | X,Y)
    
    for k = 2:num_events
        big_pi(:,:,:,t) = big_pi(:,:,:,t) - repmat(fb_products(:,:,t), [1, 1, num_states1]);
        big_psi(:,:,:,t) = big_psi(:,:,:,t) - repmat(fb_products(:,:,t), [1, 1, num_states2]);
    end
    
    big_pi(isnan(big_pi)) = 0;
    big_psi(isnan(big_psi)) = 0;
    
    tr1_trained = sum(exp(big_pi), 4);
    tr1_trained = permute(tr1_trained, [1 3 2]); %ijk->ikj
    tr1_trained = tr1_trained ./ repmat(sum(tr1_trained, 2), [1, num_states1, 1]);
    
    tr2_trained = sum(exp(big_psi), 4);
    tr2_trained = permute(tr2_trained, [2, 3, 1]); %klj -> ljk
    tr2_trained = tr2_trained ./ repmat(sum(tr2_trained, 2), [1, num_states2, 1]);
    
    
    
    big_e = zeros(num_states1, num_emissions1);
    big_h = zeros(num_states2, num_emissions2);
    for e = 1:num_emissions1
        pos = find(seq1 == e);
        big_e(:, e) = sum(sum(fb_products(:,:,pos), 3), 2);
    end
    em1_trained = big_e ./ repmat(sum(big_e, 2), 1, num_emissions1);
    %normalize coefficients to 1
    for e = 1:num_emissions2
        pos = find(seq2 == e);
        big_h(:, e) = transpose(sum(sum(fb_products(:,:,pos), 3), 1));
    end
    em2_trained = big_h ./ repmat(sum(big_h, 2), 1, num_emissions2);
    %normalize coefficients to 1


    packed_trained = pack2DHMM(tr1_trained, tr2_trained, em1_trained, em2_trained);
    
    [forward_probabilities, backward_probabilities, normalization_factors] = forward_backward2d(packed_trained, seq1(2:length(seq1)), seq2(2:length(seq2)));

    new_logL = sum(log(normalization_factors));
    logLs(iter+1) = new_logL;
    if(abs((new_logL - old_logL)/new_logL) < EPSILON)
        convergence = true;
        disp(['Converged after ', num2str(iter), ' iterations!'])
        break;
    end
    old_logL = new_logL;
end





