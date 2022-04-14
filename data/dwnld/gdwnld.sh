#!/usr/bin/env bash
# 
# Creator: Andrew Wood
# Date Created: 4/14/22
# Last Modified: 4/14/22

# Improved download script
# Steps:
# Run this for (UT)CSR, GFZ(OP), and JPL(EM)
# Run gfzrd.sh to fix any leftovers for gfz
# Run jplrd.sh to fix any leftovers for jpl
# Run resize.sh to cut to size

center="JPL"
center2="JPLEM"
outpath="$(pwd)/../l3/JPL"
names="$(pwd)/names/names.txt"
daystart="$(pwd)/urls/ds.txt"
dayend="$(pwd)/urls/de.txt"
yearstart="$(pwd)/urls/ys.txt"
yearend="$(pwd)/urls/ye.txt"

# If you screw this up make sure to use dos2unix to convert

while read -r fn <&3 && read -r ds <&4 && read -r de <&5 && read -r ys <&6 && read -r ye <&7; 
do
    url="https://podaac-tools.jpl.nasa.gov/drive/files/allData/grace/L3/land_mass/RL06/v04/$center/GRD-3_$ys$ds-$ye${de}_GRAC_${center2}_BA01_0600_LND_v04.nc"
    curl -o "$outpath/$fn.nc" -u awood29:CK6MJ@ODzsPFTeNG3Ck $url # downloads file from url, names
done 3< "$names" 4< "$daystart" 5< "$dayend" 6< "$yearstart" 7< "$yearend" #reads line by line from list of files and sizes


