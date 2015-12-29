function [tr1, tr2, em1, em2] = unpack2DHMM(packed_hmm)
  states1 = packed_hmm(1,1,1);
  states2 = packed_hmm(2,1,1);
  emissions1 = packed_hmm(3,1,1);
  emissions2 = packed_hmm(4,1,1);

  tr1 = packed_hmm(1:states1, 2:1+states1, 1:states2);
  tr2 = packed_hmm(1:states2, 2+states1:1+states1+states2, 1:states1);
  em1 = packed_hmm(1:states1, 2+states1+states2:1+states1+states2+emissions1, 1);
  em2 = packed_hmm(1:states1, 2+states1+states2+emissions1:1+states1+states2+emissions1+emissions2, 1);
