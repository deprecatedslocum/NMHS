function [ci12, ci21, avg12, avg21] = confInts(tr1, tr2, e1, e2, ...
    tr1_guess, tr2_guess, em1_guess, em2_guess, L, N)
% Calculates confidence intervals for connectivities via boostrapping. Answers
% the question of "for a model given by {tr1, tr2, e1, e2}, what is the
% variance of the connectivity calculated using data produced by that model?"
%
% INPUTS:
%  - tr1, tr2, e1, e2: trained matrices 
%  - tr1_guess, tr2_guess, em1_guess, em2_guess: guesses used in the
%  calculation of those matrices
%  - L: number of samples in each observation sequence
%  - N: (optional) number of times to run the bootstrap (default = 10)
% OUTPUTS:
%  - ci12: variance of the average connectivity from 1 to 2
%  - ci21: variance of the average connectivity from 2 to 1

if nargin < 9
    error('Not enough inputs arguments')
end

if nargin < 10
    N = 10; %default 50 bootstrap samples
end

[N1, M1, J1, K1] = checkDims(tr1, tr2, e1, e2); %only works for 2D
[N2, M2, J2, K2] = checkDims(tr1_guess, tr2_guess, em1_guess, em2_guess);
if N1 ~= N2 || M1 ~= M2 || J1 ~= J2 || K1 ~= K2
    error('Dimensions mismatch')
end

conns12 = zeros(1, N);
conns21 = zeros(1, N);
for i = 1:N %this can actually be completely parallelized 
    [seq1, seq2] = hmmgenerate2d(L, tr1, tr2, e1, e2);
    [tr1_trained, tr2_trained] = ...
         baum_welch2d(tr1_guess, tr2_guess, em1_guess, em2_guess, seq1, seq2);
    conns12(i) = connectivity(tr1_trained, tr2_trained, false);
    conns21(i) = connectivity(tr2_trained, tr1_trained, false);
end

ci12 = var(conns12);
ci21 = var(conns21);
avg12 = mean(conns12);
avg21 = mean(conns21);

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    