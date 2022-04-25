%% Txt Data Generator for PCA
% Author: Andrew Wood
% Created: 4/15/22
% Last Edited: 4/15/22

% Loads from file and writes to new txt file
current = pwd;
outdir = sprintf("%s/txt", current); % outs to txt dir

datafp = sprintf("%s/matvars/cJPL/data.mat", current); % reads from var
data = load(datafp,'data');
data = data.data;
tsdata = data([2:-1:1, 171:206], 1:10080);
[r, c] = size(tsdata);
tsdatanew = []; % blank template

for cur = 1:360
   cols = tsdata(:, cur:360:c); % selects all of 1 latitude
   tsdatanew = [tsdatanew cols];
end

tsdatanew(1,:) = tsdatanew(1, :) -180; % shifts to -179.5
save(sprintf("%s/jplprep.mat", outdir), 'tsdatanew')



