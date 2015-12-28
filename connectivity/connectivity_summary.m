function c = connectivity_summary(tr1, tr2, tr3)
% Returns a summary of connectivities. Entry c(i,j) is "i listens to j,"
% or in less precise terms "j causes i"

if nargin == 3
    c = zeros(3);
    
    [c12, c13] = connectivity3d(tr1, tr2, tr3, false);
    [c31, c32] = connectivity3d(tr3, tr1, tr2, false);
    [c23, c21] = connectivity3d(tr2, tr3, tr1, false);
    
    c(1,2) = mean(c12);
    c(2,1) = mean(c21);
    c(1,3) = mean(c13);
    c(3,1) = mean(c31);
    c(2,3) = mean(c23);
    c(3,2) = mean(c32);
    
elseif nargin == 2
    c = zeros(2);
    
    c(1,2) = connectivity(tr1, tr2, false);
    c(2,1) = connectivity(tr2, tr1, false);
    
else
    error('Incorrect number of arguments')
    
end

