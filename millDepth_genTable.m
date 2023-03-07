% milling depth - gen table
% 
% 

%% init vars

dirs = init_dirs();
fg = init_figOptions();

%% load data
trenchT = readtable([dirs.data filesep 'Cu018_depthMilling.xlsx']);

%% edit table
trenchT.powerGroup = findgroups(trenchT.power);

%%%%%%%%%%%%%%%%%%%%%%%%%
%% save the relevant tables
save([dirs.matTables filesep 'Cu018_depthMilling.mat'], ...
    'trenchT', ...
    '-v7.3');
% must use the -v7.3 version flag to save it because the file is >2GB.
%%%%%%%%%%%%%%%%%%%%%%%%%
