%% Spectrum Plotter
% Author: Andrew Wood
% Created: 4/11/22
% Last Edited: 4/26/22

% Inputs: dataset(s), lat(s), lon(s), check for save 
% Outputs: 

function specplot(group, ds, lats, lons, save)
tic
set(0,'DefaultFigureWindowStyle','docked')

[~, tstime] = getDates(group); % dates for plotting

%% dataset/group selection
if ~exist('ds', 'var') || ~exist('group', 'var')
   ps();
end

switch group
    case 1 % Full Time Series
        tag1 = "full";
    case 2 % 2019-2021
        tag1 = "2019_21";
    otherwise
        error("no group specified");
end

for d = 1:length(ds)
% Dataset selection - loops through each dataset

switch ds(d)
% case 1 % CSR L2
% 
% case 2 % GFZ L2
% 
% case 3 % JPL L2
        
case 4 % CSR L3
       tag2 = "CSR";
       linecolor = 'r';

case 5 % GFZ L3
       tag2 = "GFZ";
       linecolor = 'g';

case 6 % JPL L3
       tag2 = "JPL";
       linecolor = 'b';

% case 7 % JPL Mascons
        
case 8 % Cumulative CSR L3
       tag2 = "cCSR";
       linecolor = 'r';

case 9 % Cumulative GFZ L3
       tag2 = "cGFZ";
       linecolor = 'g';

case 10 % Cumulative JPL L3
       tag2 = "cJPL";
       linecolor = 'b';

% case 11 % Cumulative JPL Mascons
        
end

current = cd;
datadir = fullfile(current, sprintf('../results/matvars/%s/%s', tag1, tag2));
outdir = fullfile(current, sprintf('../results/plots/%s/%s', tag1, tag2));
data = load(sprintf("%s/data.mat", datadir));
data = data.data;

for a = 1:length(lats) % loops through all provided lats
    lat = lats(a);
   for b = 1:length(lons)
   
    lon = lons(b); % sets up lat-lon pair
    col = 360*(lat+89.5) + (lon+0.5); % sketch, but determines ts col
    ts = data(3:end, col); % sets up yvalues
    name = sprintf("lat%.1flon%.1f", lat, lon); % name based on lat lon pair

    if exist('save', 'var')
       if save == 1 || save == true
           f = figure('Name', name, 'NumberTitle', 'off', 'visible', 'off');
       else
           f = figure('Name', name, 'NumberTitle', 'off'); %'visible', 'off');
       end
    else
      f = figure('Name', name, 'NumberTitle', 'off'); %'visible', 'off');
    end
    tiledlayout(2,1) % sets up tile

    nexttile  % regular plot, with datetime array
    plot(tstime, ts, linecolor, 'LineWidth', 1.5) % plots ts for point
    title(sprintf("%s Time Series", name))
    ylabel("\Delta Equivalent Water Height (cm)")

    %ylim([-6.8,1])
    grid on

    nexttile
    %name = sprintf("lat%.1flon%.1fFFT", lat, lon); % name based on lat lon pair
    %f = figure('Name', name, 'NumberTitle', 'off'); %'visible', 'off');
    
    % using Lomb-Scargle periodogram b/c uneven sampling
    % tsdays = time sequence in days
    % ts = lwe values
    [Plomb, flomb] = plomb(ts, tstime);
    flomb = flomb*60*60*24; % to days
    period = 1./flomb; % days / cycle

    plot(period, Plomb, linecolor) % plots fft for point
    ylabel("Power Spectral Density")
    xlabel("Period (days/cycle)")
    %xlim([30, 800])
    title(sprintf("%s Time Series FFT", name))
    grid on 

    if exist('save', 'var')
       if save == 1 || save == true
           name = strrep(name, '.', '_'); % kills periods
           savename = sprintf("%s/%s", outdir, name);
           saveas(f, savename, 'png');
       end
    end
   end
end
end
toc
end
