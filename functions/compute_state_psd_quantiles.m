function out = compute_state_psd_quantiles(segments, cfg)
if ~isfield(cfg, 'quantile_steps'), cfg.quantile_steps = [0.1 0.5 0.9]; end
states = ["S1","S2","diastole","systole"];
out = struct();
for i = 1:numel(states)
    st = states(i);
    T = segments(string(segments.state) == st, :);
    if isempty(T)
        out.(st) = [];
        continue;
    end
    psd_mat = cell2mat(T.PSD')';
    out.(st) = quantile(psd_mat, cfg.quantile_steps)';
    out.freqs = cell2mat(T.freqs(1));
end
end
