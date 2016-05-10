Welcome to the NMHS data processing toolbox. This code was used for analyzing data in the paper “Analysis of Complex Neural Networks with Non-Linear Multi-Dimensional Hidden State Models”. 
Authors: Joshua Slocum and Danil Tyulmankov
Citation: 

The newest version of the code can be found at:
https://github.com/jfslocum/NMHS 

FORMATTING CONVENTIONS
- For brevity, all functions use a packed format for input and output of models. Packing and unpacking functions are in the utils folder
- Transfer matrices follow a pattern of "to, from, from...". E.g. tr(i,j,k) is the probability of transitioning to state i given the process is in state j and its neighbor is in state k. Note that this means all rows must sum to 1.
- Emission matrices follow a pattern of "state, emission": em(s, e) is the likelihood of emitting 'e' given state 's'. Note that this means all columns must sum to 1. 
- All data sequences are assumed to be row-vectors. 



LICENSE AGREEMENT
M.I.T. desires to aid the academic and non-commercial research community while also raising awareness of our technology for potential commercial licensing and therefore agrees herein to grant a limited copyright license to the copyright-protected software for research and non-commercial purposes only, reserving and retaining all ownership rights and license in and to the intellectual property for all other uses.
 
Thus, subject to the terms herein, M.I.T.  grants a royalty-free, non-transferable, non-exclusive license under its copyrights to use, reproduce, display, perform and modify the software solely for non-commercial research and/or academic testing purposes.   In order to obtain any other license rights, including the right to use the software or filed patents for commercial purposes, you must contact the M.I.T. Technology Licensing Office and enter into additional license agreements with M.I.T.
