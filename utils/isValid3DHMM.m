% Returns true if:
% All emission matrices and transition matrices satisfy the markov property
% All emission matrices and transition matrices agree on the number of states for their respective process
% All transition matrices have the right number of states in the right order.
% Does not use packed format, because packing requires having the states right!

%Inputs
% tr1: transfer matrix for model 1
% tr2: transfer matrix for model 2
% tr3: transfer matrix for model 3
% em1: emission matrix for model 1         
% em2: emission matrix for model 2         
% em3: emission matrix for model 3


%Outputs
% valid: true if the packed 3DHMM is valid



function valid = isValid3DHMM(tr1, tr2, tr3,  em1, em2, em3)

  valid = isMarkov(tr1); 
  valid = valid & isMarkov(tr2);
  valid = valid & isMarkov(tr3);
  valid = valid & isMarkov(em1'); 
  valid = valid & isMarkov(em2');
  valid = valid & isMarkov(em3');

  valid = valid & (size(tr1, 1) == size(em1, 1));
  valid = valid & (size(tr2, 1) == size(em2, 1));
  valid = valid & (size(tr3, 1) == size(em3, 1));
  
  valid = valid & size(tr1, 2) == size(tr2,4);
  valid = valid & size(tr1, 2) == size(tr3,3);

  valid = valid & size(tr1, 3) == size(tr2, 2);
  valid = valid & size(tr1, 3) == size(tr3, 4);

  valid = valid & size(tr1, 4) == size(tr2, 3);
  valid = valid & size(tr1, 4) == size(tr3, 2);

  
