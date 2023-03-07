function fg = fg_meshgridAngles(angles, heights, maxDist, ttl, meanTiltAngle, fOpts)

% some prior calculations
nAngles = length(angles);
nHeights = length(heights);

% base of the triangle of the excess side
bases = heights .* tan(deg2rad(angles));

% minimal dist between two pillars
D = 2.*bases;

% prep meshgrids
[A,H] = meshgrid(angles,heights);
distLimits = [0 maxDist];

% plot
fg = figure();
fg.Position(3:4) = fOpts.fgSz + [200 0];
p = pcolor(H,A,D);
c = colorbar;
ax = gca;

hold on;

% add horizontal line at average tilt
msg = [num2str(meanTiltAngle,2) '°'];
yline(meanTiltAngle,'--','Color','w',...
    'LineWidth',2,'Label',msg, ...
    'LabelHorizontalAlignment','left', ...
    'FontSize',fOpts.fsAx);


% edit
fg.Colormap = turbo(length(fg.Colormap));
ax.CLim = distLimits;
p.EdgeColor = 'none';
p.FaceColor = 'interp';
c.FontSize = fOpts.fsAx;
c.Label.String = 'separation between pillars (µm)';
c.Label.FontSize = fOpts.fsAx;
xlim([min(heights) max(heights)]);
ylim([min(angles) max(angles)]);
xlabel('pillar height (µm)','FontSize',fOpts.fsAx);
ylabel('milling angle (°)','FontSize',fOpts.fsAx);
ax.FontSize = fOpts.fsAx;
title(ttl, 'FontSize', fOpts.fsT);
box off;
axis square;
end