%% Spectrum Data Prep
% Author: Andrew Wood
% Created: 4/11/22
% Last Edited: 4/27/22

% Inputs: None
% Outputs: .mat file of variables for

function specvars(group, ds)
%% vars
latmin = -89.5;
latmax = -62.5;
lonmin = 0.5;
lonmax = 359.5;
latrange = latmin:latmax; % 28 cols, normally
lonrange = lonmin:lonmax; % 360 rows, normally

%% Warning for no inputs
if nargin < 2
   ps();
end

%% sets up directory stuff

[tag1, tag2] = tag(group, ds);

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

    for c = 1:length(latrange)
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
