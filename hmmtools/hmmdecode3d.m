% Calculates the most likely state for each model at each timestep, given a set of models and sequences of observations
% Author: Joshua Slocum
% Copyright 2016 Joshua Slocum, MIT

% Inputs:
% packed: the 3d hmm model with which to begin training. See utils/pack3DHMM.m for more details.
% seq1: the data sequence that model 1 should be fitted to.
% seq2: the data sequence that model 2 should be fitted to.
% seq3: the data sequence that model 3 should be fitted to.

% Outputs:
% pStates1: the likelihood of model 1 being in each state at each timestep
% pStates2: the likelihood of model 2 being in each state at each timestep
% pStates3: the likelihood of model 3 being in each state at each timestep 
% pSeq: the joint likelihood of model 1, 2, and 3 being in a particular pair of states at each timestep
% fs: the forward probabilities
% bs: the backward probabilities
% s: the noramlization constants

function [pStates1, pStates2, pStates3, pSeq, fs, bs, s] = ...
         hmmdecode3d(packed, seq1, seq2, seq3)
  [fs, bs, s] = forward_backward3d(packed, seq1, seq2, seq3);
  pSeq = sum(log(s));
  pStates = fs.*bs;
  pStates1 = sum(sum(pStates, 3), 2);  %sum out the neighbor's states
  pStates1 = bsxfun(@rdivide, pStates1, sum(pStates1)); %normalize to get probabilities
  pStates1(:,1) = []; %remove padding from fb algorithm
  pStates2 = squeeze(sum(sum(pStates, 3), 1)); %sum out the neighbor's states
  pStates2 = bsxfun(@rdivide, pStates2, sum(pStates2)); %normalize to get probabilities
  pStates2(:,1) = []; %remove padding from fb algorithm
  pStates3 = squeeze(sum(sum(pStates, 2), 1)); %sum out the neighbor's states
  pStates3 = bsxfun(@rdivide, pStates3, sum(pStates3)); %normalize to get probabilities
  pStates3(:,1) = []; %remove padding from fb algorithm
  
