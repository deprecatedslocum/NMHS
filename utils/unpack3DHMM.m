function [tr1, tr2, tr3, em1, em2, em3] = unpack3DHMM(packed_hmm)
  states1 = packed_hmm(1,1,1); 
  states2 = packed_hmm(2,1,1); 
  states3 = packed_hmm(3,1,1); 
  emissions1 = packed_hmm(4,1,1); 
  emissions2 = packed_hmm(5,1,1); 
  emissions3 = packed_hmm(6,1,1);   

  x_offset = 1;
  tr1 = packed_hmm(1:states1, x_offset+1:x_offset+states1, 1:states2, 1:states3);
  x_offset = x_offset + states1;

  tr2 = packed_hmm(1:states2, x_offset+1:x_offset+states2, 1:states3, 1:states1);
  x_offset = x_offset + states2;
  
  tr3 = packed_hmm(1:states3, x_offset+1:x_offset+states3, 1:states1, 1:states2);
  x_offset = x_offset + states3;
  
  em1 = packed_hmm(1:states1, x_offset+1:x_offset+emissions1, 1);
  x_offset = x_offset + emissions1;
  
  em2 = packed_hmm(1:states2, x_offset+1:x_offset+emissions2, 1);
  x_offset = x_offset + emissions2;
  
  em3 = packed_hmm(1:states3, x_offset+1:x_offset+emissions3, 1);
  
