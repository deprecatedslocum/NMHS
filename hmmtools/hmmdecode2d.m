function [pStates1, pStates2, pSeq, fs, bs, s] = hmmdecode2d(tr1, tr2, em1, em2, seq1, seq2)
  [fs, bs, s] = forward_backward2d(tr1, tr2, em1, em2, seq1, seq2);
  pSeq = sum(log(s));
  pStates = fs.*bs;
  pStates1 = sum(pStates, 2);  %sum out the neighbor's states
  pStates1 = bsxfun(@rdivide, pStates1, sum(pStates1)); %normalize to get probabilities
  pStates1(:,1) = []; %remove padding from fb algorithm
  pStates2 = squeeze(sum(pStates, 1)); %sum out the neighbor's states
  pStates2 = bsxfun(@rdivide, pStates2, sum(pStates2)); %normalize to get probabilities
  pStates2(:,1) = []; %remove padding from fb algorithm
  
