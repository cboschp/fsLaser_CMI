function fg = fg_meshgridAnglesHeight(angles, separations, maxDist, maxHeight, ttl, meanTiltAngle, fOpts)



% some prior calculations
nAngles = length(angles);
% nHeights = length(heights);
nSep = length(separations);

% base of the triangle of the excess side
% bases = heights .* tan(deg2rad(angles));
heights = separations./(2*(deg2rad(angles)));

% minimal dist between two pillars
% D = 2.*bases;

% prep meshgrids
% [A,H] = meshgrid(angles,heights);
[Ds, An] = meshgrid(separations,angles);
distLimits = [0 maxDist];
heightLimits = [0 maxHeight];

% plot
fg = figure();
fg.Position(3:4) = fOpts.fgSz + [200 0];
% p = pcolor(H,A,D);
p = pcolor(An,Ds,heights');
c = colorbar;
ax = gca;

hold on;

% add vertical line at average tilt
msg = [num2str(meanTiltAngle,2) '°'];
xline(meanTiltAngle,'--','Color','w',...
    'LineWidth',2,'Label',msg, ...
    'LabelHorizontalAlignment','left', ...
    'FontSize',fOpts.fsAx);


% edit
fg.Colormap = turbo(length(fg.Colormap));
% ax.CLim = distLimits;
ax.CLim = heightLimits;
p.EdgeColor = 'none';
p.FaceColor = 'interp';
c.Ticks = 0:250:maxHeight;
c.FontSize = fOpts.fsAx;
% c.Label.String = 'separation between pillars (µm)';
c.Label.String = 'pillar height (µm)';
c.Label.FontSize = fOpts.fsAx;
% xlim([min(heights) max(heights)]);
% ylim([min(angles) max(angles)]);
xlim([min(angles) max(angles)]);
ylim(distLimits);
% xlabel('pillar height (µm)','FontSize',fOpts.fsAx);
xlabel('milling angle (°)','FontSize',fOpts.fsAx);
% ylabel('milling angle (°)','FontSize',fOpts.fsAx);
ylabel('separation between pillars (µm)','FontSize',fOpts.fsAx);
ax.FontSize = fOpts.fsAx;
title(ttl, 'FontSize', fOpts.fsT);
box off;
axis square;
end