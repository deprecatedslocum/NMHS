function checkMarkovTesting()
  mat1 = [-0.5, 0.2; ...
          1.5, 0.8];
  assert(~isMarkov(mat1), 'ERROR: did not reject negative probability');

  mat1 = [0.1, 0.2; ...
          0.9, 0.8];
  assert(isMarkov(mat1), 'ERROR: rejected valid markov');
  mat2 = [0.1, 0.2; ...
          0.9, 0.2];
  assert(~isMarkov(mat2), 'ERROR: did not reject markov with invalid column 2');

  mat2 = makeValidMarkov(mat2);
  assert(isMarkov(mat1), 'ERROR: makeValidMarkov did not produce a valid markov');

  mat3 = zeros(2, 2, 3);
  mat3(:,:,1) = mat1;
  mat3(:,:,2) = [0.1, 0.2; ...
                 0.1, 0.2];
  mat3(:,:,3) = mat1;

  assert(~isMarkov(mat3), 'ERROR: did not reject 2d markov with invalid transition matrix');
  mat3 = makeValidMarkov(mat3);
  assert(isMarkov(mat3), 'ERROR: makeValidMarkov did not produce a valid 2d markov matrix')
  
  mat3(:,:,2) = mat1;
  assert(isMarkov(mat3), 'ERROR: isMarkov rejected a valid 2d markov');

  mat4 = zeros(2, 2, 3, 3);
  mat4(:,:,:,1) = mat3;
  mat4(:,:,:,2) = mat3;
  mat4(:,:,:,3) = mat3;
  mat4(:,:,1,2) = [0.1, 0.1; ...
                   0.1, 0.1];
  assert(~isMarkov(mat4), 'ERROR: isValidMarkov accepted invalid 3d markov');

  mat4 = makeValidMarkov(mat4);
  assert(isMarkov(mat4), 'ERROR: makeValidMarkov did not produce a valid 3d markov');

  mat4(:,:,:,2) = mat3;
  assert(isMarkov(mat4), 'ERROR: isValidMarkov rejected valid 3d markov');


  
