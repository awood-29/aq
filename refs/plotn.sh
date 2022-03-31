#!/usr/bin/env bash
# No Basemap Plot Subscript
# Creator: Andrew Wood
# Date Created: 3/25/22
# Last Modified: 3/25/22
# identical to regular plot code, doesn't plot fancy background

# First, gathering list of files to plot in dir
fns=$(ls -lh $1 | sed '1d' | awk '{print $9}') # head is just a debug statement for now

#export PATH="$1:$PATH" # adds folder to path
#echo $PATH\n
# While loop to take file, plot, and save result to folder
while read -r line;
do
   echo Using file "$line";

   pro="-Js0/-90/12c/1" 
   r="-R-180/180/-90/-60" 
   
   #plotting
   name=${line::-3} #removes file extension
   name="${name}n"
    gmt begin $name png
        gmt makecpt -A0 -Cpolar -Ic -T-8/8 # starts new cpt for lwe color
        gmt grdimage $1$line?lwe_thickness $r $pro -Q -t30
        gmt colorbar -DJBC+e $r $pro -Baf 
        gmt pscoast $r $pro -B -W
    gmt end 
done <<< $fns #reads line by line from list of files


