# GRACE/GRACE-FO Plotting and and Analysis
### Creator: Andrew Wood
##### Project Start: 3/17/22

## Contents
### Main 
##### data
###### mod
*gz2nc.sh*:
Description: zipped SH coeffs to grid
Inputs: relative path to folder with coeff files

*splitter.sh*:
Description: de-stacks layered GRACE grids that have a timestep for each month into individual files
Inputs: 1: grid input, 2: text list of new filenames

*sum.sh*:
Description: single month change grids > cumulative
Inputs: 1: relative path to data directory, 2: relative path to output dir

*resize.sh*:
Description: resizes downloaded grids to antarctic region
Inputs: path to dir with grids
Note: Has not been tested post-update

###### down
*download.sh*:
Description: downloads files corresponding to list of urls and names
Inputs: 1: text list of urls, one on each line; 2: same for names, 3: path to output dir

*gdwnld.sh*:
Description: improved download script for full GRACE ts
Inputs: None, make sure to change center, center2, and outpath manually
Note: gfzrd.sh and jplrd.sh supplements must have been deleted or something,
      hopefully won't have to redownload anytime soon

*qd.sh*:
Description: quick redownload format for a couple urls if accidental override
Inputs: none, add links in for a, b, c...

*move.sh*:
Description: quick move script for subsets of folders with awkward reg exp match
Inputs: 1: path to data, 2: path to out


##### series
*basic.sh*:
Description: Basic plotter for .nc files. Primarily used for testing plot updates
             before repeating for large datasets.
Inputs: Grid to plot
Outputs: png to folder
Options: -n for no basemap, -q for quick render basemap 

*main.sh*:
Description: Plots full datasets, calling individual scripts in the refs folder.
             Datasets are determined by a numeric tagging system.
Inputs: Dataset number (max 1)
Outputs: pngs mover to corresponding results folder
Options: -l for list of datasets, -n for no basemap, -q for quick render basemap 

*run.sh*:
Description: Simple script to call main.sh a couple times for sequential plotting
Inputs: None
Outputs: Outputs of whatever functions it calls
Options: None

###### misc: random scripts

###### refs
*plot_.sh*:
Description: subscripts to plot groups of grids. _ is regular, n is no basemap, q is lowres basemap

##### spectrum
*specvars.m*:
Description: Sets up matlab variables for spectrum analysis
Inputs: dataset, group number
 
*specplot.m*:
Description: Plots time series and Lomb-Scargle periodogram from variable created by specvars
Inputs: dataset, group, latitude range, longitude range, save flag

*txtgen.m*:
Description: reformats data to Abinay format, writes text files
Inputs: none, edit group/ds in first lines 

*avggen.m*:
Description: writes text files with averages, from csr, gfz, and jpl text files from txtgen
Inputs: none 












