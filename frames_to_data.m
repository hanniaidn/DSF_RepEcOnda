clc
clear
close all

myFolder ='C:\Users\hanni\Desktop\Matlab\Prueba 2';

filePattern = fullfile(myFolder, '*.png');

if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end

filePattern = fullfile(myFolder, '*.png');
pngFiles = dir(filePattern);

[~,idx] = sort(string({pngFiles.name}),2,'ascend');

l = 1;
array = [];
 
for k=1:length(idx)
    baseFileName = pngFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);

    img = imread(fullFileName);

    for f=1:size(img,1)
        for c=1:size(img,2)
            if img(f,c) == 1
                array(c,k) = f;
            end
        end
    end

    array = array(array~=0);
    db(k).array = array;
    array = 0;
end

myTable = struct2table(db);
Xc = table2cell(myTable);

names = [""];

for k=1:length(Xc)
    names(k) = strcat('frame',num2str(k));
end

myTable = cell2table(Xc');
myTable.Properties.VariableNames = names;

figure
hold on

for k=1:length(db)
    plot(db(k).array)
end
xlabel('Tiempo')
ylabel('Amplitud')
title('Datos sin interpolar con valores atípicos')







