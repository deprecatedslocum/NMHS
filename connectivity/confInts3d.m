function [ci_overall, ci_dir, avg_overall, avg_dir] = confInts3d(tr1, tr2, tr3, e1, e2, e3, ...
    tr1g, tr2g, tr3g, e1g, e2g, e3g, L, N)
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
%  - CI_overall: confidence interval (variance) of overall connectivity 
%    (where overall connectivity is calculated as the max of all six
%    possible directions of connectivity
%  - CI_dir: confidence interval for each of the six directions. Entry (i,j)
%    is "i listens to j," or in less precise terms "j causes i." Entries
%    along the diagonal are meaningless (return zero)


if nargin < 13
    error('Not enough inputs arguments')
end

if nargin < 14
    N = 10; %default 10 bootstrap samples
end

[A1, B1, C1, J1, K1, L1] = checkDims3d(tr1, tr2, tr3, e1, e2, e3);
[A2, B2, C2, J2, K2, L2] = checkDims3d(tr1g, tr2g, tr3g, e1g, e2g, e3g);
if A1 ~= A2 || B1 ~= B2 || C1 ~= C2 || J1 ~= J2 || K1 ~= K2 || L1 ~= L2
    %guess and init should be same size
    error('Dimensions mismatch')
end

dirs = zeros(3,3,N);
overall = zeros(1,N);
for i = 1:N %this can actually be completely parallelized 
    [seq1, seq2, seq3] = hmmgenerate3d(L, tr1, tr2, tr3, e1, e2, e3);
    
    guess = pack3DHMM(tr1g, tr2g, tr3g, e1g, e2g, e3g);
    result = baum_welch3d(guess, seq1, seq2, seq3);
    [tr1t, tr2t, tr3t] = unpack3DHMM(result);
    
    conn = connectivity_summary(tr1t, tr2t, tr3t);
    dirs(:,:,i) = conn;
    overall(i) = max(conn(:));
end

ci_overall = var(overall);
avg_overall = mean(overall);

ci_dir = var(dirs, 0, 3);
avg_dir = mean(dirs, 3);

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    