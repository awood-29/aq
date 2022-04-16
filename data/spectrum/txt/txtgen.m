%% Txt Generator for PCA
% Author: Andrew Wood
% Created: 4/15/22
% Last Edited: 4/15/22

%import
data=load('jplprep.mat');
data = data.tsdatanew;

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
   name = sprintf('%d_%s.txt', year, month);
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







