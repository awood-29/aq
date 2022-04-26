#!/usr/bin/env bash
# 
# Creator: Andrew Wood
# Date Created: 4/25/22
# Last Modified: 4/26/22

data=$1
out=$2

ls -lh $data | sed '1d' | awk '{print $9}' > names.txt # can add head/tail/sed/awk line in for subsets

while read -r fn <&3 ;
do
    mv $data$fn $out$fn
done 3< "names.txt" 
rm names.txt
