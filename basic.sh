#!/usr/bin/env bash
# Sample Plot Subscript
# Creator: Andrew Wood
# Date Created: 3/29/22
# Last Modified: 3/31/22

## Inputs ##
# $1: grid to plot

## Options ##
# -n : basemaps are not plotted, just coastlines
# -q : quick relief grid used

## Function Definitions ##

Plotn() {
pro="-Js0/-90/12c/1" 
r="-R-180/180/-90/-60" 

grid=$1

#plotting
name=${grid::-3} #removes file extension
name="${name}n"

gmt begin $name png
    gmt makecpt -A0 -Cpolar -Ic -T-4/4 # starts new cpt for lwe color
    gmt grdimage $grid?lwe_thickness $r $pro -Q -t30
    gmt colorbar -DJBC+e $r $pro -Baf 
    gmt pscoast $r $pro -B -W
gmt end show
}

Plotq() {
pro="-Js0/-90/12c/1" 
r="-R-180/180/-90/-60" 
bm="$refs/bm.cpt"

grid=$1

#plotting
name=${grid::-3} #removes file extension
name="${name}q"

gmt begin $name png
    gmt grdimage @earth_relief_10m $r $pro -B -C$bm # prints out basemap 
    gmt makecpt -A0 -Cpolar -Ic -T-4/4 # starts new cpt for lwe color
    gmt grdimage $grid?lwe_thickness $r $pro -Q -t30
    gmt colorbar -DJBC+e $r $pro -Baf 
    gmt pscoast $r $pro -B -W
gmt end show
}

Plot() {
pro="-Js0/-90/12c/1" 
r="-R-180/180/-90/-60" 
bm="$refs/bm.cpt"

#plotting
grid=$1
name=${grid::-3} #removes file extension

gmt begin $name png
    gmt grdimage @earth_relief_01m $r $pro -B -C$bm # prints out basemap 
    gmt makecpt -A0 -Cpolar -Ic -T-4/4 # starts new cpt for lwe color
    gmt grdimage $grid?lwe_thickness $r $pro -Q -t30
    gmt colorbar -DJBC+e $r $pro -Baf 
    gmt pscoast $r $pro -B -W
gmt end show
}


#######################
###### Main Body ######
#######################

# adding entire workdir to path, allowing it to be plot a .nc from anywhere
refs="/mnt/c/Users/amwoo/Desktop/Stuff/GT/Research/series/refs"
main="/mnt/c/Users/amwoo/Desktop/Stuff/GT/Research/series"
export PATH="$main:$refs:$PATH"

# If option passed, saves filename to grid
while getopts ":nq" option; do
   case $option in
      n)
          grid=$2
          opt="n"
      ;;
      q)
          grid=$2
          opt="q"
      ;;
   esac
done

# setting opt if unset
opt=${opt:-"z"}

if [ $opt = n ]; then
# no basemap
     printf "Plotting without basemap\n\n"
     Plotn $grid
elif [ $opt = q ]; then
# set grid to lowres
     printf "Using lowres grid\n\n"
     Plotq $grid
else
# if no options, calls the regular
     printf "using regular grid\n\n"
     # input: grid to plot
     grid=$1
     Plot $grid
fi


