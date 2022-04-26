# GRACE/GRACE-FO Plotting and and Analysis
### Creator: Andrew Wood
##### Project Start: 3/17/22

### Contents
#### Main 
###### Scripts: Time Series
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

###### Directories
*data*: Archives all data, includes curl scripts for download
*refs*: Contains scripts called by others, reference information
*results*: contains sorted png results

