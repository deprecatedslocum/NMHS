function [A, B, C, J, K, L] = checkDims3d(trA, trB, trC, eA, eB, eC)
% Makes sure the transition matrices and, if provided, emission matrices
% are compatible with each other in terms of dimensions. In other words:
% - trA is AxAxBxC, trB is BxBxCxA, trC is CxCxAxB
% - eA is AxJ, eB is BxK, eC is CxL
% Note: Does not check whether matrices satisfy the Markov property
%
% Authors: Danil Tyulmankov, Joshua Slocum, Alexander Friedman
% Copyright 2016 Danil Tyulmankov, MIT

% -- check TR matrices -- 
if ndims(trA) ~= 4 || ndims(trB) ~= 4 || ndims(trC) ~= 4
    error('Transition matrices must all be 4-dimensional')
end

[A, A1, B2, C2] = size(trA); 
[B, B1, C3, A2] = size(trB);
[C, C1, A3, B3] = size(trC);

if ~isequal([A,B,C], [A1 B1 C1], [A2, B2, C2], [A3, B3, C3]) 
    error('Transition matrix dimension mismatch.')
end

% -- optionally check E matrices --
if nargin == 6 
    if ~ismatrix(eA) || ~ismatrix(eB) || ~ismatrix(eC)
        error('Emission matrices must all be 2-dimensional')
    end
    
    [A1, J] = size(eA);
    [B1, K] = size(eB);
    [C1, L] = size(eC);
    
    if ~isequal([A, B, C], [A1, B1, C1])
        error('Emission matrix dimension mismatch: different number of states than transition matrices.')
    end
    
    if A > J || B > K || C > L
        error('Emission matrix dimension mismatch: more states than emissions.')
    end  
end