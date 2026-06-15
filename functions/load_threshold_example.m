function S = load_threshold_example(input_file)
if ~exist(input_file, 'file')
    error('Missing example file: %s', input_file);
end
S = load(input_file);
required = {'dia','qS1','qS2','band_mask'};
for k = 1:numel(required)
    if ~isfield(S, required{k})
        error('Missing variable "%s" in MAT file.', required{k});
    end
end
end
