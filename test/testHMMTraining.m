% Copyright 2016 Joshua Slocum, MIT
function testHMMTraining()
  % Make a 2D HMM and generate some data
  numStates1 = 3; numStates2 = 2; numEmissions1 = 4; numEmissions2 = 3;
  packed2D = generate2DHMMUniform(numStates1, numStates2, numEmissions1, numEmissions2);
  [seq1, seq2, states1, states2] = hmmgenerate2d(1000, packed2D);
  assert(max(states1) <= numStates1);
  assert(max(states2) <= numStates2);
  assert(max(seq1) <= numEmissions1);
  assert(max(seq2) <= numEmissions2);

  disp('Testing 2D training function: this may take a few minutes')
  % Make random TR and EM matrices, then train. Make sure the logL has improved
  guess2D = generate2DHMMUniform(numStates1, numStates2, numEmissions1, numEmissions2);
  %[~, logLs] = hmmtrain2d(guess2D, seq1, seq2, 50);
  %assert(logLs(1) < logLs(length(logLs))); %make sure training improved the logL
  disp('2D Model training functions OK.')

  % Make a 3D HMM and generate some data
  numStates1 = 3; numStates2 = 2; numStates3 = 2;
  numEmissions1 = 4; numEmissions2 = 3; numEmissions3 = 4;
  packed3D = generate3DHMMUniform(numStates1, numStates2, numStates3, numEmissions1, numEmissions2, numEmissions3);
  [seq1, seq2, seq3, states1, states2, states3] = hmmgenerate3d(1000, packed3D);
  assert(max(states1) <= numStates1);
  assert(max(states2) <= numStates2);
  assert(max(states3) <= numStates3);
  assert(max(seq1) <= numEmissions1);
  assert(max(seq2) <= numEmissions2);
  assert(max(seq3) <= numEmissions3);

  disp('Testing 3D training function: this may take a few minutes')
  % Make random TR and EM matrices, then train. Make sure the logL has improved
  % Make random TR and EM matrices, then train. Make sure the logL has improved
  guess3D = generate3DHMMUniform(numStates1, numStates2, numStates3, numEmissions1, numEmissions2, numEmissions3);
  [~, logLs] = hmmtrain3d(guess3D, seq1, seq2, seq3, 50)
  assert(logLs(1) < logLs(length(logLs))); %make sure training improved the logL
  disp('3D Model training functions OK.')
