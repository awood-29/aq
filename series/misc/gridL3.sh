#!/usr/bin/env bash

# Simple GMT Grid Plotter

# Creator: Andrew Wood
# Date Created: 3/3/22
# Last Modified: 3/23/22

file=$1 #filename

if [[ -z "$1" ]]; then
    echo No input grid provided!
    exit 1
fi

outfn=$2
out=${outfn:-L3grid} # sets filename to default if unset, $2 if set

if [[ -z "$2" ]]; then
    echo No image file output given, naming L3grid.png as default
fi

pro="-Js0/-90/12c/1" 
r="-R-180/180/-90/-60" 

gmt begin $out png
    $(bash base.sh) # prints out basemap 
    #gmt grd2cpt $file?lwe_thickness -A0 -Carctic.cpt -M -Ic
    gmt makecpt -A0 -Cpolar -Ic -T-4/4
    gmt grdimage $file?lwe_thickness $r $pro -Q -t30
    gmt colorbar -DJBC+e $r $pro -Baf 
    #gmt pscoast $r $pro -B -W
gmt end show


