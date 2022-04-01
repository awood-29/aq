#!/usr/bin/env bash
# 
# gz to grid converter
#
# Creator: Andrew Wood
# Date Created: 3/31/22
# Last Modified: 3/31/22 

# Inputs
# $1 folder of compressed spherical harmonic coeff files

path="$1"
total="$(pwd)/$path"

fns=$(ls -lh $1 | sed '1d' | awk '{print $9}') # list of filenames in dir, minus the initial

gzip $total*

while read -r fn;
do
   gunzip $total$fn
   name=${fn::-3} #removes file extension
   sed '1,125d' $total$name | awk '{print $2,$3,$4,$5}' | gmt sph2grd -G$name.nc?lwe_thickness -I0.5 -Rg # creates grid from table
done <<< $fns #reads line by line from list of files



