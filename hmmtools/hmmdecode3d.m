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
  
