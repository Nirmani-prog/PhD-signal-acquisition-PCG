function summary_tbl = summarize_state_segment_counts(segments)
states = string(segments.state);
[u,~,idx] = unique(states);
counts = accumarray(idx, 1);
summary_tbl = table(u, counts, 'VariableNames', {'state','n_segments'});
end
