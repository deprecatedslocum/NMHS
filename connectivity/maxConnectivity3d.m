function [A_B, A_C] = maxConnectivity3d(trA, trB, trC)
% Calculates connectivity by taking the max (instad of mean) of the 
% connectivities across the states of A (see maxConnectivity.m). 
% Interpretation of outputs A_B and A_C still the same as in connectivity3d.m

checkDims3d(trA, trB, trC);

A_B = zeros(1, size(trA,4));
for i = 1:size(trA,4)
    A_B(i) = maxConnectivity(trA(:,:,:,i), squeeze(trB(:,:,i,:)));
end

A_C = zeros(1, size(trA,3));
for i = 1:size(trA, 3)
    A_C(i) = maxConnectivity(squeeze(trA(:,:,i,:)), trC(:,:,:,i));
end






