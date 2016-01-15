function testHMMCreation()
  %test making of markovs
  mat1 = randomMarkovUniform([2, 3, 3, 4]);
  assert(isMarkov(mat1));
  mat2 = randomMarkovUniform([2]);
  assert(~isMarkov(mat2));
  mat3 = randomMarkovUniform([3, 2]);
  assert(isMarkov(mat3));


  %test creation of whole markov
  [~, tr1, tr2, em1, em2] = generate2DHMMUniform(2, 3, 4, 5);
  assert(isValid2DHMM(tr1, tr2, em1, em2));

    [~, tr1, tr2, tr3, em1, em2, em3] = generate3DHMMUniform(2, 3, 4, 5, 6, 7);
  assert(isValid3DHMM(tr1, tr2, tr3, em1, em2, em3));
