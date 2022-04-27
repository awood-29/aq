function [percentvar, L, b, c] = EOF(group, ds, norm, dt)
%% GRACE EOF
% Description
% Author: Andrew Wood
% Created: 4/27/22
% Last Edited: 4/27/22
% Computes EOF of a matrix, designed for GRACE/GRACEFO/IceSat/IceSat2 datasets

% L are the eigenvalues of the covariance matrix ( ie. they are normalized
% by 1/(m-1), where m is the number of rows ).  

% EC are the expansion coefficients (PCs in other terminology) 

% percentvar holds the percent variance explained by each eigenval
% c holds the total percent captured by EOFs 1-3
% b is the input matrix minus the decomposition. Should be ~0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Argument Processing

if ~exist('norm', 'var')
  norm = false; % default no normalization
end

if ~exist('dt', 'var')
  dt = true; % default detrend
end

if nargin < 1
   ps();
end
%% Data Import

[tag1, tag2] = tag(group, ds); % strings for dir names, tag1 is group, tag2 is ds

current = cd; % string of current directory
datadir = fullfile(current, sprintf("../results/matvars/%s/%s", tag1, tag2));
%outdir = fullfile(current, sprintf("../results/EOF/%s/%s", tag1, tag2));

data = load(sprintf("%s/data.mat", datadir));
data = data.data; % loads mat with points 
U = data(3:end, :); % removes lat/lon header

%% Normalization / Detrend
s = size(U);

% Normalize by standard deviation if desired.
mask = isnan(U);
if norm
  norms = std(U, 'omitnan');
else
  norms = ones([1,s(2)]);
end
U(mask) = 0;
mask2 = isnan(norms);
norms(mask2) = 0;
U = U * diag(1./norms);

% detrend if selected *** start here
if dt
   warning('off', 'MATLAB:detrend:PolyNotUnique')
   U = detrend(U, 1, 'omitnan');
end

%% SVD

% Use svd in case we want all EOFs - quicker.
mask3 = isnan(U);
U(mask3) = 1;

[C, lambda, EOFs] = svd(U);

a = C*lambda*EOFs;
b = U - a;

% Compute EC's and L
% EC = C * lambda; % Expansion coefficients.
L = diag( lambda ) .^ 2 / (s(1)-1); % eigenvalues.
percentvar = L/sum(L);
c = sum(percentvar(1:3));

% Compute error.
%diff=(U-EC*EOFs');
%error=sqrt( sum( diff .* conj(diff) ) );
end