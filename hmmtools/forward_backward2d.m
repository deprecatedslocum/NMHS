% forward_backward2d.m
% Author: Joshua Slocum
% Implements the forward-backward algorithm for 2-dimensional HMM's
% (see http://en.wikipedia.org/wiki/Forward%E2%80%93backward_algorithm ) 


function [forward_probabilities, backward_probabilities, normalization_factors] = forward_backward2d(tr1, tr2, em1, em2, seq1, seq2)
  num_states1 = size(tr1, 1);
  num_states2 = size(tr2, 1);  

  % add extra symbols to start to make algorithm cleaner at f0 and b0
  seq1 = [1, seq1];
  seq2 = [1, seq2];
  L = length(seq1);

  forward_probabilities = zeros(num_states1, num_states2, L);
  forward_probabilities(1,1,1) = 1;
  normalization_factors = zeros(1, L);
  normalization_factors(1) = 1;
  for count = 2:L
    for state1 = 1:num_states1
      for state2 = 1:num_states2
        forward_probabilities(state1, state2, count) = ...
        em1(state1, seq1(count)) * em2(state2, seq2(count)) * ...
        sum(sum(forward_probabilities(:,:,count-1) .* ...
                squeeze(tr1(:, state1, :)) .* ...
                transpose(squeeze(tr2(:, state2, :)))));
      end
    end
    normalization_factors(count) = sum(sum(forward_probabilities(:,:,count)));
    forward_probabilities(:,:,count) = ...
    forward_probabilities(:,:,count)./normalization_factors(count);
  end

  backward_probabilities = ones(num_states1, num_states2, L);
  for count = L-1:-1:1
    for state1 = 1:num_states1
      for state2 = 1:num_states2
        backward_probabilities(state1, state2, count) = ...
        sum(sum(...
                 repmat(em1(:,seq1(count+1)), 1, num_states2) .* ...
                repmat(em2(:,seq2(count+1)), 1, num_states1)' .* ...        
                backward_probabilities(:,:,count+1) .* ...
                (transpose(squeeze(tr1(state1, :, state2))) * squeeze(tr2(state2, :, state1)))));
      end
    end
    backward_probabilities(:,:,count) = ...
    backward_probabilities(:,:,count)./normalization_factors(count+1);
  end 
