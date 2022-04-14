#!/usr/bin/env bash
# 
# Download script for L2/L3 PO.DAAC data
#
# Creator: Andrew Wood
# Date Created: 3/23/22
# Last Modified: 4/14/22 

# Inputs
# $1: text list of all urls
# $2: text list of desired names
# $3: path

export PATH="$(pwd)/../dwnld/urls:$(pwd)/../dwnld/names:$PATH"

url=$1
name=$2
path="$3/"

while read -r a <&5 && read -r b <&6; do
    curl -o "$path$b" -u awood29:CK6MJ@ODzsPFTeNG3Ck $a # downloads file from url, names
done 5< "$url" 6< "$name"

