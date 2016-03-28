Welcome to the NMHS data processing toolbox. This code was used for analyzing data in the paper “Analysis of Neural Circuits with Non-Linear Multi-Dimensional Hidden State Models”. 
Authors: Joshua Slocum and Danil Tyulmankov
Citation: 

The newest version of the code can be found at:
https://github.com/jfslocum/NMHS

FORMATTING CONVENTIONS
- For brevity, all functions use a packed format for input and output of models. Packing and unpacking functions are in the utils folder
- Transfer matrices follow a pattern of "to, from, from...". E.g. tr(i,j,k) is the probability of transitioning to state i given the process is in state j and its neighbor is in state k. Note that this means all rows must sum to 1.
- Emission matrices follow a pattern of "state, emission": em(s, e) is the likelihood of emitting 'e' given state 's'. Note that this means all columns must sum to 1. 
- All data sequences are assumed to be row-vectors. 

%TODO: example?

>> addpath(genpath($path_to_NMHS))
>> 
