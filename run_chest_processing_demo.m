%% PCG chest data processing demo
clear; close all; clc;
addpath(genpath('functions'));

input_file = fullfile('data', 'segments_example.mat');
output_dir = 'results';
if ~exist(output_dir, 'dir'), mkdir(output_dir); end

segments = load_segments_example(input_file);
validate_segments_table(segments);

cfg = default_chest_processing_config();
Q = compute_state_psd_quantiles(segments, cfg);
summary_tbl = summarize_state_segment_counts(segments);
writetable(summary_tbl, fullfile(output_dir, 'state_segment_counts.csv'));

fig1 = plot_all_segment_psds(segments, cfg.title_string);
saveas(fig1, fullfile(output_dir, 'all_segment_psds.png'));

fig2 = plot_state_psd_quantiles(Q, cfg.title_string, cfg.max_freq_bins);
saveas(fig2, fullfile(output_dir, 'state_psd_quantiles.png'));
