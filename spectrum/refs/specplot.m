%% Spectrum Plotter
% Author: Andrew Wood
% Created: 4/11/22
% Last Edited: 4/26/22

% Inputs: dataset(s), lat(s), lon(s), check for save 
% Outputs: 

function specplot(ds, group, lats, lons, save)
tic
set(0,'DefaultFigureWindowStyle','docked')

% Retrying with days instead of months
leap = ones(1, 20) .* 365;
leap(4:4:end) = 366;
leap(1) = 0;
addin = cumsum(leap);
addin = repelem(addin, 12);
addin(1:3) = [];
addin = addin';

dates = readmatrix('gfodates.csv', 'Range', [2 1 238 3]);
mask = isnan(dates(:, 1));
dates(mask, :) = [];
addin(mask) = [];

startDay = dates(:,2); % start day of each dataset
endDay = dates(:,3); % end day of each dataset
mask2 = endDay < startDay;
endDay(mask2) = endDay(mask2) + 365;
avgDay = (startDay + endDay)/2;
tsdays =  avgDay + addin; % time in days
tsdays = tsdays - tsdays(1); % days from first day, first day = 0
tsdays = floor(tsdays);

% converting to datetime for regular plot
t1 = datetime(2002, 04, 15);
tstime = t1 + caldays(tsdays);
if group == 2
   tstime = tstime(end-35:end); % only 19-21
end

%% dataset/group selection
if ~exist('ds', 'var') || ~exist('group', 'var')
   fprintf("Available Groups:\n");
   fprintf("1: Full Time Series\n");
   fprintf("2: 2019-2021\n");
   fprintf("Error: No dataset specified!\n\n");
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
       tag1 = "CSR";
       linecolor = 'r';

case 5 % GFZ L3
       tag1 = "GFZ";
       linecolor = 'g';

case 6 % JPL L3
       tag1 = "JPL";
       linecolor = 'b';

% case 7 % JPL Mascons
        
case 8 % Cumulative CSR L3
       tag1 = "cCSR";
       linecolor = 'r';

case 9 % Cumulative GFZ L3
       tag1 = "cGFZ";
       linecolor = 'g';

case 10 % Cumulative JPL L3
       tag1 = "cJPL";
       linecolor = 'b';

% case 11 % Cumulative JPL Mascons
        
end

current = cd;
datadir = fullfile(current, sprintf('../results/matvars/%s/%s', tag1, tag2));
outdir = fullfile(current, '../results/plots/%s/%s', tag1, tag2);
data = load(datadir);
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
