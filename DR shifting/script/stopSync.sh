#!/usr/bin/env bash

# Path: DR shifting/script/stopSync.sh
mainPath='/home/nickghule/data/cris/DR shifting'
source "$mainPath"/resource/globals.sh


pmuutmls03="10.0.100.129"
pmuutmls04="10.0.100.129"

# Stop ASA 12 sync
# Instance 1 on pmuutmls03
ssh -n relcrml12@"$pmuutmls03" "bash /mobiscript/asa12/uts/sh/stop""$1""ml1" > /dev/null 2>&1
echo -en "Stopping Sync (ML 12 Instance 1) :"
loadingAnimation 4

# check if process with dsn_ml12_pucrut_db is running on pmuutmls03
if ssh relcrml12@"$pmuutmls03" "pgrep -fc dsn_ml12_pucrut_db1" > /dev/null
then

    echo -e " $redCross"
    printf "\e[33m%s\e[0m\n" "Ml12 database is still running. Please stop manually."
    echo -en "Press enter to continue"
    read -r
    printf "\033[1A\033[0K"
    printf "\033[1A\033[0K"
else
    echo -e " $greenCheck"
fi

# instance 2 on pmuutmls04
ssh relcrml12@"$pmuutmls04" "bash /mobiscript/asa12/uts/sh/stop'$1'ml2" > /dev/null 2>&1
echo -en "Stopping Sync (ML 12 Instance 2) :"
loadingAnimation 4

# check if process with dsn_ml12_pucrut_db is running on pmuutmls04
if ssh relcrml12@"$pmuutmls04" "pgrep -fc dsn_ml12_pucrut_db2" > /dev/null
then
    echo -e " $redCross"
    printf "\e[33m%s\e[0m\n" "Ml12 database is still running. Please stop manually."
    echo -en "Press enter to continue"
    read -r
    # delete last two lines
    printf "\033[1A\033[0K"
    printf "\033[1A\033[0K"
else
    echo -e " $greenCheck"
fi


# Stop ASA 17 sync
# Instance 1 on pmuutmls03
ssh relcrml17@"$pmuutmls03" "bash /mobiscript/asa17/uts/sh/stop'$1'ml1" > /dev/null 2>&1
echo -en "Stopping Sync (ML 17 Instance 1) :"
loadingAnimation 4

# check if process with dsn_ml17_pucrut_db is running on pmuutmls03
if ssh relcrml17@"$pmuutmls03" "pgrep -fc dsn_ml17_pucrut_db1" > /dev/null
then
    echo -e " $redCross"
    printf "\e[33m%s\e[0m\n" "Ml17 database is still running. Please stop manually."
    echo -en "Press enter to continue"
    read -r
    printf "\033[1A\033[0K"
    printf "\033[1A\033[0K"
else
    echo -e " $greenCheck"
fi

# instance 2 on pmuutmls04
ssh relcrml17@"$pmuutmls04" "bash /mobiscript/asa17/uts/sh/stop'$1'ml2" > /dev/null 2>&1
echo -en "Stopping Sync (ML 17 Instance 2) :"
loadingAnimation 4

# check if process with dsn_ml17_pucrut_db is running on pmuutmls04
if ssh relcrml17@"$pmuutmls04" "pgrep -fc dsn_ml17_pucrut_db2" > /dev/null
then
    echo -e " $redCross"
    printf "\e[33m%s\e[0m\n" "Ml17 database is still running. Please stop manually."
    echo -en "Press enter to continue"
    read -r
    printf "\033[1A\033[0K"
    printf "\033[1A\033[0K"
else
    echo -e " $greenCheck"
fi