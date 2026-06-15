function [recall, precision, mae, p95] = local_match_onsets_public(clean_onsets, noisy_onsets, fs, tol_s)
if isempty(clean_onsets) || isempty(noisy_onsets)
    recall = NaN; precision = NaN; mae = NaN; p95 = NaN;
    return;
end

tol = round(tol_s * fs);
clean_onsets = clean_onsets(:);
noisy_onsets = noisy_onsets(:);
matched_noisy = false(size(noisy_onsets));
errs = [];

for i = 1:numel(clean_onsets)
    [d, idx] = min(abs(noisy_onsets - clean_onsets(i)));
    if d <= tol && ~matched_noisy(idx)
        matched_noisy(idx) = true;
        errs(end+1) = d / fs; %#ok<AGROW>
    end
end

TP = numel(errs);
FN = numel(clean_onsets) - TP;
FP = numel(noisy_onsets) - TP;
recall = TP / max(TP + FN, eps);
precision = TP / max(TP + FP, eps);

if isempty(errs)
    mae = NaN;
    p95 = NaN;
else
    mae = mean(abs(errs));
    p95 = prctile(abs(errs), 95);
end
end
