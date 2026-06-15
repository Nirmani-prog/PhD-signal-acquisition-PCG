function validate_segments_table(segments)
if ~istable(segments)
    error('segments must be a MATLAB table.');
end
required = {'state','freqs','PSD'};
missing = setdiff(required, segments.Properties.VariableNames);
if ~isempty(missing)
    error('segments is missing required columns: %s', strjoin(missing, ', '));
end
end
