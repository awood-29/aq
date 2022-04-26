%% Spectrum Data Prep
% Author: Andrew Wood
% Created: 4/11/22
% Last Edited: 4/26/22

% Inputs: None
% Outputs: .mat file of variables for

function specvars(ds, group)
%% vars
latmin = -89.5;
latmax = -62.5;
lonmin = 0.5;
lonmax = 359.5;
latrange = latmin:latmax; % 28 cols, normally
lonrange = lonmin:lonmax; % 360 rows, normally

%% Warning for no inputs
if nargin < 2
  fprintf("Available Groups:\n");
  fprintf("1: Full Time Series\n");
  fprintf("2: 2019-2021\n");
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

%% sets up directory stuff

switch group
    case 1 % Full Time Series
        tag1 = "full";
    case 2 % 2019-2021
        tag1 = "2019_21";
    otherwise
        error("no group specified");
end

switch ds
% case 1 % CSR L2
% 
% case 2 % GFZ L2
% 
% case 3 % JPL L2
        
case 4 % CSR L3
    tag2 = "CSR";
case 5 % GFZ L3
    tag2 = "GFZ";
        
case 6 % JPL L3
    tag2 = "JPL";
        
% case 7 % JPL Mascons
        
case 8 % Cumulative CSR L3
    tag2 = "cCSR";
        
case 9 % Cumulative GFZ L3
    tag2 = "cGFZ";
        
case 10 % Cumulative JPL L3
    tag2 = "cJPL";
        
% case 11 % Cumulative JPL Mascons

end

current = cd; % string of current directory
datadir = fullfile(current, sprintf("../../data/l3/%s/%s", tag1, tag2));
outdir = fullfile(current, sprintf("../results/matvars/%s/%s", tag1, tag2));


%% Iterating through Folder
lat= repelem(latrange, length(lonrange)); % 10080 cols
lon= repmat(lonrange, [1 length(latrange)]); % 10080 cols
 

files = ls(datadir); % stores to char array
files = cellstr(files); % to cell array
files([1 2]) = []; % clears dot and dotdot

totlen = length(lat);
row = zeros(1, totlen);
data = [lat; lon; zeros(length(files), totlen)]; % reformatted to have lat in first row, then lon, ...
% then each time series as a column

for i = 1:length(files)
    fp = sprintf('%s/%s', datadir, files{i}); % jank path to file
    dat = ncread(fp, 'lwe_thickness'); % reads to array

    for c = 1:31
        newcol = dat(:, c);
        newrow = newcol'; % transposes lat col to row
        row((1+length(lonrange)*(c-1)):(length(lonrange)+...
           length(lonrange)*(c-1))) = newrow;
    end

    data(2+i, :) = row; % adds row to final mat
    row = []; %resets row
end

save(sprintf("%s/data.mat", outdir), 'data')

end
