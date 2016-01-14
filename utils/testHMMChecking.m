function testHMMChecking()
  %test 2d with matched dimensions
  tr1 = makeValidMarkov(rand(3,3,2));
  tr2 = makeValidMarkov(rand(2,2,3));
  em1 = [0.1, 0.2, 0.7; 0.3, 0.3, 0.4; 0.8, 0.1, 0.1];
  em2 = [0.5, 0.5; 0.5, 0.5];
  assert(isValid2DHMM(tr1,tr2,em1,em2));

  %test 2d with mismatched dimensions
  tr1 = makeValidMarkov(rand(3,3,2));
  tr2 = makeValidMarkov(rand(2,2,2));
  em1 = [0.1, 0.2, 0.7; 0.3, 0.3, 0.4];
  em2 = [0.5, 0.5; 0.5, 0.5];
  assert(~isValid2DHMM(tr1,tr2,em1,em2));
  
  %test 3d with matched dimensions
  tr1 = makeValidMarkov(rand(2, 2, 3, 4));
  tr2 = makeValidMarkov(rand(3, 3, 4, 2));
  tr3 = makeValidMarkov(rand(4, 4, 2, 3));
  em1 = [0.5, 0.5; 0.5, 0.5];
  em2 = [0.3, 0.7; 0.3, 0.1; 0.4, 0.2]; 
  em2 = em2'
  em3 = [0.25, 0.25, 0.25, 0.25;0.25, 0.25, 0.25, 0.25]; 
  assert(isValid3DHMM(tr1, tr2, tr3, em1, em2, em3));

  %test 3d with mismatched dimensions
  tr1 = makeValidMarkov(rand(2, 2, 3, 4));
  tr2 = makeValidMarkov(rand(3, 3, 2, 2));
  tr3 = makeValidMarkov(rand(4, 4, 2, 3));
  assert(~isValid3DHMM(tr1, tr2, tr3, em1, em2, em3));
