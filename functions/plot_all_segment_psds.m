function fig = plot_all_segment_psds(segments, title_string)
fig = figure();
ax = axes(fig); hold(ax, 'on');
CT = lines(4);
states = {"S1","S2","diastole","systole"};
labels = {'S1','S2','diastole','systole'};
pl = gobjects(1,4);
for s = 1:numel(states)
    T = segments(string(segments.state) == states{s}, :);
    for ii = 1:height(T)
        pl(s) = plot(cell2mat(T.freqs(ii)), 10.*log10(cell2mat(T.PSD(ii))), ...
            'Color', CT(s,:), 'Parent', ax);
    end
end
ylabel(ax,'10log10 PSD (arb)');
xlabel(ax,'Frequency (Hz)');
set(ax,'XScale','log');
legend(pl, labels, 'Location','northeast', 'Box','off');
title(ax, title_string);
grid(ax, 'on');
end
