%% Threshold / SNR analysis demo
clear; close all; clc;
addpath(genpath('functions'));

input_file = fullfile('data', 'threshold_example.mat');
output_dir = 'results';
if ~exist(output_dir, 'dir'), mkdir(output_dir); end

S = load_threshold_example(input_file);
[snrS1_dB, snrS2_dB, snrMin_dB, snrMax_dB] = compute_band_snr_metrics(...
    S.dia, S.qS1, S.qS2, S.band_mask);

metrics_tbl = table(snrS1_dB, snrS2_dB, snrMin_dB, snrMax_dB);

if all(isfield(S, {'clean_onsets','noisy_onsets','fs','tol_s'}))
    [recall, precision, mae, p95] = local_match_onsets_public(...
        S.clean_onsets, S.noisy_onsets, S.fs, S.tol_s);
    metrics_tbl.recall = recall;
    metrics_tbl.precision = precision;
    metrics_tbl.mae_s = mae;
    metrics_tbl.p95_s = p95;
end

writetable(metrics_tbl, fullfile(output_dir, 'threshold_metrics_summary.csv'));
disp(metrics_tbl);
