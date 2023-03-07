% millDepth_main
% 

%% init dirs

dirs = init_dirs();
fg = init_figOptions();

%% load data

load([dirs.matTables filesep 'Cu018_depthMilling.mat']); 

%% get some variables
nGroups = length(unique(trenchT.powerGroup));

%% plot stuff

f_depth = fg_pw_h_depth(trenchT, fg, 'depths milled on Cu sample');
figSave([dirs.figs filesep 'Cu_millDepth']);
