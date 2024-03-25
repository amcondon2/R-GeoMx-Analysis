%% Load Rois To Array
files = dir(fullfile("Defined ROIs/", '*.mat')); %find all mat files in directory

for fileIdx = 1:length(files) %load all objects into cell array
    roiArray{fileIdx} = load(fullfile(files(fileIdx).folder, files(fileIdx).name)).roiObj;
end

numRoi = length(roiArray);

%% Parameters for Output Table
doSnrFiltering = false;
snrLims = [35, 90];

%% Generate Output Table

imageColumnNames = roiArray{1}.imageColumnNames;
columnNames = ["Case", "Run", "Sex", "Group", "toggleChannel"];
columnNames = [columnNames, imageColumnNames];
columnTypes = ["double", "double", "categorical", "categorical", "double", repmat("cell", 1, length(imageColumnNames))]; %predefine column names and types

outTable = table('Size',[0,length(columnNames)], 'VariableTypes',columnTypes, 'VariableNames',columnNames); %create empty table

for roiIdx = 1:numRoi

    roiArray{roiIdx} = roiArray{roiIdx}.setSnrLims(snrLims(1), snrLims(2));
    if doSnrFiltering
        roiArray{roiIdx} = roiArray{roiIdx}.enableSnrFiltering();
    else
        roiArray{roiIdx} = roiArray{roiIdx}.disableSnrFiltering();
    end

    newRow.Case = roiArray{roiIdx}.originCase;
    newRow.Run = roiArray{roiIdx}.originRun;
    newRow.Sex = unique(roiArray{roiIdx}.imageTable.sex);
    newRow.Group = roiArray{roiIdx}.imageTable.treatment;
    newRow.toggleChannel = unique(roiArray{roiIdx}.imageTable.toggleChannel);
    
    for imIdx = 1:length(imageColumnNames)
        newRow.(imageColumnNames(imIdx)) = roiArray{roiIdx}.getPointsInRoi(imageColumnNames(imIdx));
    end

    outTable = [outTable; struct2table(newRow, 'AsArray',true)];
end

outTable.SNR1 = []; %SNR is junk for these ROIs because of alignment issues, data cropped
outTable.SNR2 = [];
outTable = sortrows(outTable, 1);


columnNames = ["sample", "Sex", "Group", "LT1mean", "LT2mean", "LT3mean", "LT1med", "LT2med", "LT3med", "I1mean", "I2mean", "I3mean", "I1med", "I2med", "I3med", "IR13mean", "IR23mean"];
columnTypes = ["double", "categorical", "categorical" ,repmat("double", 1, length(columnNames)-3)]; %predefine column names and types

summaryTable = table('Size',[0,length(columnNames)], 'VariableTypes',columnTypes, 'VariableNames',columnNames); %create empty table
caseNums = unique(outTable.Case);

for caseIdx = 1:height(caseNums)
    ch1Imap = cell2mat(outTable(outTable.Case == caseNums(caseIdx) & outTable.toggleChannel == 1, :).I1map);
    ch2Imap = cell2mat(outTable(outTable.Case == caseNums(caseIdx) & outTable.toggleChannel == 2, :).I1map);
    ch3Imap = cell2mat(outTable(outTable.Case == caseNums(caseIdx), :).I2map);
    
    ch1LTmap = cell2mat(outTable(outTable.Case == caseNums(caseIdx) & outTable.toggleChannel == 1, :).LT1map);
    ch2LTmap = cell2mat(outTable(outTable.Case == caseNums(caseIdx) & outTable.toggleChannel == 2, :).LT1map);
    ch3LTmap = cell2mat(outTable(outTable.Case == caseNums(caseIdx), :).LT2map);

    IR13 = ch1Imap ./ (ch1Imap + cell2mat(outTable(outTable.Case == caseNums(caseIdx) & outTable.toggleChannel == 1, :).I2map));
    IR23 = ch2Imap ./ (ch2Imap + cell2mat(outTable(outTable.Case == caseNums(caseIdx) & outTable.toggleChannel == 2, :).I2map));

    newRow = [];
    newRow.sample = caseNums(caseIdx);
    newRow.Sex = unique(outTable(outTable.Case == caseNums(caseIdx), :).Sex);
    
    if outTable(outTable.Case == caseNums(caseIdx), :).Group == "strep"
        newRow.Group = "test";
    else
        newRow.Group = "control";
    end

    newRow.LT1mean = mean(ch1LTmap, 'omitnan');
    newRow.LT2mean = mean(ch2LTmap, 'omitnan');
    newRow.LT3mean = mean(ch3LTmap, 'omitnan');
    newRow.LT1med = median(ch1LTmap, 'omitnan');
    newRow.LT2med = median(ch2LTmap, 'omitnan');
    newRow.LT3med = median(ch3LTmap, 'omitnan');

    newRow.I1mean = mean(ch1Imap, 'omitnan');
    newRow.I2mean = mean(ch2Imap, 'omitnan');
    newRow.I3mean = mean(ch3Imap, 'omitnan');
    newRow.I1med = median(ch1Imap, 'omitnan');
    newRow.I2med = median(ch2Imap, 'omitnan');
    newRow.I3med = median(ch3Imap, 'omitnan');

    newRow.IR13mean = mean(IR13, 'omitnan');
    newRow.IR23mean = mean(IR23, 'omitnan');

    if isnan(newRow.LT1mean)
        keyboard;
    end
   
    summaryTable = [summaryTable; struct2table(newRow, 'AsArray',true)];
end

writetable(summaryTable, "roiSummaryTable2.csv");