function [seq1, seq2, seq3, states1, states2, states3] = hmmgenerate3d(L,tr1,tr2,tr3,e1,e2,e3)
% Analogous to hmmgenerate. Used for generating "fake" neuronal data for testing
% hmmtrain3d. Works similar to hmmgenerate2d. There is a crucial difference which 
% is that dimensions 1 and 2 are transposed, so that state indices can be read as 
% [to, from, from, from]
%
%
% tr1 is NxNxMxP, tr2 is MxMxPxN, tr3 is PxPxNxM
% e1 is Nx(max # of spikes per bin), e2 is Mx(max # spikes per bin), e3 is Px

seq1 = zeros(1,L);
seq2 = zeros(1,L);
seq3 = zeros(1,L);
states1 = zeros(1,L); 
states2 = zeros(1,L);
states3 = zeros(1,L);

% TODO - assuming inputs are valid for now
% % tr must be square
numStates1 = size(tr1,1); 
numStates2 = size(tr2,1);
numStates3 = size(tr3,1); 
% checkTr = size(tr1,2);
% if checkTr ~= numStates
%     error(message('stats:hmmgenerate:BadTransitions'));
% end
% 
% % number of rows of e must be same as number of states
% checkE = size(e,1);
% if checkE ~= numStates
%     error(message('stats:hmmgenerate:InputSizeMismatch'));
% end

numEmissions1 = size(e1,2);
numEmissions2 = size(e2,2);
numEmissions3 = size(e3,2);

% TODO create numberOfNeurons + 1 random sequences, numberOfNeurons for 
% state changes, one for emission
% statechange = rand(1,L);
% randvals = rand(1,L);

% calculate cumulative probabilities
trc1 = cumsum(tr1, 1);
trc2 = cumsum(tr2, 1);
trc3 = cumsum(tr3, 1);
ec1 = cumsum(e1,2);
ec2 = cumsum(e2,2);
ec3 = cumsum(e3,2);


% TODO - assuming inputs are valid for now
% normalize these just in case they don't sum to 1.
% trc1 = trc1./repmat(trc1(:,end),1,numStates);
% ec1 = ec1./repmat(ec1(:,end),1,numEmissions);

% Assume that we start in state 1.
currentstate1 = 1;
currentstate2 = 1;
currentstate3 = 1;

% main loop 
for count = 1:L
    % calculate state transition for n1
    stateVal = rand; %TODO - make random vector like in original code?
    state1 = 1;
    for innerState = numStates1-1:-1:1
        trc = trc1(:,currentstate1, currentstate2, currentstate3);
        if stateVal > trc(innerState)
            state1 = innerState + 1;
            break;
        end
    end

    % calculate state transition for n2
    stateVal = rand; %TODO - make random vector like in original code?
    state2 = 1;
    for innerState = numStates2-1:-1:1
        trc = trc2(:,currentstate2, currentstate3, currentstate1);
        if stateVal > trc(innerState)
            state2 = innerState + 1;
            break;
        end
    end

    % calculate state transition for n3
    stateVal = rand; %TODO - make random vector like in original code?
    state3 = 1;
    for innerState = numStates3-1:-1:1
        trc = trc3(:,currentstate3, currentstate1, currentstate2);
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



