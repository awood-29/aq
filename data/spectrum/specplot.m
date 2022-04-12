%% Spectrum Plotter
% Author: Andrew Wood
% Created: 4/11/22
% Last Edited: 4/12/22

% Inputs: dataset(s), lat(s), lon(s), check for save 
% Outputs: 

function specplot(ds, lats, lons, save)
% read in .nc file, import data
latrange = -89.5:59.5; % 31 cols
lonrange = .5:359.5; % 360 rows
currentdir = cd;

for 1:length(ds)
% Dataset selection - loops through each dataset

switch ds
% case 1 % CSR L2
% 
% case 2 % GFZ L2
% 
% case 3 % JPL L2
        
case 4 % CSR L3
       outdir = fullfile(currentdir, './images/CSR');
       data=load(sprintf('%s/matvars/CSR', currentdir));

case 5 % GFZ L3
       outdir = fullfile(currentdir, './images/GFZ');
       data=load(sprintf('%s/matvars/GFZ', currentdir));

case 6 % JPL L3
       outdir = fullfile(currentdir, './images/JPL');
       data=load(sprintf('%s/matvars/JPL', currentdir));
       
% case 7 % JPL Mascons
        
case 8 % Cumulative CSR L3
       outdir = fullfile(currentdir, './images/cCSR');
       data=load(sprintf('%s/matvars/cCSR', currentdir));
        
case 9 % Cumulative GFZ L3
       outdir = fullfile(currentdir, './images/cGFZ');
       data=load(sprintf('%s/matvars/cGFZ', currentdir));
        
case 10 % Cumulative JPL L3
       outdir = fullfile(currentdir, './images/cJPL');
       data=load(sprintf('%s/matvars/cJPL', currentdir));
        
% case 11 % Cumulative JPL Mascons
        
    otherwise
        sprintf("Error: No dataset specified!\n\n");
        sprintf("Available Datasets:\n");
        sprintf("1: Level 2 CSR (Temp. Unavailable)\n");
        sprintf("2: Level 2 GFZ (Temp. Unavailable)\n");
        sprintf("3: Level 2 JPL (Temp. Unavailable)\n");
        sprintf("4: Level 3 CSR\n");
        sprintf("5: Level 3 GFZ\n");
        sprintf("6: Level 3 JPL\n");
        sprintf("7: JPL Mascons (Temp. Unavailable)\n");
        sprintf("8: Cumulative Level 3 CSR\n");
        sprintf("9: Cumulative Level 3 GFZ\n");
        sprintf("10: Cumulative Level 3 JPL\n");
        sprintf("11: Cumulative JPL Mascons (Temp. Unavailable)\n"); 
        return
end

for lat = 1:length(lats) % loops through all provided lats
    for lon = 1:length(lons) % loops through all provided lons

    end
end


end

end
