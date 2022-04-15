%% Spectrum Plotter
% Author: Andrew Wood
% Created: 4/11/22
% Last Edited: 4/13/22

% Inputs: dataset(s), lat(s), lon(s), check for save 
% Outputs: 

function specplot(ds, lats, lons, save)
tic
%set(0,'DefaultFigureWindowStyle','docked')  
currentdir = cd;
t1 = datetime(2002, 04, 01);
t2 = datetime(2021, 12, 01);
time = t1:calmonths(1):t2;
tstime = time';
missing = [3 4 15 106 111 122 127 132 137 138 143 148 ...
           153 159 163 164 169 174 175 179 184:194 ...
           197 198]; % months to skip
tstime(missing) = [];
duration = t2-t1;
dduration = days(duration);

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
    name = sprintf("lat%.1flon%.1fTS", lat, lon); % name based on lat lon pair

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

    nexttile  % regular plot
    plot(tstime, ts, 'b-', 'LineWidth', 1.5) % plots ts for point
    title(sprintf("%s Time Series", name))
    ylabel("\Delta Equivalent Water Height (cm)")
    %ylim([-6.8,1])
    grid on

    nexttile
    %name = sprintf("lat%.1flon%.1fFFT", lat, lon); % name based on lat lon pair
    %f = figure('Name', name, 'NumberTitle', 'off'); %'visible', 'off');
    y = fft(ts);
    n = length(y);
    y(1)=[];
    power = abs(y(1:floor(n/2))).^2; % first half power
    maxf = 1/2; % maximum frequency ???
    freq = (1:n/2)/(n/2)*maxf; % frequency grid
    freq = freq.*dduration;

    %P2 = abs(s/L); % 2 sided spectrum
    %P1 = P2(1:L/2+1); % 1 sided spectrum using length
    %P1(2:end-1) = 2*P1(2:end-1);
    %freq = Fs.*(0:(L/2))/L; % defines frequency domain
    %freq = (0:(L/2))/L; % defines frequency domain

    plot(freq, power, 'b') % plots fft for point
    ylabel("Power")
    xlabel("Frequency (1/days)")
    xlim([65, 365.*2])
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
