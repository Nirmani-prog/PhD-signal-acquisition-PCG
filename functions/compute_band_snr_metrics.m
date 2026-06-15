function [snrS1_dB, snrS2_dB, snrMin_dB, snrMax_dB] = compute_band_snr_metrics(dia, qS1, qS2, band_mask)
noisePSDs = cell2mat(dia.PSD')';
qN = quantile(noisePSDs, [0.1 0.5 0.9])';
noise_med = qN(:,2);

snr_med_S1 = qS1(:,2) ./ max(noise_med, eps);
snr_med_S2 = qS2(:,2) ./ max(noise_med, eps);

snrS1_dB = 10 * log10(mean(snr_med_S1(band_mask), 'omitnan'));
snrS2_dB = 10 * log10(mean(snr_med_S2(band_mask), 'omitnan'));
snrMin_dB = min([snrS1_dB, snrS2_dB], [], 'omitnan');
snrMax_dB = max([snrS1_dB, snrS2_dB], [], 'omitnan');
end
