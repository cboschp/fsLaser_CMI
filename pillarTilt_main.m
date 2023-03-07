% calc tilt of milled pillars
% main script

%% 0-init paths
dirs = init_dirs();
fg = init_figOptions();
dataTname = 'pillars_table.mat';

%% load data
load([dirs.matTables filesep dataTname]);

%% stats summary
meanTilt = mean(pillarT.tiltAngle);
sd = std(pillarT.tiltAngle);
serr = sd/sqrt(height(pillarT));
nsamples = height(pillarT);
npillars = zeros(nsamples,1);
for i = 1:nsamples
    npillars(i) = height(pillarT.pData{i});
end

msg1 = ['Mean pillar tilt = ' num2str(meanTilt,2)];
msg2 = ['Standard error of the mean = ' num2str(serr,2)];
msg3 = ['Number of samples = ' num2str(nsamples,2)];
msg4 = 'Number of pillars of each sample = ';

disp(msg1);
disp(msg2);
disp(msg3);
disp(msg4);
disp(npillars);
%% plot pillar tilt angle
f = fg_plotTilt(pillarT,fg,'Milling angle');

figSave([dirs.figs filesep 'F1_millingAngles']);

%% plot pillar heights
f = fg_plotHeight(pillarT, fg, 'Pillar height');

figSave([dirs.figs filesep 'F2_pillarHeights']);


%% plot desired angles
% pillar slope angle: alpha
%a = 10:1:30;
a = 0:1:30;
% numAngles = length(a);

% height of the pillar: h
h = (200:50:500)';

% average tilt achieved for reference:
meanTilt = mean(pillarT.tiltAngle);

f = fg_meshgridAngles(a,h,250,'separation between pillars',meanTilt,fg);

figSave([dirs.figs filesep 'F3_distBetweenPillars']);

%% plot desired angles, remastered
% separation between pillars: s
a = 0:0.5:30;
s = (0:1:250)'; 
f = fg_meshgridAnglesHeight(a,s,250,1000,'Separation between pillars',meanTilt,fg);
figSave([dirs.figs filesep 'F3b_distBetweenPillars']);

