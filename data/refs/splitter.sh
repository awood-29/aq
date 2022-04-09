#!/usr/bin/env bash
# 
# Grid Separator Loop
#
# Creator: Andrew Wood
# Date Created: 3/29/22
# Last Modified: 3/29/22 

# Inputs
# $1: grid file inputs
# $2: text list of desired names

grid=$1
name=$2

# Fill these in
startval=164
count=$((startval))
stopval=204 # start and stop increments. 204 for now b/c other l3 sources don't have 205 yet
path="l3/mascon/" # insert path to location here

# reads each name line, assigns timestep to it. Saves to desired location
while read -r a; do
    if [[ $count -le $stopval ]]; then
        cdo -seltimestep,$count $grid "$path$a"
        printf "Count is $count\nName is $a\n"
    fi
    count=$((count+1))
done < $name

