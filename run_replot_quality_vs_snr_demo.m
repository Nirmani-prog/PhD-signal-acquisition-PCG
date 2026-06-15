%% Replot quality vs SNR demo
clear; close all; clc;
addpath(genpath('functions'));

input_file = fullfile('data', 'quality_results_example.mat');
output_dir = 'results';
if ~exist(output_dir, 'dir'), mkdir(output_dir); end

results = load_quality_results_example(input_file);
validate_quality_results_table(results);

fig1 = figure;
plot_metric_vs_targetSNR_public(results, 'recall_S1', 'Recall S1 vs target SNR', false);
saveas(fig1, fullfile(output_dir, 'recall_S1_vs_targetSNR.png'));

fig2 = figure;
plot_metric_vs_targetSNR_public(results, 'MAE_S1', 'MAE S1 vs target SNR', true);
saveas(fig2, fullfile(output_dir, 'MAE_S1_vs_targetSNR.png'));

if all(ismember({'location','SNRband_S1_dB','SNRband_S2_dB','recall_S1','MAE_S1'}, results.Properties.VariableNames))
    fig3 = plot_recall_by_location_2x1_public(results, ...
        'recall_S1', 'SNRband_S1_dB', 'SNRband_S2_dB', 'aortic', 'tricuspid');
    saveas(fig3, fullfile(output_dir, 'recall_by_location.png'));
end

summary_tbl = summarize_quality_metrics_by_targetSNR(results, {'recall_S1','MAE_S1'});
writetable(summary_tbl, fullfile(output_dir, 'quality_summary_by_targetSNR.csv'));
