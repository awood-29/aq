%% Txt Data Generator for PCA
% Author: Andrew Wood
% Created: 4/15/22
% Last Edited: 4/26/22

group = "2019_21";
ds = "cCSR";

%% Loads from file and writes to new var
current = pwd;
outdir = fullfile(current, sprintf("../results/matvars/%s/%s", group, ds));
data = load(outdir,'data');
data = data.data;
tsdata = data([2:-1:1, 171:206], 1:10080);
[r, c] = size(tsdata);
tsdatanew = []; % blank template

for cur = 1:360
   cols = tsdata(:, cur:360:c); % selects all of 1 latitude
   tsdatanew = [tsdatanew cols];
end

tsdatanew(1,:) = tsdatanew(1, :) -180; % shifts to -179.5
%save(sprintf("%s/%sprep.mat", outdir, ds), 'tsdatanew')

%% writing to text files
%loadvarpath = 'csrprep.mat'; % add path to prep.mat variable
%data=load(loadvarpath);
data = tsdatanew;

lons = data(1, :); % all lons
lats = data(2, :); % all lats

data = data(3:end, :);

for t = 1:36
   % opening file
   years = [19 20 21];
   year = years(ceil(t/12));
   
   month = mod(t, 12);
   if month == 0
      month = 12;
   end
   
   months = ["01" "02" "03" "04" "05" "06" ...
             "07" "08" "09" "10" "11" "12" ];
   month = months(month);
   name = fullfile(current, sprintf('../results/txt/%s/%s/%d_%s.txt', group, ds, year, month));
   fid = fopen(name, 'wt');

   row = data(t, :); % selects row vec of z values
   
   for i = 1:length(lons)
      % work through each lon, lat, and z, writing to each line
      lon = lons(i);
      lat = lats(i);
      z = row(i);

      fprintf(fid, "%4.1f,%3.1f,%f\n", lon, lat, z);
   end
   fclose(fid);
end

fclose all;
