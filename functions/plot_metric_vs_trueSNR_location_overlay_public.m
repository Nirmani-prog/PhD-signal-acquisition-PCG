function hLine = plot_metric_vs_trueSNR_location_overlay_public(ax, results, field, xfield, use_ms, line_color)
x = double(results.(xfield));
y = double(results.(field));
if use_ms, y = y * 1000; end
m = isfinite(x) & isfinite(y);
x = x(m); y = y(m);
if isempty(x)
    hLine = gobjects(1);
    return;
end

show_scatter = true;
nbins = 8;
min_per_bin = 2;
smooth_curve = true;
smooth_span = 3;
alpha_fill = 0.12;

if numel(x) < max(6, min_per_bin)
    hLine = gobjects(1);
    return;
end

[x, idx] = sort(x);
y = y(idx);
if show_scatter
    plot(ax, x, y, 'x', 'Color', line_color, 'HandleVisibility','off');
end

edges = quantile(x, linspace(0, 1, nbins + 1));
edges = unique(edges);
nbins_eff = numel(edges) - 1;
if nbins_eff < 3
    hLine = gobjects(1);
    return;
end

xmid = nan(nbins_eff,1);
ymed = nan(nbins_eff,1);
yq25 = nan(nbins_eff,1);
yq75 = nan(nbins_eff,1);
for b = 1:nbins_eff
    inb = (x >= edges(b) & x < edges(b+1));
    if b == nbins_eff
        inb = (x >= edges(b) & x <= edges(b+1));
    end
    xx = x(inb);
    yy = y(inb);
    if numel(yy) >= min_per_bin
        xmid(b) = median(xx);
        ymed(b) = median(yy, 'omitnan');
        yq25(b) = prctile(yy, 25);
        yq75(b) = prctile(yy, 75);
    end
end

v = isfinite(xmid) & isfinite(ymed) & isfinite(yq25) & isfinite(yq75);
xmid = xmid(v); ymed = ymed(v); yq25 = yq25(v); yq75 = yq75(v);
if numel(xmid) < 3
    hLine = gobjects(1);
    return;
end

if smooth_curve
    ymed_s = movmedian(ymed, smooth_span, 'omitnan');
    yq25_s = movmedian(yq25, smooth_span, 'omitnan');
    yq75_s = movmedian(yq75, smooth_span, 'omitnan');
else
    ymed_s = ymed; yq25_s = yq25; yq75_s = yq75;
end

Xp = [xmid; flipud(xmid)];
Yp = [yq25_s; flipud(yq75_s)];
hp = fill(ax, Xp, Yp, line_color, 'LineStyle','none', 'HandleVisibility','off');
set(hp, 'FaceAlpha', alpha_fill);
hLine = plot(ax, xmid, ymed_s, '--', 'LineWidth', 1.5, 'Color', line_color);
end
