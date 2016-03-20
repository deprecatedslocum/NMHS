function c = interactivity(tr1, tr2, tr3)
% Wrapper for interactivity2d.m and interactivity3d.m Returns a summary of 
% pairwise interactivities. Entry c(i,j) is "j affects i"
%
% Authors: Danil Tyulmankov, Joshua Slocum, Alexander Friedman; Copyright 2016



if nargin == 3
    c = zeros(3);
    
    [c12, c13] = interactivity3d(tr1, tr2, tr3, false);
    [c31, c32] = interactivity3d(tr3, tr1, tr2, false);
    [c23, c21] = interactivity3d(tr2, tr3, tr1, false);
    
    c(1,2) = mean(c12);
    c(2,1) = mean(c21);
    c(1,3) = mean(c13);
    c(3,1) = mean(c31);
    c(2,3) = mean(c23);
    c(3,2) = mean(c32);
    
elseif nargin == 2
    c = zeros(2);
    
    c(1,2) = interactivity(tr1, tr2, false);
    c(2,1) = interactivity(tr2, tr1, false);
    
else
    error('Incorrect number of arguments')
    
end

