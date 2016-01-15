% Generates a markov matrix by sampling parameters from the uniform distribution.
% All columns will sum to 1.
% For a transition matrix, make sure you have dims(1) == dims(2)
% Author: Joshua Slocum

%Inputs
% dims: the length of each dimension.

%Outputs
% markov: the generated matrix.


function markov = randomMarkovUniform(dims)
  if(length(dims) < 2)
    markov = false;
    return
  end   
  markov = rand(dims);
  markov = makeValidMarkov(markov);

