% Returns true if:
% All emission matrices and transition matrices satisfy the markov property
% All emission matrices and transition matrices agree on the number of states for their respective process
% All transition matrices have the right number of states in the right order. 

function valid = isValid3DHMM(tr1, tr2, em1, em2)

  valid = isMarkov(tr1) & isMarkov(tr2) & isMarkov(em1') & isMarkov(em2');

  valid = valid & (size(tr1, 1) == size(em1, 1));
  valid = valid & (size(tr2, 1) == size(em2, 1));

  valid = valid & size(tr1, 2) == size(tr1, 1);
  valid = valid & size(tr2, 2) == size(tr2, 1);
  
  valid = valid & size(tr1, 2) == size(tr2, 3);
  valid = valid & size(tr1, 3) == size(tr2, 2);

  
