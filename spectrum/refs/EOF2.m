function [Cs, ECi, pv, c, Ls] = EOF2(group, ds)
%% GRACE EOF
% Description
% Author: Andrew Wood
% Created: 4/28/22
% Last Edited: 4/28/22
% Computes EOF of a matrix, designed for GRACE/GRACEFO/IceSat/IceSat2 datasets
% Note: this is just a test to make sure svd does what I think it does

% L are the eigenvalues of the covariance matrix ( ie. they are normalized
% by 1/(m-1), where m is the number of rows ).  

% EC are the expansion coefficients (PCs in other terminology) 

% pv holds the percent variance explained by each eigenval
% c holds the total percent captured by EOFs 1-3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Argument Processing

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
% latlon = data(1:2, :);
U = data(3:end, :); % removes lat/lon header
skipcols = isnan(sum(U)); % undefined cols
% skipped = latlon(:, skipcols); % latlon points skipped
% points = latlon(:, ~skipcols); % latlon points left
U = U(:, ~skipcols); % removes all NaN

% removing NaN cols


%% Detrend + SVD

% detrend if selected *** start here
if dt
   warning('off', 'MATLAB:detrend:PolyNotUnique')
   U = detrend(U, 1, 'omitnan');
   %U = detrend(U, 0, 'omitnan');
end

covar = U'*U; % covariance matrix
[C, L] = eig(covar); % eigenvals + vecs
% eigenvals on diagonal of L, vecs column vecs of C
[~, ind] = sort(diag(L), 'descend'); % sorting eigenvals + vecs
Ls = L(ind, ind); % sorts vals
Cs = C(:, ind); % sorts vecs

ECi = U * Cs; % expansion coeffs corresponding to each eigenval
pv = diag(Ls)/trace(Ls);
c = sum(pv(1:3));

end