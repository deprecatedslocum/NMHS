% Calculates the most likely state for each model at each timestep, given a set of models and sequences of observations
% Author: Joshua Slocum

% Inputs:
% packed_2d_hmm: see utils/pack2DHNM.m for more details
% seq1: the data sequence that model 1 should be fitted to.
% seq2: the data sequence that model 2 should be fitted to.

% Outputs:
% pStates1: the likelihood of model 1 being in each state at each timestep
% pStates2: the likelihood of model 2 being in each state at each timestep 
% pSeq: the joint likelihood of model 1 and 2 being in a particular pair of states at each timestep
% fs: the forward probabilities
% bs: the backward probabilities
% s: the noramlization constants

function [pStates1, pStates2, pSeq, fs, bs, s] = hmmdecode2d(packed_2d_hmm, seq1, seq2)
  [fs, bs, s] = forward_backward2d(packed_2d_hmm, seq1, seq2);
  pSeq = sum(log(s));
  pStates = fs.*bs;
  pStates1 = sum(pStates, 2);  %sum out the neighbor's states
  pStates1 = bsxfun(@rdivide, pStates1, sum(pStates1)); %normalize to get probabilities
  pStates1(:,1) = []; %remove padding from fb algorithm
  pStates2 = squeeze(sum(pStates, 1)); %sum out the neighbor's states
  pStates2 = bsxfun(@rdivide, pStates2, sum(pStates2)); %normalize to get probabilities
  pStates2(:,1) = []; %remove padding from fb algorithm
  
