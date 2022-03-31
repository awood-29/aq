#!/usr/bin/env bash

# Antarctica Basemap 
# contains GMT modern mode commands for
# topographical basemap, allowing it to be
# called in other modern mode sessions

# Creator: Andrew Wood
# Date Created: 3/18/22
# Last Modified: 3/21/22

# Options: -q for lowres                                                                                                    13 # Inputs: output file name
 # sets grid to lowres, then runs
Set() {
    grid="@earth_relief_10m"

    pro="-Js0/-90/12c/1"
    r="-R-180/180/-90/-60"

    # only command for imaging basemap
    echo gmt grdimage $grid $r $pro -B -Cbm.cpt
}


###########################################
############ Main Script ##################
###########################################

# -q option for quicker relief
while getopts ":q" option; do
    case $option in
        q) # set grid to lowres
            printf "Using lowres grid\n\n"
            Set $2
            exit;;
        \?) # Invalid option
            printf "Error: Invalid option\n\n"
            exit;;
    esac
done

# sets grid to default if unset
useGrid=${grid:="@earth_relief_01m"}

pro="-Js0/-90/12c/1"
r="-R-180/180/-90/-60"

echo gmt grdimage $useGrid $r $pro -B -Cbm.cpt




