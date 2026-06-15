function validate_quality_results_table(results)
if ~istable(results)
    error('results must be a MATLAB table.');
end
required = {'target_SNR_dB'};
missing = setdiff(required, results.Properties.VariableNames);
if ~isempty(missing)
    error('results is missing required columns: %s', strjoin(missing, ', '));
end
end
