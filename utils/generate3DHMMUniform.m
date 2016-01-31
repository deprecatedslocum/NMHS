% Generate a full 3DHMM model by sampling each parameter from the uniform distribution and then enforcing the markov property.

%Inputs
% numStates1: number of states for model 1
% numStates2: number of states for model 2
% numStates3: number of states for model 3
% em1: number of emissions for model 1         
% em2: number of emissions for model 2         
% em3: number of emissions for model 3


%Outputs
% packed - the model in packed format
% tr1: transfer matrix for model 1
% tr2: transfer matrix for model 2
% tr3: transfer matrix for model 3
% em1: emission matrix for model 1         
% em2: emission matrix for model 2         
% em3: emission matrix for model 3


function [packed, tr1, tr2, tr3, em1, em2, em3] = generate3DHMMUniform(numStates1, numStates2, numStates3, numEmissions1, numEmissions2, numEmissions3) 
  tr1 = randomMarkovUniform([numStates1, numStates1, numStates2, numStates3]);
  tr2 = randomMarkovUniform([numStates2, numStates2, numStates3, numStates1]);
  tr3 = randomMarkovUniform([numStates3, numStates3, numStates1, numStates2]);
  em1 = randomMarkovUniform([numStates1, numEmissions1]); 
  em2 = randomMarkovUniform([numStates2, numEmissions2]); 
  em3 = randomMarkovUniform([numStates3, numEmissions3]); 
  packed = pack3DHMM(tr1, tr2, tr3, em1, em2, em3); 
