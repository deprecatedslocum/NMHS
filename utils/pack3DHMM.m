function packed_hmm = pack3DHMM(tr1, tr2, tr3, em1, em2, em3)
% Given a set of transfer and emission matrices corresponding to a 3D HMM model, packs them into a singe matrix.
%
% Inputs:
% tr1: transfer matrix for model 1
% tr2: transfer matrix for model 2
% tr3: transfer matrix for model 3
% em1: emission matrix for model 1
% em2: emission matrix for model 2
% em3: emission matrix for model 3
%
% Outputs:
% packed_hmm: a matrix containing all the model parameters
%
% Authors: Joshua Slocum, Danil Tyulmankov, Alexander Friedman; Copyright 2016

states1 = size(tr1, 1);
states2 = size(tr2, 1);
states3 = size(tr3, 1);
emissions1 = size(em1, 2);
emissions2 = size(em2, 2);
emissions3 = size(em3, 2);
packed_hmm = zeros(max([states1, states2, states3]), 1+states1+states2+states3+emissions1+emissions2);

packed_hmm(1,1,1) = states1;
packed_hmm(2,1,1) = states2;
packed_hmm(3,1,1) = states3;
packed_hmm(4,1,1) = emissions1;
packed_hmm(5,1,1) = emissions2;
packed_hmm(6,1,1) = emissions3;

x_offset = 1;
packed_hmm(1:states1, x_offset+1:x_offset+states1, 1:states2, 1:states3) = tr1;
x_offset = x_offset + states1;

packed_hmm(1:states2, x_offset+1:x_offset+states2, 1:states3, 1:states1) = tr2;
x_offset = x_offset + states2;

packed_hmm(1:states3, x_offset+1:x_offset+states3, 1:states1, 1:states2) = tr3;
x_offset = x_offset + states3;

packed_hmm(1:states1, x_offset+1:x_offset+emissions1, 1) = em1;
x_offset = x_offset + emissions1;

packed_hmm(1:states2, x_offset+1:x_offset+emissions2, 1) = em2;
x_offset = x_offset + emissions2;

packed_hmm(1:states3, x_offset+1:x_offset+emissions3, 1) = em3;
