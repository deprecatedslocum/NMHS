function [tr1, tr2, tr3, em1, em2, em3] = unpack3DHMM(packed_hmm)
% Unpacks a 3DHMM so that emission and transition matrices may be individually inspected
%
% Inputs:
% packed_hmm: a matrix containing all the model parameters
%
% Outputs:
% tr1: transfer matrix for model 1
% tr2: transfer matrix for model 2
% tr3: transfer matrix for model 3
% em1: emission matrix for model 1
% em2: emission matrix for model 2
% em3: emission matrix for model 3
%
% Authors: Joshua Slocum, Danil Tyulmankov, Alexander Friedman; Copyright 2016

states1 = packed_hmm(1,1,1);
states2 = packed_hmm(2,1,1);
states3 = packed_hmm(3,1,1);
emissions1 = packed_hmm(4,1,1);
emissions2 = packed_hmm(5,1,1);
emissions3 = packed_hmm(6,1,1);

x_offset = 1;
tr1 = packed_hmm(1:states1, x_offset+1:x_offset+states1, 1:states2, 1:states3);
x_offset = x_offset + states1;

tr2 = packed_hmm(1:states2, x_offset+1:x_offset+states2, 1:states3, 1:states1);
x_offset = x_offset + states2;

tr3 = packed_hmm(1:states3, x_offset+1:x_offset+states3, 1:states1, 1:states2);
x_offset = x_offset + states3;

em1 = packed_hmm(1:states1, x_offset+1:x_offset+emissions1, 1);
x_offset = x_offset + emissions1;

em2 = packed_hmm(1:states2, x_offset+1:x_offset+emissions2, 1);
x_offset = x_offset + emissions2;

em3 = packed_hmm(1:states3, x_offset+1:x_offset+emissions3, 1);

