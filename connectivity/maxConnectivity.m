function conn = maxConnectivity(trA, trB)
% Calculates connectivity "how much A listens to B" by taking the max 
% connectivity across all states of node A (as opposed to connectivity.m 
% which looks at the average)

[~, inEachState, ~, ~] = connectivity(trA, trB, false);
conn = max(inEachState);























