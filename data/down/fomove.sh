#!/usr/bin/env bash
# 
# Creator: Andrew Wood
# Date Created: 4/25/22
# Last Modified: 4/25/22

data="$1"
out="$2"

ls -lh $data | sed '1d' | awk '{print $9}' | tail -n -41 > names.txt

while read -r fn <&3 ;
do
    mv $data$fn $out$fn
done 3< "names.txt" 
