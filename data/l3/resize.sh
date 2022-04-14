#!/usr/bin/env bash
# 
# Creator: Andrew Wood
# Date Created: 4/9/22
# Last Modified: 4/14/22

sizeFolder () {
# resizes all downloaded grids to correct region (0.5, 359.5, -89.5, -59.5)

#fns=$(ls -lh $1 | sed '1d' | awk '{print $9}' | head -n -41) # head is just a debug statement for now
#size=$(ls -l $1 | sed '1d' | awk '{print $5}' | head -n -41) # same deal, gathers sizes
fns="$(pwd)/rs.txt"


while read -r fn <&3 ; #&& read -r big <&4;
do
    # if [[ $big -gt 50000 ]]; then # only hits grids larger than the size desired
        name=${fn::-3} #removes file extension
        echo Using file "$fn";
        gmt begin 
            gmt grdcut $1/$name.nc?lwe_thickness -G$1/$fn -R0.5/359.5/-89.5/-59.5
        gmt end 
    # fi
done 3< "$fns" # 4< "$size" #reads line by line from list of files and sizes
}

#sizeFolder CSR
sizeFolder GFZ 
sizeFolder JPL
#sizeFolder cCSR
#sizeFolder cGFZ 
#sizeFolder cJPL
#sizeFolder mascon 
#sizeFolder cmascon
