
% This file runs a series of tests to make sure the library is working properly. 
function tests()
  disp('Testing markov checking functions')
  testMarkovChecking();
  disp('Markov checking functions OK.')
  disp('Testing model verification functions')
  testHMMChecking();
  disp('Model verification functions OK.')
  disp('Testing model creation functions')
  testHMMCreation();
  disp('Model creation functions OK.')
  disp('Testing training functions: this may take a few minutes')
  testHMMTraining();
  disp('Model training functions OK.')
%  testConnectivity();
