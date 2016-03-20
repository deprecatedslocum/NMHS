function [A_B, A_C, A_BC] = interactivity3d(trA, trB, trC, plotthis)
% Looks at how much neuron A listens to neurons B and C by comparing the
% layers of the transition matrix of neuron A. (trB and trC inputs are only
% used for checking that the three matrices are dimensionally compatible.)
% Use the plotthis boolean argument to turn plotting on/off. On by default.
%
% Outputs: 
%  A_B: vector of how much A listens to B when C is in state i, where i is the index
%       of the entry in the vector
%       i.e. A_B(i) = how much A listens to B when C is in state i
%  A_C: how much A listens to C when B is in state i, where i is the index
%       of the entry in the vector
%  A_BC: single value of how much A listens to both B and C. Computed as the geometric 
%        average of mean(A_B) and mean(A_C).
%
% For more detailed outputs, run interactivity2d.m on every 3D submatrix of
% trA along the 4th dimension i.e. on trA(:,:,:,i) for i=1..size(trA, 4).
% This will give you the details on the interactin strength between A and B, given
% that C is in state i. You can then compare those interaction strength details for
% different values of i. 
%
% Similarly, repreat the process on permute(trA, [1,2,4,3]) to get the details 
% about interactivity between A and C, given that B is in state i. This is
% in fact what the algorithm does, but for readability and clarity, the 
% only output is average interactivity 
%
% Analogous to interactivity2d.m, permute the input order as necesary to get 
% interactivity of B to A and C, and of C to A and B.
%
% See interactivity2d.m for additional information.
%
% Authors: Danil Tyulmankov, Joshua Slocum, Alexander Friedman
% Copyright 2016 Danil Tyulmankov, MIT


[A, B, C] = checkDims3d(trA, trB, trC);

A_B = zeros(1, size(trA,4));
for i = 1:size(trA,4)
    A_B(i) = interactivity2d(trA(:,:,:,i), squeeze(trB(:,:,i,:)), false);
end

A_C = zeros(1, size(trA,3));
for i = 1:size(trA, 3)
    A_C(i) = interactivity2d(squeeze(trA(:,:,i,:)), trC(:,:,:,i), false);
end

% Geometric average gives us the following property: if A either doesn't 
% listen to B at all or doesn't listen to C at all, then it is certain to
% not listen to their combination, which gives A_BC = 0
A_BC = sqrt(mean(A_B)*mean(A_C));

%% Plot
if nargin > 3
    if ~plotthis
        return
    end
end

subplot(2,1,1)
bar(A_B)
xlabel('Given state of C')
ylabel('Percent how much A listens to B')
axis([0.5 length(A_C)+0.5 0 inf])

subplot(2,1,2)
bar(A_C)
xlabel('Given state of B')
ylabel('Percent how much A listens to C')
axis([0.5 length(A_B)+0.5 0 inf])



