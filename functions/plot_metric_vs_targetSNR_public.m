function plot_metric_vs_targetSNR_public(results, field, ttl, use_ms)
if nargin < 4, use_ms = false; end
x = results.target_SNR_dB;
y = results.(field);
if use_ms
    y = y * 1000;
    ylab = [field ' (ms)'];
else
    ylab = field;
end

Suniq = unique(x);
ymed = nan(size(Suniq));
yq25 = nan(size(Suniq));
yq75 = nan(size(Suniq));
for i = 1:numel(Suniq)
    yy = y(x == Suniq(i));
    ymed(i) = median(yy, 'omitnan');
    yq25(i) = prctile(yy, 25);
    yq75(i) = prctile(yy, 75);
end

hold on; grid on;
plot(Suniq, ymed, '-o', 'LineWidth', 1.5);
for i = 1:numel(Suniq)
    plot([Suniq(i) Suniq(i)], [yq25(i) yq75(i)], '-', 'HandleVisibility','off');
end
xlabel('Target SNR (dB)');
ylabel(ylab);
title(ttl, 'Interpreter','none');
end
