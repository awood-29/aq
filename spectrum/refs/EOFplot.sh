#!/usr/bin/env bash
# 
# Creator: Andrew Wood
# Date Created: 4/28/22
# Last Modified: 4/28/22
# EOF Ascii Table Plotter
# takes output from EOF.m (lat, lon, EOF value) and plots on grid

# inputs
# 1: group
# 2: dataset
# 3: filename of table (eg E1)

group=$1
ds=$2
fn=$3
fn2=$4
fn3=$5

case $group in
    1) # Full Time Series
        grouptag="full"
        ;;

    2) # 2019-2021
        grouptag="2019_21"
        ;;
    *)
        echo no group specified
        return
        ;;
esac

case $ds in
    # 1) # CSR L2
    # 
    # 2) # GFZ L2
    # 
    # 3 # JPL L2
            
    4) # CSR L3
        dstag="CSR"
        ;;
    5) # GFZ L3
        dstag="GFZ"
        ;;
    6) # JPL L3
        dstag="JPL"
        ;;
    # 7 # JPL Mascons
            
    8) # Cumulative CSR L3
        dstag="cCSR"
        ;;
    9) # Cumulative GFZ L3
        dstag="cGFZ"
        ;;
    10) # Cumulative JPL L3
        dstag="cJPL"
        ;;
    # 11 # Cumulative JPL Mascons
    *)
        echo No dataset specified
        return
        ;;
esac

current=$(pwd)
datadir="$current/../results/EOF/$grouptag/$dstag"
fnpath="$datadir/$fn"
name=${fn::-3} #removes file extension
out=$datadir/$name

pro="-Js0/-90/12c/1" 
region="-R-180/180/-90/-60" 


gmt begin $out png
    gmt grdimage $fnpath $region $pro -Q -t30
    gmt basemap $region $pro -B30g15 -Ba30 -BWSNE
    gmt colorbar -DJBC+e $region $pro -Bpxa2Rf1d5 #-Bya+lcm
    gmt pscoast $region $pro -W.8p
gmt end 


fnpath2="$datadir/$fn2"
name2=${fn2::-3} #removes file extension
out2=$datadir/$name2

pro="-Js0/-90/12c/1" 
region="-R-180/180/-90/-60" 


gmt begin $out2 png
    gmt grdimage $fnpath2 $region $pro -Q -t30
    gmt basemap $region $pro -B30g15 -Ba30 -BWSNE
    gmt colorbar -DJBC+e $region $pro -Bpxa2Rf1d5 #-Bya+lcm
    gmt pscoast $region $pro -W.8p
gmt end 

fnpath3="$datadir/$fn3"
name3=${fn3::-3} #removes file extension
out3=$datadir/$name3

pro="-Js0/-90/12c/1" 
region="-R-180/180/-90/-60" 


gmt begin $out3 png
    gmt grdimage $fnpath3 $region $pro -Q -t30
    gmt basemap $region $pro -B30g15 -Ba30 -BWSNE
    gmt colorbar -DJBC+e $region $pro -Bpxa2Rf1d5 #-Bya+lcm
    gmt pscoast $region $pro -W.8p
gmt end 


#        gmt makecpt -A0 -Cpolar -Ic -T-8/8 # starts new cpt for lwe color
