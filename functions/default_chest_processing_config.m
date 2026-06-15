function cfg = default_chest_processing_config()
cfg = struct();
cfg.quantile_steps = [0.1 0.5 0.9];
cfg.max_freq_bins = 60;
cfg.title_string = 'PCG state PSD quantiles';
end
