function ncmake(lonrange, latrange, zvarname, z, path, name)
   name2 = fullfile(path, name); % new filename
   nccreate(name2, 'lon', 'Dimensions', {'lon' length(lonrange)});
   ncwriteatt(name2, 'lon', 'standard_name', 'longitude');
   ncwriteatt(name2, 'lon', 'long_name', 'longitude');
   ncwriteatt(name2, 'lon', 'units', 'degrees_east');
   ncwriteatt(name2, 'lon', 'axis', 'X');
   ncwriteatt(name2, 'lon', 'actual_range', [lonrange(1), lonrange(end)]);

   nccreate(name2, 'lat', 'Dimensions', {'lat' length(latrange)});
   ncwriteatt(name2, 'lat', 'standard_name', 'latitude');
   ncwriteatt(name2, 'lat', 'long_name', 'latitude');
   ncwriteatt(name2, 'lat', 'units', 'degrees_north');
   ncwriteatt(name2, 'lat', 'axis', 'Y');
   ncwriteatt(name2, 'lat', 'actual_range', [latrange(1), latrange(end)]);

   nccreate(name2, zvarname, 'Dimensions', {'lon' length(lonrange) 'lat' length(latrange)});
   ncwriteatt(name2, zvarname, 'standard_name', zvarname);
   ncwriteatt(name2, zvarname, 'units', 'magnitude');
   %ncwriteatt(name2, zvarname, '_FillValue', NaN);
   ncwriteatt(name2, zvarname, 'actual_range', [min(min(z)), max(max(z))]);

   ncwrite(name2, 'lat', -89.5:-62.5);
   ncwrite(name2, 'lon', 0.5:359.5);
   ncwrite(name2, zvarname, z);
end