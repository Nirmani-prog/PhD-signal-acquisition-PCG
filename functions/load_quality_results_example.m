function results = load_quality_results_example(input_file)
if ~exist(input_file, 'file')
    error('Missing example file: %s', input_file);
end
S = load(input_file);
if ~isfield(S, 'results')
    error('Expected variable "results" in MAT file.');
end
results = S.results;
end
