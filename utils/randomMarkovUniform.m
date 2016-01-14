% Generates a markov matrix by sampling parameters from the uniform distribution.
% All columns will sum to 1. 
% Author: Joshua Slocum

%Inputs
% dims: the length of each dimension.

%Outputs
% markov: the generated matrix.


function markov = randomMarkovUniform(dims)
  if(len(dims) < 2)
    markov = false;
    return
  endif
  markov = rand(dims);
  markov = makeValidMarkov(markov);

