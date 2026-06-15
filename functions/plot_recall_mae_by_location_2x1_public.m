function fig = plot_recall_mae_by_location_2x1_public(results, recall_field, mae_field, xfield1, xfield2, loc1, loc2)
loc_col = lower(string(results.location));
mask1 = loc_col == lower(loc1);
mask2 = loc_col == lower(loc2);
R1 = results(mask1,:);
R2 = results(mask2,:);

fig = figure;
t = tiledlayout(1,2,'TileSpacing','compact','Padding','compact'); %#ok<NASGU>
colors = lines(2);

ax1 = nexttile;
hold(ax1,'on'); grid(ax1,'on');
h1 = plot_metric_vs_trueSNR_location_overlay_public(ax1, R1, recall_field, xfield1, false, colors(1,:));
h2 = plot_metric_vs_trueSNR_location_overlay_public(ax1, R2, recall_field, xfield1, false, colors(2,:));
ylabel(ax1, strrep(recall_field,'_',' '));
xlabel(ax1, 'True S1 SNR (dB)');
title(ax1, 'Recall S1', 'Interpreter','none');
legend(ax1, [h1 h2], {loc1, loc2}, 'Interpreter','none', 'Location','best');
legend(ax1,'boxoff');

ax2 = nexttile;
hold(ax2,'on'); grid(ax2,'on');
h3 = plot_metric_vs_trueSNR_location_overlay_public(ax2, R1, recall_field, xfield2, false, colors(1,:));
h4 = plot_metric_vs_trueSNR_location_overlay_public(ax2, R2, recall_field, xfield2, false, colors(2,:));
ylabel(ax2, strrep(recall_field,'_',' '));
xlabel(ax2, 'True S2 SNR (dB)');
title(ax2, 'Recall S2', 'Interpreter','none');
legend(ax2, [h3 h4], {loc1, loc2}, 'Interpreter','none', 'Location','best');
legend(ax2,'boxoff');
sgtitle('Recall by location');
end
