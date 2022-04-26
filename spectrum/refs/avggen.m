%% Avg Generator for PCA
% Author: Andrew Wood
% Created: 4/16/22
% Last Edited: 4/26/22

group = "2019_21";

lons = zeros(10800, 1);
lats = zeros(10800, 1);

for t = 1:36   
   arr = zeros(10080, 3); % initiates arr

% csr, gfz, jpl
   
   for dc = 1:3
      current = pwd;
      targets = ["csr" "gfz" "jpl"];
      target = targets(dc);
      avg = "avg";
      % now have 

   % opening file for reading
      years = [19 20 21];
      year = years(ceil(t/12));
      
      month = mod(t, 12);
      if month == 0
         month = 12;
      end
      
      months = ["01" "02" "03" "04" "05" "06" ...
                "07" "08" "09" "10" "11" "12" ];
      month = months(month);
      name = sprintf('%s/../results/txt/%s/%s/%d_%s.txt', current, group, target, year, month);

      % while loop to read through text file
      fid = fopen(name);
      line = fgetl(fid); % initiates
      count = 1; % initiates line number
      while ischar(line)
         vals = split(line, ',');
         if dc == 1 && t == 1
            lon = str2double(vals{1});
            lat = str2double(vals{2});
            lons(count)=lon;
            lats(count)=lat; % one iteration, fills lons and lats
         end

         z = str2double(vals{3});
         arr(count,dc) = z;
         count=count+1; % steps line number
         line = fgetl(fid); % gets next line
      end
      fclose(fid);
   end
   
   % taking avgs for month, getting averages and writing to file
   avgs = mean(arr, 2, 'omitnan');

   % file to write averages too
   namew = sprintf('%s/../results/txt/%s/%s/%d_%s.txt', current, group, avg, year, month);
   fidwrite = fopen(namew, 'wt');
   for g = 1:length(avgs)
      % write to file w/ lon,lat,avg, switching NaN to -999999
      lon=lons(g);
      lat=lats(g);
      z=avgs(g);
      if isnan(z)
         z = -999999;
      end
      fprintf(fidwrite, "%4.1f,%3.1f,%f\n", lon, lat, z);      
   end
   fclose(fidwrite);
end
 
      






