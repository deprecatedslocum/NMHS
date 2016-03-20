function markov = randomMarkovUniform(dims)
% Generates a markov matrix by sampling parameters from the uniform distribution.
% All columns will sum to 1.
% For a transition matrix, make sure you have dims(1) == dims(2)
%
%Inputs
% dims: the length of each dimension.
%
%Outputs
% markov: the generated matrix.
%
% Authors: Joshua Slocum, Danil Tyulmankov, Alexander Friedman; Copyright 2016


if(length(dims) < 2)
    markov = false;
    return
end
markov = rand(dims);
markov = makeValidMarkov(markov);

