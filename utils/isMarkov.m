function bool = isMarkov(matrix)
% Returns true if matrix satisfies the Markov property (every column must sum
% to 1, within a margin of error of eps(1)). Returns false otherwise. Works for
% higher order matrices, e.g. 2DHMM transition matrices.
%
%Inputs
% matrix: the matrix to be checked
%
%Outputs
% bool: true if the matrix satisfies the markov property.
%
% Authors: Joshua Slocum, Danil Tyulmankov, Alexander Friedman; Copyright 2016

bool = false;
shouldBeOnes = sum(matrix,2);
diff = ones(size(shouldBeOnes)) - shouldBeOnes;
bool = all(abs(diff(:)) <= eps(1));
bool = bool & all(matrix(:) >= 0);

