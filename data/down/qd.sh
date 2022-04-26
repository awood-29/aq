#!/usr/bin/env bash
# 
# Creator: Andrew Wood
# Date Created: 4/9/22
# Last Modified: 

a="https://podaac-tools.jpl.nasa.gov/drive/files/allData/gracefo/L3/land_mass/RL06/v04/CSR/GRD-3_2018152-2018181_GRFO_UTCSR_BA01_0600_LND_v04.nc"
b="https://podaac-tools.jpl.nasa.gov/drive/files/allData/gracefo/L3/land_mass/RL06/v04/CSR/GRD-3_2018182-2018199_GRFO_UTCSR_BA01_0600_LND_v04.nc"
c="https://podaac-tools.jpl.nasa.gov/drive/files/allData/gracefo/L3/land_mass/RL06/v04/CSR/GRD-3_2018295-2018313_GRFO_UTCSR_BA01_0600_LND_v04.nc"
d="https://podaac-tools.jpl.nasa.gov/drive/files/allData/gracefo/L3/land_mass/RL06/v04/CSR/GRD-3_2018305-2018334_GRFO_UTCSR_BA01_0600_LND_v04.nc"

curl -o "$(pwd)/CSR/18_06.nc" -u awood29:CK6MJ@ODzsPFTeNG3Ck $a # downloads file from url, names
curl -o "$(pwd)/CSR/18_07.nc" -u awood29:CK6MJ@ODzsPFTeNG3Ck $b # downloads file from url, names
curl -o "$(pwd)/CSR/18_10.nc" -u awood29:CK6MJ@ODzsPFTeNG3Ck $c # downloads file from url, names
curl -o "$(pwd)/CSR/18_11.nc" -u awood29:CK6MJ@ODzsPFTeNG3Ck $d # downloads file from url, names

