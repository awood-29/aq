#!/usr/bin/env bash

# Antarctica Basemap
# prints topographical basemap of Antarctica
# differs from base.sh, which holds only the GMT
# commands for the plot

# Creator: Andrew Wood
# Date Created: 3/18/22
# Last Modified: 3/21/22

# Options: -q for lowres
# Inputs: output file name

# sets grid to lowres, then runs
Set() {
    grid="@earth_relief_10m"

# sets filename to default if unset, $a if set
out=${1:-aq} 

if [[ -z "$1" ]]; then
    printf "No image file output given, naming aq.png as default\n\n"
fi

pro="-Js0/-90/12c/1"
r="-R-180/180/-90/-60"

gmt begin $out png
    #gmt pscoast $r $pro -B -W 
    #gmt grd2cpt el3.nc -Cgray #-M -Ic
    gmt grdimage $grid $r $pro -B -Cbm.cpt
    #gmt pscoast $r $pro -B -W 
gmt end show

}

###########################################
############ Main Script ##################
###########################################

# -q option for quicker relief
while getopts ":q" option; do
   case $option in
      q) # set grid to lowres
         printf "Using lowres grid\n\n"
         Set $2
         exit;;
      \?) # Invalid option
         printf "Error: Invalid option\n\n"
         exit;;
   esac
done

# sets filename to default if unset, $1 if set
out=${1:-aq} 

# sets grid to default if unset
useGrid=${grid:="@earth_relief_01m"} 

if [[ -z "$1" ]]; then
    printf "No image file output given, naming aq.png as default\n\n"
fi

pro="-Js0/-90/12c/1"
r="-R-180/180/-90/-60"

gmt begin $out png
    gmt grdimage $useGrid $r $pro -B -Cbm.cpt
    #gmt pscoast $r $pro -B -W 
gmt end show




