% Generate a full 2DHMM model by sampling each parameter from the uniform distribution and then enforcing the markov property.

%Inputs
% numStates1: number of states for model 1
% numStates2: number of states for model 2
% em1: number of emissions for model 1         
% em2: number of emissions for model 2         


%Outputs
% packed - the model in packed format
% tr1: transfer matrix for model 1
% tr2: transfer matrix for model 2
% em1: emission matrix for model 1         
% em2: emission matrix for model 2         


function [packed, tr1, tr2, em1, em2] = generate2DHMMUniform(numStates1, numStates2, numEmissions1, numEmissions2) 
  tr1 = randomMarkovUniform([numStates1, numStates1, numStates2]);
  tr2 = randomMarkovUniform([numStates2, numStates2, numStates1]);
  em1 = randomMarkovUniform([numStates1, numEmissions1]); 
  em2 = randomMarkovUniform([numStates2, numEmissions2]); 
  packed = pack2DHMM(tr1, tr2, em1, em2); 
