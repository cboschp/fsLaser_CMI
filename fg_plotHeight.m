function fg = fg_plotHeight(pT,fOpts, ttl)
nSmp = height(pT);

concatT = vertcat(pT.pData{:});
x = concatT(:,{'heights','pName'});

% plot boxplot
fg = figure();
boxplot(x.heights,x.pName);

hold on

% plot data points
d = 0.25; % dispersion, 10% = 0.1
cl = lines(1);
for i = 1:nSmp
    ndp = height(pT.pData{i});
    xx = (i-d/2) + rand(ndp,1).*d;
    yy = pT.pData{i}.heights;
    plot(xx,yy,'o','Color',cl);
end

% plot n
for i = 1:nSmp
    msg = ['n = ' num2str(height(pT.pData{i}))];
    text(i, 100, msg,'FontSize',fOpts.fsAx,'HorizontalAlignment','center');
end

% edit
ylim([0 1000]);
% xlim([0.5 3.5]);
box off;
ax = gca;
% ax.XTick = [1:nSmp];
% ax.XTickLabel = sampleNames;
ax.YTick = [0 250 500 750 1000];
ylabel('µm');
xlabel('sample ID');
ax.FontSize = fOpts.fsAx;
title(ttl,'FontSize',fOpts.fsT);
fg.Position(3:4) = fOpts.fgSz;
end

