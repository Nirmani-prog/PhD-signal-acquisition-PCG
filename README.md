# PhD-signal-acquisition-PCG
These are a few sample scripts from my PhD thesis in signal acquisition. 
These are my own scripts that were part of a lab. Any internal call to the Supabase database and personal file directories have been removed.

This repository contains a cleaned public-facing MATLAB version of a phonocardiogram (PCG) analysis workflow for studying how segmentation quality changes with noise level and signal quality. The code is adapted from internal PhD analysis scripts and reorganized for portfolio use.
What this repo shows
•	PCG segmentation/state-based spectral analysis
•	PSD quantile visualization for S1, S2, systole, and diastole
•	Signal-to-noise ratio (SNR) analysis using heart-sound vs noise segments
•	Segmentation quality evaluation using recall, precision, MAE, and percentile timing error
•	Visualization of how model quality changes with target and measured SNR
Main scripts
•	run_chest_processing_demo.m — example preprocessing / PSD quantile workflow using segmented heart sound states
•	run_threshold_analysis_demo.m — computes summary SNR and event-matching metrics
•	run_replot_quality_vs_snr_demo.m — plots recall / MAE / agreement trends against target or measured SNR
Folder structure
•	functions/ — reusable helper functions
•	data/ — place small example .mat or .csv files here
•	results/ — generated figures and summary tables
Data
The original research pipeline used internal loaders and database-backed metadata. Those dependencies have been removed here and replaced with local-file placeholders so the workflow is easier to understand and adapt.
To run this repo, prepare local MATLAB tables/structures with fields similar to the examples below:
Expected segmented state table
A table called segments with columns such as:
•	state — string/categorical labels like "S1", "S2", "systole", "diastole"
•	freqs — frequency vector per segment
•	PSD — PSD vector per segment
Expected quality results table
A table called results with columns such as:
•	target_SNR_dB
•	SNRband_S1_dB, SNRband_S2_dB
•	recall_S1, recall_S2
•	precision_S1, precision_S2
•	MAE_S1, MAE_S2
•	location
How to run
1.	Open MATLAB.
2.	Add the repository root and functions/ folder to the path.
3.	Place example data in data/.
4.	Run one of the demo scripts:
run('run_chest_processing_demo.m')
run('run_threshold_analysis_demo.m')
run('run_replot_quality_vs_snr_demo.m')

Notes
•	Hard-coded private paths and internal database calls were removed.
•	The public version is designed as a portfolio/reproducibility example rather than the exact internal thesis pipeline.
•	If needed, the local-file loaders can be replaced with your own dataset access functions.

