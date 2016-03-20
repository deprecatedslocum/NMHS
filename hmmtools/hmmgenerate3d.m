function [seq1, seq2, seq3, states1, states2, states3] = hmmgenerate3d(L,packed_3d_hmm)
[tr1, tr2, tr3,  em1, em2, em3] = unpack3DHMM(packed_3d_hmm);
% Given a 3d hmm model, generates a sequence of data of specified length
%
% Inputs:
% L: the length of the data sequence to be generated
% packed_3d_hmm: the 3d hmm model with which to begin training. See utils/pack3DHMM.m for more details.
%
% Outputs:
% seq1: the emissions of model 1
% seq2: the emissions of model 2
% seq3: the emissions of model 3
% states1: the state of model 1
% states2: the state of model 2
% states3: the state of model 3
%
% Authors: Joshua Slocum, Danil Tyulmankov, Alexander Friedman; Copyright 2016

seq1 = zeros(1,L);
seq2 = zeros(1,L);
seq3 = zeros(1,L);
states1 = zeros(1,L);
states2 = zeros(1,L);
states3 = zeros(1,L);

numStates1 = size(tr1,1);
numStates2 = size(tr2,1);
numStates3 = size(tr3,1);

numEmissions1 = size(em1,2);
numEmissions2 = size(em2,2);
numEmissions3 = size(em3,2);


% calculate cumulative probabilities
trc1 = cumsum(tr1, 2);
trc2 = cumsum(tr2, 2);
trc3 = cumsum(tr3, 2);
ec1 = cumsum(em1,2);
ec2 = cumsum(em2,2);
ec3 = cumsum(em3,2);



% Assume that we start in state 1.
currentstate1 = 1;
currentstate2 = 1;
currentstate3 = 1;

% main loop
for count = 1:L
    % calculate state transition for n1
    stateVal = rand;
    state1 = 1;
    for innerState = numStates1-1:-1:1
        trc = trc1(currentstate1, :, currentstate2, currentstate3);
        if stateVal > trc(innerState)
            state1 = innerState + 1;
            break;
        end
    end
    
    % calculate state transition for n2
    stateVal = rand;
    state2 = 1;
    for innerState = numStates2-1:-1:1
        trc = trc2(currentstate2, :, currentstate3, currentstate1);
        if stateVal > trc(innerState)
            state2 = innerState + 1;
            break;
        end
    end
    
    % calculate state transition for n3
    stateVal = rand;
    state3 = 1;
    for innerState = numStates3-1:-1:1
        trc = trc3(currentstate3, :, currentstate1, currentstate2);
        if stateVal > trc(innerState)
            state3 = innerState + 1;
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
    
    % calculate emission for n3
    val = rand;
    emit3 = 1;
    for inner = numEmissions3-1:-1:1
        if val  > ec3(state2,inner)
            emit3 = inner + 1;
            break
        end
    end
    
    
    % add values and states to output
    seq1(count) = emit1;
    seq2(count) = emit2;
    seq3(count) = emit3;
    states1(count) = state1;
    currentstate1 = state1;
    states2(count) = state2;
    currentstate2 = state2;
    states3(count) = state3;
    currentstate3 = state3;
end



