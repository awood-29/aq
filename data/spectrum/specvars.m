%% Spectrum Data Prep
% Author: Andrew Wood
% Created: 4/11/22
% Last Edited: 4/11/22

% Inputs: None
% Outputs: .mat file of variables for

function specvars(ds)
% read in .nc file, import data
latrange = -59.5:-1:-89.5; % 31 cols
lonrange = .5:359.5; % 360 rows


% sets up directory stuff
currentdir = cd; % string of current directory

[rows, cols] = size(data);

switch ds
case 1 % CSR L2
       datadir = fullfile(currentdir, '../l2/CSR'); 
       outdir = fullfile(currentdir, './matvars/sCSR');

case 2 % GFZ L2
       datadir = fullfile(currentdir, '../l2/GFZ'); 
       outdir = fullfile(currentdir, './matvars/sGFZ'); 

case 3 % JPL L2
       datadir = fullfile(currentdir, '../l2/JPL'); 
       outdir = fullfile(currentdir, './matvars/sJPL');
        
case 4 % CSR L3
       datadir = fullfile(currentdir, '../l3/CSR'); 
       outdir = fullfile(currentdir, './matvars/CSR');

case 5 % GFZ L3
       datadir = fullfile(currentdir, '../l3/GFZ'); 
       outdir = fullfile(currentdir, './matvars/GFZ');
        
case 6 % JPL L3
       datadir = fullfile(currentdir, '../l3/JPL'); 
       outdir = fullfile(currentdir, './matvars/JPL');
        
case 7 % JPL Mascons
       datadir = fullfile(currentdir, '../l3/mascon'); 
       outdir = fullfile(currentdir, './matvars/mascon');
        
case 8 % Cumulative CSR L3
       datadir = fullfile(currentdir, '../l3/cCSR'); 
       outdir = fullfile(currentdir, './matvars/cCSR');
        
case 9 % Cumulative GFZ L3
       datadir = fullfile(currentdir, '../l3/cGFZ'); 
       outdir = fullfile(currentdir, './matvars/cGFZ');
        
case 10 % Cumulative JPL L3
       datadir = fullfile(currentdir, '../l3/cJPL'); 
       outdir = fullfile(currentdir, './matvars/cJPL');
        
case 11 % Cumulative JPL Mascons
       datadir = fullfile(currentdir, '../l3/cmascon'); 
       outdir = fullfile(currentdir, './matvars/cmascon');
        
 
otherwise
        sprintf("Error: No dataset specified!\n\n");
        sprintf("Available Datasets:\n");
        sprintf("1: Level 2 CSR\n");
        sprintf("2: Level 2 GFZ\n");
        sprintf("3: Level 2 JPL\n");
        sprintf("4: Level 3 CSR\n");
        sprintf("5: Level 3 GFZ\n");
        sprintf("6: Level 3 JPL\n");
        sprintf("7: JPL Mascons\n");
        sprintf("8: Cumulative Level 3 CSR\n");
        sprintf("9: Cumulative Level 3 GFZ\n");
        sprintf("10: Cumulative Level 3 JPL\n");
        sprintf("11: Cumulative JPL Mascons\n");
end

end
