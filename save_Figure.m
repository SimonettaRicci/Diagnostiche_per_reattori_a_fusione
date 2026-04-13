function save_Figure(fileName, figHandle)
destFolder = '/Users/alessiovinci/Desktop/univeristà/tdrft/tesina/simulazioni/save image';
% percorso completo
fullPath = fullfile(destFolder, fileName);
saveas(figHandle, fullPath);
saveas(figHandle, fullPath, 'png');
end