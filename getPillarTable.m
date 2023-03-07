function pillarTable = getPillarTable(dir,fileNames)
% dir is path to generic directory
% fileNames is cell array of csv files that can be imported as tables and
% whose relevant data field is named 'Length'. The cell array contains 4
% components referring to the measurements of diamTop, diamBottom,
% heightsROIs and heights

dTop = readtable(strcat(dir, filesep, fileNames{1}));
dBottom = readtable(strcat(dir, filesep, fileNames{2}));
heightROIs = readtable(strcat(dir, filesep, fileNames{3}));
heights = readtable(strcat(dir, filesep, fileNames{4}));

pillarTable = table(dTop.Length, dBottom.Length, heightROIs.Length, heights.Length);
pillarTable.Properties.VariableNames = {'diamTop','diamBottom','heightsROIs','heights'};
end