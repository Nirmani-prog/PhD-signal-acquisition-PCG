function segments = load_segments_example(input_file)
if ~exist(input_file, 'file')
    error('Missing example file: %s', input_file);
end
S = load(input_file);
if ~isfield(S, 'segments')
    error('Expected variable "segments" in MAT file.');
end
segments = S.segments;
end
