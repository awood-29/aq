#!/usr/bin/env bash
# 
# Creator: Andrew Wood
# Date Created: 
# Last Modified: 

gmt begin tes png
    gmt grdimage $1?lwe_thickness -JN12c -Rg
    gmt pscoast -Rg -JN12c -W
gmt end show
