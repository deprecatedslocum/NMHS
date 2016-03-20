% Author: Danil Tyulmankov
% Copyright 2016 Danil Tyulmankov, MIT
function c = maxConnectivity_summary(tr1, tr2, tr3)
% Entry c(i,j) is "i listens to j," or in less precise terms "j causes i."
% Connectivity calculated as the maximum connectivity across all of the
% states of the neuron as well as all of the states of the neighbor. See
% maxConnectivity.m and maxConnectivity3d.m for details. 

if nargin == 3
    c = zeros(3);
    
    [c12, c13] = maxConnectivity3d(tr1, tr2, tr3);
    [c31, c32] = maxConnectivity3d(tr3, tr1, tr2);
    [c23, c21] = maxConnectivity3d(tr2, tr3, tr1);
    
    c(1,2) = max(c12);
    c(2,1) = max(c21);
    c(1,3) = max(c13);
    c(3,1) = max(c31);
    c(2,3) = max(c23);
    c(3,2) = max(c32);
    
elseif nargin == 2
    c = zeros(2);
    
    c(1,2) = maxConnectivity(tr1, tr2);
    c(2,1) = maxConnectivity(tr2, tr1);
    
else
    error('Incorrect number of arguments')
    
end

