#!/usr/bin/env bash

# Path: DR shifting/script/stopSync.sh
mainPath='/home/nickghule/data/cris/DR shifting'
source "$mainPath"/resource/globals.sh


pmuutmls03="10.129.1.150"
pmuutmls04="10.129.1.151"

# Stop ASA 12 sync
# Instance 1 on pmuutmls03
ssh relcrml12@"$pmuutmls03" "bash -s /mobiscript/asa12/uts/sh/stop'$1'ml1"
echo -en "Stopping Sync (ML 12 Instance 1) :"
loadingAnimation 4

# check if process with dsn_ml12_pucrut_db is running on pmuutmls03
if ssh relcrml12@"$pmuutmls03" "pgrep dsn_ml12_pucrut_db" > /dev/null
then
    echo -e " $redCross"
    printf "\e[33m%s\e[0m\n" "Ml12 database is still running. Please stop manually."
    echo -e "Press enter to continue"
    read -r
    exit 1
else
    echo -e " $greenCheck"
fi

# instance 2 on pmuutmls04
ssh relcrml12@"$pmuutmls04" "bash -s /mobiscript/asa12/uts/sh/stop'$1'ml2"
echo -en "Stopping Sync (ML 12 Instance 2) :"
loadingAnimation 4

# check if process with dsn_ml12_pucrut_db is running on pmuutmls04
if ssh relcrml12@"$pmuutmls04" "pgrep dsn_ml12_pucrut_db" > /dev/null
then
    echo -e " $redCross"
    printf "\e[33m%s\e[0m\n" "Ml12 database is still running. Please stop manually."
    echo -e "Press enter to continue"
    read -r
    exit 1
else
    echo -e " $greenCheck"
fi


# Stop ASA 17 sync
# Instance 1 on pmuutmls03
ssh relcrml17@"$pmuutmls03" "bash -s /mobiscript/asa17/uts/sh/stop'$1'ml1"
echo -en "Stopping Sync (ML 17 Instance 1) :"
loadingAnimation 4

# check if process with dsn_ml17_pucrut_db is running on pmuutmls03
if ssh relcrml17@"$pmuutmls03" "pgrep dsn_ml17_pucrut_db" > /dev/null
then
    echo -e " $redCross"
    printf "\e[33m%s\e[0m\n" "Ml17 database is still running. Please stop manually."
    echo -e "Press enter to continue"
    read -r
    exit 1
else
    echo -e " $greenCheck"
fi

# instance 2 on pmuutmls04
ssh relcrml17@"$pmuutmls04" "bash -s /mobiscript/asa17/uts/sh/stop'$1'ml2"
echo -en "Stopping Sync (ML 17 Instance 2) :"
loadingAnimation 4

# check if process with dsn_ml17_pucrut_db is running on pmuutmls04
if ssh relcrml17@"$pmuutmls04" "pgrep dsn_ml17_pucrut_db" > /dev/null
then
    echo -e " $redCross"
    printf "\e[33m%s\e[0m\n" "Ml17 database is still running. Please stop manually."
    echo -e "Press enter to continue"
    read -r
    exit 1
else
    echo -e " $greenCheck"
fi