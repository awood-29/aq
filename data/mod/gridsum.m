% Cumulative Grid Producer (Upgraded)
%
% Creator: Andrew Wood
% Date Created: 4/29/22
% Last Modified: 4/29/22

% Note: Hardcoded for lat -89.5 to -62.5
% to change, add new inputs latrange and lonrange and
% replace 360 and 28 with their lengths. Also can pass
% direct into ncmake

function gridsum(indir, outdir)

current = cd;
gridin = fullfile(current, indir);
gridout = fullfile(current, outdir);

gridstr = dir(sprintf("%s/*.nc", gridin));
gridnames = cell(length(gridstr), 1);
for a = 1:length(gridstr)
   gridnames{a, 1} = gridstr(a).name;
end
% all filenames stored in n*1 cell array

% 
sumfn = gridnames{1};
fullsumpath = fullfile(gridin, sumfn);
z1 = ncread(fullsumpath, 'lwe_thickness');
z1 = z1(:, 1:28); % -89.5 to -62.5
ncmake(0.5:359.5, -89.5:-62.5, 'lwe_thickness', z1, gridout, sumfn);
% creates initial .nc in target folder

for b = 2:length(gridstr)
   addfn = gridnames{b};
   
   % Now reading nc file
   fullsumpath = fullfile(gridin, sumfn);
   fulladdpath = fullfile(gridin, addfn);
   
   zsum = ncread(fullsumpath, 'lwe_thickness'); % arr of sum z vals
   zadd = ncread(fulladdpath, 'lwe_thickness'); % arr of add z vals
   zsum = zsum(:, 1:28);
   zadd = zadd(:, 1:28);
   
   znewsum = zsum + zadd;
   ncmake(0.5:359.5, -89.5:-62.5, 'lwe_thickness', znewsum ...
      , gridout, addfn); % new .nc to out

   sumfn = addfn;
end
 
end