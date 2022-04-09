#!/usr/bin/env bash
# 
# Creator: Andrew Wood
# Date Created: 4/9/22
# Last Modified: 4/9/22

sizeFolder () {
# resizes all downloaded grids to correct region (0.5, 359.5, -89.5, -59.5)

fns=$(ls -lh $1 | sed '1d' | awk '{print $9}') # head is just a debug statement for now


while read -r line;
do
    name=${line::-3} #removes file extension
    echo Using file "$line";
    gmt begin 
        gmt grdcut $1/$name.nc?lwe_thickness -G$1/$line -R0.5/359.5/-89.5/-59.5
    gmt end 
done <<< $fns #reads line by line from list of files

}

#sizeFolder CSR
sizeFolder GFZ 
sizeFolder JPL
sizeFolder cCSR
sizeFolder cGFZ 
sizeFolder cJPL
sizeFolder mascon 
sizeFolder cmascon
