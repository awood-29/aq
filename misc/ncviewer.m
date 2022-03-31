% NetCDF Viewer
% Author: Andrew Wood
% Created: 3/18/22
% Last Edited: 3/18/22

% adapted from https://sites.uci.edu/morlighem/dataproducts/bedmachine-antarctica/
filename = 'el2.nc';
x = ncread(filename,'x');
y = ncread(filename,'y');
surface = ncread(filename,'surface')'; %Do not forget to transpose (MATLAB is column oriented)
%Display bed elevation
imagesc(x,y,surface); axis xy equal; caxis([-1000 3000]);