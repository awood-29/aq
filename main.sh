#!/usr/bin/env bash

# GRACE Time Series Image Generator

# Creator: Andrew Wood
# Date Created: 3/23/22
# Last Modified: 4/9/22

# adapted from simple grid plotter and basemap

## INPUT FORM ##
# ./main.sh input -options

# input: dataset number

## Options ##
# -l : lists available datasets
# -n : basemaps are not plotted, just coastlines
# -q : quick relief grid used

# timer out of curiosity
SECONDS=0

###########################################
############ Environment Setup ############
###########################################

# Input Assignment
ds=$1 # assigns dataset input

# adding necessary paths to env
current=$(pwd)
export PATH="$current/refs:$PATH" # adds refs (all helper scripts being called)
#export PATH="$current/data/l2:$PATH" # adds Level 2 data
#export PATH="$current/data/l3:$PATH" # adds Level 3 data


##########################################
############ Options Handling ############
##########################################

# first checks for -l option
while getopts ":lnq" option; do
   case $option in
      l) # list dataset options
         printf "Available Datasets:\n"
         printf "1: Level 2 CSR\n"
         printf "2: Level 2 GFZ\n"
         printf "3: Level 2 JPL\n"
         printf "4: Level 3 CSR\n"
         printf "5: Level 3 GFZ\n"
         printf "6: Level 3 JPL\n"
         printf "7: JPL Mascons\n"
         printf "8: Cumulative Level 3 CSR\n"
         printf "9: Cumulative Level 3 GFZ\n"
         printf "10: Cumulative Level 3 JPL\n"
         printf "11: Cumulative JPL Mascons\n"
          exit;;
      n)
          ds=$2
          opt="n"
      ;;
      q)
          ds=$2
          opt="q"
      ;;
   esac
done


##########################################
############ Main Script Body ############
##########################################

# selects folder based on dataset selection

case $ds in
    1) # CSR L2
        folder="data/l2/CSR"
        out="results/l2/CSR"
        ;;
    2) # GFZ L2
        folder="data/l2/GFZ"
        out="results/l2/GFZ"
        ;;
    3) # JPL L2
        folder="data/l2/JPL"
        out="results/l2/JPL"
        ;;
    4) # CSR L3
        folder="data/l3/CSR"
        out="results/l3/CSR"
        ;;
    5) # GFZ L3
        folder="data/l3/GFZ"
        out="results/l3/GFZ"
        ;;
    6) # JPL L3
        folder="data/l3/JPL"
        out="results/l3/JPL"
        ;;
    7) # JPL Mascons
        folder="data/l3/mascon"
        out="results/l3/mascon"
        ;;
    8) # Cumulative CSR L3
        folder="data/l3/cCSR"
        out="results/l3/cCSR"
        ;;
    9) # Cumulative GFZ L3
        folder="data/l3/cGFZ"
        out="results/l3/cGFZ"
        ;;
    10) # Cumulative JPL L3
        folder="data/l3/cJPL"
        out="results/l3/cJPL"
        ;;
    11) # Cumulative JPL Mascons
        folder="data/l3/cmascon"
        out="results/l3/cmascon"
        ;;
 
    *)
        printf "Error: No dataset specified!\n\n"
        printf "Use option -l to view available datasets\n\n"
        exit 3
        ;;
esac

#export PATH="$current/$folder:$PATH" # adds folder to path
folder="$current/$folder/" # changes folder to full dir name
out="$current/$out" # changes output folder to full dir name

# setting opt if unset
opt=${opt:-"z"}

if [ $opt = n ]; then
# no basemap
     printf "Plotting without basemap\n\n"
        plotn.sh $folder
        mv *.png $out/nobm # moves all images to correct folder
elif [ $opt = q ]; then
# set grid to lowres
     printf "Using lowres grid\n\n"
        plotq.sh $folder
        mv *.png $out # moves all images to correct folder
else
# if no options, calls the regular
     printf "using regular grid\n\n"
        plot.sh $folder
        mv *.png $out # moves all images to correct folder
fi

# ending timer
if (( $SECONDS > 3600 )) ; then
    let "hours=SECONDS/3600"
    let "minutes=(SECONDS%3600)/60"
    let "seconds=(SECONDS%3600)%60"
    echo "Completed in $hours hour(s), $minutes minute(s) and $seconds second(s)" 
elif (( $SECONDS > 60 )) ; then
    let "minutes=(SECONDS%3600)/60"
    let "seconds=(SECONDS%3600)%60"
    echo "Completed in $minutes minute(s) and $seconds second(s)"
else
    echo "Completed in $SECONDS seconds"
fi
