function [seq1, seq2, states1, states2] = hmmgenerate2d(L,tr1,tr2,e1,e2)
% Analogous to hmmgenerate. Used for generating "fake" neuronal data for testing
% hmmtrain2d. Assumes the neurons function as follows: if neuron A is in
% state 1, then neuron B uses the 1st layer of its transition matrix to
% generate the next hidden state and corresponding observation in the
% *next* step. The same holds in the other direction - state of B controls
% the *next* state of A.
%
% for a 2D HMM with N states, tr must be NxNxN and there needs to be a 
% tr matrix for each neuron
%
% s(n1, t) = state of neuron n1 at time t
% tr(i,j,k) = Pr(s(n1,t) = k | s(n1,t-1) = i, s(n2,t-1) = j) 
%
% tr1 is NxNxM, tr2 is MxMxN 
% e1 is Nx(max # of spikes per bin), e2 is Mx(max # spikes per bin)

seq1 = zeros(1,L);
seq2 = zeros(1,L);
states1 = zeros(1,L); 
states2 = zeros(1,L);

% TODO - assuming inputs are valid for now
% % tr must be square
numStates1 = size(tr1,1); 
numStates2 = size(tr2,1); 
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

% TODO create numberOfNeurons + 1 random sequences, numberOfNeurons for 
% state changes, one for emission
% statechange = rand(1,L);
% randvals = rand(1,L);

% calculate cumulative probabilities
trc1 = cumsum(tr1, 2);
trc2 = cumsum(tr2, 2);
ec1 = cumsum(e1,2);
ec2 = cumsum(e2,2);

% TODO - assuming inputs are valid for now
% normalize these just in case they don't sum to 1.
% trc1 = trc1./repmat(trc1(:,end),1,numStates);
% ec1 = ec1./repmat(ec1(:,end),1,numEmissions);

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



