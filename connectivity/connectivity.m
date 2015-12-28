function [average, inEachState, perNeighborStatePair, detail] = connectivity(trA, trB, plotthis)
% Looks at the level of connectivity between two neurons by comparing the
% layers of the TR matrices. If all the layers are identical, the neurons
% are probably not connected. If each layer is different from all the
% others, that means neuron A obeys a different TR matrix for each of the
% states that neuron B is in, and vice versa.
%
% Note that this calculates the dependence of neuron A on B. To get the
% dependence of B on A, switch the input arguments. 
%
% The "plotthis" argument is a boolean that indicates whether to make a
% visualization of the calculated data. It is on by default if the argument
% is not provided.
%
% Let trA be NxNxM and trB be MxMxN. Then:
% average = a single number between 0 and 1 that describes "averaging over 
%           all states of neuron 1, how much does it listen to neuron 2"
% details = a Nx(M-choose-2) matrix, where entry (i, j) is "when neuron 1
%           is in state i, how well does it differentiate between states x 
%           and y of neuron2"
% inEachState = a length-N column vector, where entry i is a number between 
%               0 and 1 that describes "when neuron 1 is in state i, 
%               how much does it listen to neuron 2"
% perNeighborStatePair = a length-(M-choose-2) row vector, where entry
%                        i describes "overall, how well does neuron 1 
%                        differentiate between states x and y of neuron 2."
%                        The order for x&y pairs in the vector is as follows:
%                        1&2,1&3,...,1&M,2&3,...2&M,...,(M-1)&M                       

%% Calculate the values
%make sure dimensions match up
[N,M] = checkDims(trA, trB);

detail = NaN(N, nchoosek(M, 2));
pairNumber = 0;

%Note: nchoosek(vector, integer) only practical for small vectors (<15 elts)
%      But this is ok for now since M is on the order of 3-5 at most.
%      (can't make it any larger for training to run in a reasonable amount
%      of time...)
for pair = nchoosek(1:M, 2)'
    pairNumber = pairNumber + 1;
    layer1 = trA(:,:,pair(1));
    layer2 = trA(:,:,pair(2));
    diff = abs(layer1-layer2);
    
    %normalize by 2 because the highest possible value in a row is 2, 
    %since each row in layer1 and layer2 sums to 1
    conn = sum(diff,2)/2; 
    
    detail(:,pairNumber) = conn;   
end

if any(isnan(detail)) %sanity check. TODO: remove this?
    error('Error constructing the connectivity matrix')
end

inEachState = mean(detail, 2);
perNeighborStatePair = mean(detail, 1);
average = mean(inEachState);


%% Visualize the data
if nargin > 2
    if ~plotthis
        return
    end
end

colorMapSize = 100;

ax = subplot(2,2,3);
image(detail*colorMapSize)
title('Sensitivity to differences in neighbor''s states in each state')
xlabel('Neighbor''s state pair')
xlabels = makeXLabels(M);
set(ax,'XTickLabel',xlabels);
set(ax,'YTick',1:N);
ylabel('State number')

ax = subplot(2,2,4); 
barh(1:N, inEachState)
title('Average connectivity in each state')
ylabel('State number')
xlabel('Percent connectivity')

ax = subplot(2,2,1);
bar(1:nchoosek(M,2), perNeighborStatePair)
set(ax,'XTickLabel',xlabels);
title('Average sensitivity to differences in neighbor''s states')
xlabel('Neighbor''s state pair')
ylabel('Percent sensitivity')

ax = subplot(2,2,2);
image(average*colorMapSize)
colorbar SouthOutside
title('Overall average connectivity'), 
text(0.9,1, num2str(average));
set(ax,'XTickLabel',[]);
set(ax,'YTickLabel',[]);

colormap(flipud(summer(colorMapSize)))



function labels = makeXLabels(M)
labels = cell(1,3);
idx = 0;
for pair = nchoosek(1:M, 2)'
    idx = idx+1;
    labels{idx} = [num2str(pair(1)) '&' num2str(pair(2))];
end

























