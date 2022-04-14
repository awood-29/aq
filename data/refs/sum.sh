#!/usr/bin/env bash
# 
# Cumulative Grid Producer
#
# Creator: Andrew Wood
# Date Created: 3/31/22
# Last Modified: 4/14/22

# Description: Takes a folder of single-month grid files and 
#              transforms to a cumulative set of grids

# Inputs: 
# $1: relative filepath to data dir ex. ../l3/CSR 
# $2: relative path to output ex ../l3/cCSR

fns=$(ls -lh $1 | sed '1,2d' | awk '{print $9}') # list of filenames in dir, minus the initial
sum=$(ls -lh $1 | awk 'NR==2 {print $9}') # initial file

current=$(pwd)
target="$current/$1"
export PATH="$target:$PATH"

while read -r fn;
do
    add=$fn # new file to be added
    gmt grdmath "$target/$sum?lwe_thickness" "$target/$add?lwe_thickness" ADD = $add?lwe_thickness #saves sum to current dir with new filename
    sum=$add # new filename becomes the new sum
    printf "added, sum is now $sum\n"
done <<< $fns #reads line by line from list of files

mv *.nc $2 # moves all grids to correct folder
 
