function F = fg_pw_h_depth(dsT, fgOpts, ttl)

F = figure();
F.Position(3:4) = fgOpts.fgSz;

nGroups = length(unique(dsT.powerGroup));
colorlist = lines(nGroups);

p = cell(nGroups,1);
for i = 1:nGroups
    t = dsT(dsT.powerGroup==i,:);
    p{i} = plot(t.hatchings, t.depth, 'o-',...
        'Color',colorlist(i,:),'MarkerFaceColor','auto',...
        'linewidth',2);
    hold on;
end

% add legend
lg = legend([p{3} p{2} p{1}],{'70% power', '50% power', '30% power'},...
    'Location','northwest');

% edit
box off;
ax = gca();
xlim([0 250]);
ylim([0 500]);
xlabel('number of hatchings');
ylabel('milled depth (µm)');
ax.FontSize = fgOpts.fsAx;
title(ttl, 'FontSize', fgOpts.fsAx);
end