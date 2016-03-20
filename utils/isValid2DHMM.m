function valid = isValid2DHMM(tr1, tr2, em1, em2)
% Returns true if:
% All emission matrices and transition matrices satisfy the markov property
% All emission matrices and transition matrices agree on the number of states for their respective process
% All transition matrices have the right number of states in the right order.
% Does not use packed format, because packing requires having the states right!
%
%Inputs
% tr1: transfer matrix for model 1
% tr2: transfer matrix for model 2
% em1: emission matrix for model 1
% em2: emission matrix for model 2
%
%Outputs
% valid: true if the packed 2DHMM is valid
%
% Authors: Joshua Slocum, Danil Tyulmankov, Alexander Friedman; Copyright 2016

valid = isMarkov(tr1) & isMarkov(tr2) & isMarkov(em1) & isMarkov(em2);

valid = valid & (size(tr1, 1) == size(em1, 1));
valid = valid & (size(tr2, 1) == size(em2, 1));

valid = valid & size(tr1, 2) == size(tr1, 1);
valid = valid & size(tr2, 2) == size(tr2, 1);

valid = valid & size(tr1, 2) == size(tr2, 3);
valid = valid & size(tr1, 3) == size(tr2, 2);


