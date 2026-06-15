function fig = plot_state_psd_quantiles(Q, title_string, max_freq_bins)
if nargin < 3, max_freq_bins = 60; end
fig = figure();
ax = axes(fig); hold(ax, 'on');
CT = lines(4);
states = {'S1','S2','diastole','systole'};
markers = {'o','s','v','d'};
labels = {'S1','S2','diastole','systole'};
handles = gobjects(1,4);
for i = 1:numel(states)
    st = states{i};
    if ~isfield(Q, st) || isempty(Q.(st)), continue; end
    q = Q.(st);
    freqs = Q.freqs;
    nn = min(max_freq_bins, size(q,1));
    x = freqs(1:nn)';
    x2 = [x, fliplr(x)];
    low = 10.*log10(q(1:nn,1))';
    med = 10.*log10(q(1:nn,2));
    high = 10.*log10(q(1:nn,3))';
    inBetween = [low, fliplr(high)];
    fill(x2, inBetween, CT(i,:), 'FaceAlpha', 0.25, 'LineStyle','none', 'Parent',ax, 'HandleVisibility','off');
    handles(i) = plot(x, med, ['-' markers{i}], 'Color','k', 'MarkerFaceColor',CT(i,:), ...
        'LineWidth',1.5, 'Parent',ax);
end
xlabel(ax, 'Frequency (Hz)');
ylabel(ax, '10log10 PSD (arb)');
title(ax, title_string);
legend(ax, handles(isgraphics(handles)), labels(isgraphics(handles)), 'Box','off');
grid(ax, 'on');
end
