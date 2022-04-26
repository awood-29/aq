%% Spectrum Data Prep
% Author: Andrew Wood
% Created: 4/11/22
% Last Edited: 4/25/22

% Inputs: None
% Outputs: .mat file of variables for

function specvarsFO(ds)

%% sets up directory stuff
currentdir = cd; % string of current directory

if ~exist('ds', 'var')
  fprintf("Available Datasets:\n");
  fprintf("1: Level 2 CSR (Temp. Unavailable)\n");
  fprintf("2: Level 2 GFZ (Temp. Unavailable)\n");
  fprintf("3: Level 2 JPL (Temp. Unavailable)\n");
  fprintf("4: Level 3 CSR\n");
  fprintf("5: Level 3 GFZ\n");
  fprintf("6: Level 3 JPL\n");
  fprintf("7: JPL Mascons (Temp. Unavailable)\n");
  fprintf("8: Cumulative Level 3 CSR\n");
  fprintf("9: Cumulative Level 3 GFZ\n");
  fprintf("10: Cumulative Level 3 JPL\n");
  fprintf("11: Cumulative JPL Mascons (Temp. Unavailable)\n");
  error("Error: No dataset specified!\n\n")
end

switch ds
% case 1 % CSR L2
%        datadir = fullfile(currentdir, '../l2/CSR'); 
%        outdir = fullfile(currentdir, './matvars/sCSR');
% 
% case 2 % GFZ L2
%        datadir = fullfile(currentdir, '../l2/GFZ'); 
%        outdir = fullfile(currentdir, './matvars/sGFZ'); 
% 
% case 3 % JPL L2
%        datadir = fullfile(currentdir, '../l2/JPL'); 
%        outdir = fullfile(currentdir, './matvars/sJPL');
        
case 4 % CSR L3
       datadir = fullfile(currentdir, '../CSR'); 
       outdir = fullfile(currentdir, './matvars/CSR');

case 5 % GFZ L3
       datadir = fullfile(currentdir, '../GFZ'); 
       outdir = fullfile(currentdir, './matvars/GFZ');
        
case 6 % JPL L3
       datadir = fullfile(currentdir, '../JPL'); 
       outdir = fullfile(currentdir, './matvars/JPL');
        
% case 7 % JPL Mascons
%        datadir = fullfile(currentdir, '../mascon'); 
%        outdir = fullfile(currentdir, './matvars/mascon');
        
case 8 % Cumulative CSR L3
       datadir = fullfile(currentdir, '../cCSR'); 
       outdir = fullfile(currentdir, './matvars/cCSR');
        
case 9 % Cumulative GFZ L3
       datadir = fullfile(currentdir, '../cGFZ'); 
       outdir = fullfile(currentdir, './matvars/cGFZ');
        
case 10 % Cumulative JPL L3
       datadir = fullfile(currentdir, '../cJPL'); 
       outdir = fullfile(currentdir, './matvars/cJPL');
        
% case 11 % Cumulative JPL Mascons
%        datadir = fullfile(currentdir, '../cmascon'); 
%        outdir = fullfile(currentdir, './matvars/cmascon');
end

%% Iterating through Folder
latrange = -89.5:-59.5; % 31 cols
lat= repelem(latrange, 360); % 11160 cols
lonrange = .5:359.5; % 360 rows
lon= repmat(lonrange, [1 31]); % 11160 cols
 

files = ls(datadir); % stores to char array
files = cellstr(files); % to cell array
files([1 2]) = []; % clears dot and dotdot

row = zeros(1, 11160);
data = [lat; lon; zeros(length(files), 11160)]; % reformatted to have lat in first row, then lon, ...
% then each time series as a column

for i = 1:length(files)
    fp = sprintf('%s/%s', datadir, files{i}); % jank path to file
    dat = ncread(fp, 'lwe_thickness'); % reads to array

    for c = 1:31
        newcol = dat(:, c);
        newrow = newcol'; % transposes lat col to row
        row((1+360*(c-1)):(360+360*(c-1))) = newrow;
    end

    data(2+i, :) = row; % adds row to final mat
    row = []; %resets row
end

save(sprintf("%s/data.mat", outdir), 'data')

end
