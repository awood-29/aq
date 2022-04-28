function [pv] = EOF(group, ds, n, out1, out2, norm, dt)
%% GRACE EOF
% Description
% Author: Andrew Wood
% Created: 4/27/22
% Last Edited: 4/28/22
% Computes EOF of a matrix, designed for GRACE/GRACEFO/IceSat/IceSat2 datasets
% inputs
% n: number of EOFs
% out1: true to save plots
% out2: true to save ascii tables of EOFs
% norm: true to normalize
% dt: true to detrend (default)
% vars
% L are the eigenvalues of the covariance matrix ( ie. they are normalized
% by 1/(m-1), where m is the number of rows ).  

% EC are the expansion coefficients (PCs in other terminology) 

% pv holds the percent variance explained by each eigenval
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Argument Processing

if ~exist('norm', 'var')
  norm = false; % default no normalization
end

if ~exist('dt', 'var')
  dt = true; % default detrend
end

if ~exist('out1', 'var')
  out1 = false; % default detrend
end

if ~exist('out2', 'var')
  out2 = false; % default detrend
end

if nargin < 1
   ps();
end
%% Data Import

[tag1, tag2] = tag(group, ds); % strings for dir names, tag1 is group, tag2 is ds

current = cd; % string of current directory
datadir = fullfile(current, sprintf("../results/matvars/%s/%s", tag1, tag2));
outdir = fullfile(current, sprintf("../results/EOF/%s/%s", tag1, tag2));

data = load(sprintf("%s/data.mat", datadir));
data = data.data; % loads mat with points 
latlon = data(1:2, :);
U = data(3:end, :); % removes lat/lon header
skipcols = isnan(sum(U)); % undefined cols
% skipped = latlon(:, skipcols); % latlon points skipped
points = latlon(:, ~skipcols); % latlon points left
U = U(:, ~skipcols); % removes all NaN
%out = [points; U];

% removing NaN cols


%% Normalization / Detrend
s = size(U);

% Normalize by standard deviation if desired.
if norm
  norms = std(U, 'omitnan');
else
  norms = ones([1,s(2)]);
end
U = U * diag(1./norms);

% detrend if selected *** start here
if dt
   warning('off', 'MATLAB:detrend:PolyNotUnique')
   U = detrend(U, 1, 'omitnan');
end

%% SVD

% Use svd in case we want all EOFs - quicker.

[~, lambda, EOFs] = svd(U);

%a = C*lambda*EOFs;
%b = U - a;

% Compute EC's and L
L = diag( lambda ).^2; % eigenvalues.
pv = L/sum(L);
pv = pv(1:n); % truncates at number of modes
pv(n+1) = sum(pv); % adds sum to last row of out
pv = pv*100;
%c = sum(pv(1:3));
ECs = U * EOFs; % expansion coeffs
%reconstruct = ECs(1:n, :) * EOFs(:, 1:n); % 3 orthogonal vecs in R3

%% Reconstructing for plot
% Expansion Coeffs plotted in matlab

[~, tstime] = getDates(group); % gets time vec for plotting
set(0,'DefaultFigureWindowStyle','docked')

for a = 1:n
   name = sprintf("e%d", a);
   f = figure('NumberTitle', 'off', 'Name', name);
   tiledlayout(2,1) % sets up tile
   nexttile
   switch a
      case 1
         lc = 'b-';
      case 2
         lc = 'r-';
      case 3
         lc = 'k-';
      case 4
         lc = 'g-';
      otherwise
         lc = 'k-';
   end
   coeffs = ECs(:, a);

   plot(tstime, coeffs, lc, 'LineWidth', 1.5);
   title(sprintf("%s(LWE) Time Series", name))
   grid on
   nexttile
   % fft
   [Plomb, flomb] = plomb(coeffs, tstime);
   flomb = flomb*60*60*24; % to days
   period = 1./flomb; % days / cycle
   plot(period, Plomb, lc) % plots fft for point
   ylabel("Power Spectral Density")
   xlabel("Period (days/cycle)")
   %xlim([30, 800])
   title(sprintf("%s FFT", name))
   grid on 

   if out1
        savename = sprintf("%s/%s", outdir, name);
        saveas(f, savename, 'png');
   end
end


%% Exporting modes for plotting in GMT
if out2
   for a = 1:n
      En = [points; EOFs(:, a)'];
      fid = fopen(sprintf("%s/E%d", outdir, a), 'wt');
      for b = 1:height(EOFs)
         lat = En(1, b); % lat point
         lon = En(2, b); % lon point
         z = En(3, b);
         fprintf(fid, "%3.1f,%4.1f,%f\n", lat, lon, z);
      end
      fclose(fid);
   end
end

end