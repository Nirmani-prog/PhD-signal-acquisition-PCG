function summary_tbl = summarize_quality_metrics_by_targetSNR(results, metric_fields)
Suniq = unique(results.target_SNR_dB);
summary_tbl = table(Suniq, 'VariableNames', {'target_SNR_dB'});
for j = 1:numel(metric_fields)
    field = metric_fields{j};
    medv = nan(size(Suniq));
    for i = 1:numel(Suniq)
        yy = results.(field)(results.target_SNR_dB == Suniq(i));
        medv(i) = median(yy, 'omitnan');
    end
    summary_tbl.([field '_median']) = medv;
end
end
