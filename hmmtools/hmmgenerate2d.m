% Given a 2d hmm model, generates a sequence of data of specified length
% Author: Joshua Slocum

% Inputs:
% L: the length of the data sequence to be generated
% packed_2d_hmm: see utils/pack2DHNM.m for more details

% Outputs:
% seq1: the emissions of model 1
% seq2: the emissions of model 2
% states1: the states of model 1
% states2: the states of model 2



function [seq1, seq2, states1, states2] = hmmgenerate2d(L,packed_2d_hmm)

[tr1, tr2, em1, em2] = unpack2DHMM(packed_2d_hmm);

         
seq1 = zeros(1,L);
seq2 = zeros(1,L);
states1 = zeros(1,L); 
states2 = zeros(1,L);

numStates1 = size(tr1,1); 
numStates2 = size(tr2,1); 

numEmissions1 = size(e1,2);
numEmissions2 = size(e2,2);


% calculate cumulative probabilities
trc1 = cumsum(tr1, 2);
trc2 = cumsum(tr2, 2);
ec1 = cumsum(e1,2);
ec2 = cumsum(e2,2);


% Start in a random state.
currentstate1 = ceil(rand*numStates1);
currentstate2 = ceil(rand*numStates2);

% main loop 
for count = 1:L
    % calculate state transition for n1
    stateVal = rand; %TODO - make random vector like in original code?
    state1 = 1;
    for innerState = numStates1-1:-1:1
        trc = trc1(:,:,currentstate2);
        if stateVal > trc(currentstate1,innerState)
            state1 = innerState + 1;
            break;
        end
    end
    
    % calculate state transition for n2
    stateVal = rand; %TODO-make rand vector like in original code=>faster?
    state2 = 1;
    for innerState = numStates2-1:-1:1
        trc = trc2(:,:,currentstate1);
         if stateVal > trc(currentstate2,innerState)
            state2 = innerState + 1;
            break;
        end
    end
     
    % calculate emission for n1
    val = rand;
    emit1 = 1;
    for inner = numEmissions1-1:-1:1
        if val  > ec1(state1,inner)
            emit1 = inner + 1;
            break
        end
    end
    
    % calculate emission for n2
    val = rand;
    emit2 = 1;
    for inner = numEmissions2-1:-1:1
        if val  > ec2(state2,inner)
            emit2 = inner + 1;
            break
        end
    end
    
    % add values and states to output
    seq1(count) = emit1;
    seq2(count) = emit2;
    states1(count) = state1;
    currentstate1 = state1;
    states2(count) = state2;
    currentstate2 = state2;
    
end



