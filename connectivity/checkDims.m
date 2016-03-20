% Author: Danil Tyulmankov
% Copyright 2016 Danil Tyulmankov, MIT


function [N, M, J, K] = checkDims(tr1, tr2, e1, e2)
%tr1 is NxNxM, tr2 is MxMxN, e1 is NxJ, e2 is MxK

%TODO: rewrite this so that it throws exceptions instead

if ndims(tr1) ~= 3 || ndims(tr2) ~= 3
    error('Transition matrices must both be 3-dimensional')
end

[N1, N2, M] = size(tr1);
[M1, M2, N] = size(tr2);
if N ~= N1 || N ~= N2 || N1 ~= N2 || M ~= M1 || M ~= M2 || M1 ~= M2
    error('Input matrix size mismatch. tr1 must be NxNxM, tr2 must be MxMxN.')
end

if nargin == 4
    if ~ismatrix(e1) || ~ismatrix(e2)
        error('Emission matrices must both be 2-dimensional')
    end
    
    [N1, J] = size(e1);
    [M1, K] = size(e2);
    if N ~= N1 || M ~= M1
        error('Input matrix size mismatch. tr1 must be NxNxM, tr2 must be MxMxN, e1 must be NxJ, e2 must be MxK.')
    end
    
    if N > J || M > K
        error('Input matrix size mismatch. Cannot have more states than emissions.')
    end
end