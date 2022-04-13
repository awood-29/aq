%% Spectrum Plotter
% Author: Andrew Wood
% Created: 4/11/22
% Last Edited: 4/13/22

% Inputs: dataset(s), lat(s), lon(s), check for save 
% Outputs: 

function specplot(ds, lats, lons, save)
set(0,'DefaultFigureWindowStyle','docked')  
currentdir = cd;
time = [2018 06 01; 2018 07 01; 2018 10 01; 2018 11 01; 2018 12 01; ...
       2019 01 01; 2019 02 01; 2019 03 01; 2019 04 01; 2019 05 01; 2019 06 01; ...
       2019 07 01; 2019 08 01; 2019 09 01; 2019 10 01; 2019 11 01; 2019 12 01;  ...
       2020 01 01; 2020 02 01; 2020 03 01; 2020 04 01; 2020 05 01; 2020 06 01; ...
       2020 07 01; 2020 08 01; 2020 09 01; 2020 10 01; 2020 11 01; 2020 12 01;  ...
       2021 01 01; 2021 02 01; 2021 03 01; 2021 04 01; 2021 05 01; 2021 06 01; ...
       2021 07 01; 2021 08 01; 2021 09 01; 2021 10 01; 2021 11 01; 2021 12 01];
tstime = datetime(time);

for d = 1:length(ds)
% Dataset selection - loops through each dataset

switch ds(d)
% case 1 % CSR L2
% 
% case 2 % GFZ L2
% 
% case 3 % JPL L2
        
case 4 % CSR L3
       outdir = fullfile(currentdir, './images/CSR');
       data=load(sprintf('%s/matvars/CSR/data.mat', currentdir));
       data = data.data;

case 5 % GFZ L3
       outdir = fullfile(currentdir, './images/GFZ');
       data=load(sprintf('%s/matvars/GFZ/data.mat', currentdir));
       data = data.data;

case 6 % JPL L3
       outdir = fullfile(currentdir, './images/JPL');
       data=load(sprintf('%s/matvars/JPL/data.mat', currentdir));
       data = data.data;

% case 7 % JPL Mascons
        
case 8 % Cumulative CSR L3
       outdir = fullfile(currentdir, './images/cCSR');
       data=load(sprintf('%s/matvars/cCSR/data.mat', currentdir));
       data = data.data;

case 9 % Cumulative GFZ L3
       outdir = fullfile(currentdir, './images/cGFZ');
       data=load(sprintf('%s/matvars/cGFZ/data.mat', currentdir));
       data = data.data;

case 10 % Cumulative JPL L3
       outdir = fullfile(currentdir, './images/cJPL');
       data=load(sprintf('%s/matvars/cJPL/data.mat', currentdir));
       data = data.data;

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

for a = 1:length(lats) % loops through all provided lats
    lat = lats(a);
   for b = 1:length(lons)
    lon = lons(b); % sets up lat-lon pair
    col = 360*(lat+89.5) + (lon+0.5); % sketch, but determines ts col
    ts = data(3:end, col); % sets up yvalues
    name = sprintf("lat%.1flon%.1fTS", lat, lon);
    if exist('save', 'var')
        % only save to file
        f = figure('Name', name, 'NumberTitle', 'off', 'visible', 'off');
        plot(tstime, ts, 'b-', 'LineWidth', 1.5) % plots ts for point
        ylabel("Net \Delta lwe thickness (cm)")
        title(sprintf("%s Time Series", name))
        grid on
        savename = sprintf("%s/%s", outdir, name);
        saveas(f, savename, 'png');

    else
        % plot regular timeseries
        figure('Name', name, 'NumberTitle', 'off');
        plot(tstime, ts, 'b-', 'LineWidth', 1) % plots ts for point
        ylabel("Net \Delta lwe thickness (cm)")
        title(sprintf("%s Time Series", name))
        grid on
    end
   end
end


end

end
