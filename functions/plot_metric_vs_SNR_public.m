function fig = plot_metric_vs_SNR_public(results, field, xfield, ttl, use_ms)
if nargin < 5, use_ms = false; end
fig = figure();
ax = axes(fig);
x = results.(xfield);
y = results.(field);
if use_ms, y = y * 1000; end
mask = isfinite(x) & isfinite(y);
x = x(mask); y = y(mask);
[xs, idx] = sort(x);
ys = y(idx);
plot(ax, xs, ys, 'o');
grid(ax, 'on');
xlabel(ax, xfield, 'Interpreter','none');
if use_ms
    ylabel(ax, [field ' (ms)']);
else
    ylabel(ax, field, 'Interpreter','none');
end
title(ax, ttl, 'Interpreter','none');
end
