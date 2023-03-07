% calc tilt of milled pillars
% script to generate data table

%% 0-init paths
dirs = init_dirs();

% enter file names in cell array {topD, bottomD, roisHeights, heights}
sampleNames = {'C427';'C514';'Y044'};
nSamples = length(sampleNames);
fNames_C427 = {'C427_pillars_topDiameter.csv';...
    'C427_pillars_bottomDiameter.csv';...
    'C427_pillars_heightROIs.csv';...
    'C427_pillars_height.csv'};
fNames_C514 = {'C514_topDiam.csv';...
    'C514_bottomDiam.csv';...
    'C514_rois_heights.csv';...
    'C514_heights.csv'};
fNames_Y044 = {'Y044_topDiam.csv';...
    'Y044_bottomDiam.csv';...
    'Y044_roi_heights.csv';...
    'Y044_heights.csv'};

%% 1- load measurement data
C427_T = getPillarTable(dirs.data, fNames_C427);
C514_T = getPillarTable(dirs.data, fNames_C514);
Y044_T = getPillarTable(dirs.data, fNames_Y044);

pData = {C427_T; C514_T; Y044_T};

pillarT = table(sampleNames, pData);

%% 2- extract pillar stats
% nSamples = height(pillarT);
nPillars = zeros(nSamples,1);
heightROIs = zeros(nSamples,1);
heightROIsErr = zeros(nSamples,1);
heightPillars = zeros(nSamples,1);
heightPillarsErr = zeros(nSamples,1);
for i = 1:nSamples
    nPillars(i) = size(pillarT.pData{i},1);
    heightROIs(i) = mean(pillarT.pData{i}.heightsROIs);
    heightROIsErr(i) = std(pillarT.pData{i}.heightsROIs)/sqrt(nPillars(i));
    heightPillars(i) = mean(pillarT.pData{i}.heights);
    heightPillarsErr(i) = std(pillarT.pData{i}.heights)/sqrt(nPillars(i));
    
    if heightROIsErr(i) > 0.1 * heightROIs(i)
        msg = ['ERROR: Unconsistent ROI height in ' sampleNames{i} '. Revise measurements'];
    end
    
end

%% update table
pillarT.heightROIs = heightROIs;
pillarT.heightROIsErr = heightROIsErr;
pillarT.heightPillars = heightPillars;
pillarT.heightPillarsErr = heightPillarsErr;

%% 3- calculate tilt angle for each pillar
for i = 1:nSamples
    pillarT.pData{i}.tiltAngle = ...
        rad2deg(atan(( ...
        pillarT.pData{i}.diamBottom-pillarT.pData{i}.diamTop)./ ...
        (2*pillarT.pData{i}.heightsROIs)));
end

%% add sample id tag 
for i = 1:nSamples
    pillarT.pData{i}.pName(:) = sampleNames(i);
end

%% add average tilt per sample on the main table
for i = 1:nSamples
    pillarT.tiltAngle(i) = mean(pillarT.pData{i}.tiltAngle);
end

%% save tables
save([dirs.matTables filesep 'pillars_table.mat'], 'pillarT');
