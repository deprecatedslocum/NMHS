% Returns true if matrix satisfies the Markov property (every column must sum
% to 1, within a margin of error of eps(1)). Returns false otherwise. Works for
% higher order matrices, e.g. 2DHMM transition matrices. 
% Author: Joshua Slocum

%Inputs
% matrix: the matrix to be normalized to satisfy the markov property

%Outputs
% markov: the normalized matrix, now satisfying the markov property

function markov = makeValidMarkov(matrix)
  matrix(matrix < 0) = 0;
  markov = bsxfun(@rdivide, matrix, sum(matrix, 2));
