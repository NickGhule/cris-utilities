#!/usr/bin/env bash

mainPath='/home/nickghule/data/cris/DR shifting'
source "$mainPath"/resource/globals.sh


dbConCR="filePath"
dbConWR="filePath"
dbConWC="filePath"
dbConKR="filePath"

case $1 in
    CR)
        dbCon=$dbConCR
        ;;
    WR)
        dbCon=$dbConWR
        ;;
    WC)
        dbCon=$dbConWC
        ;;
    KR)
        dbCon=$dbConKR
        ;;
    *)
        echo "Invalid Zone Code"
        exit 1
        ;;
esac
# define list of processes to be Killed
processesToKill="p1 p2"

echo -en "Killing processes :"
for process in $processesToKill; do
    "$($dbCon exec util_mum_syslogins_oprn "$process" 'K')"
done
loadingAnimation 4


killStatus="$($dbCon exec util_mum_syslogins_oprn)"
killOutput=0

for process in $processesToKill; do
    if echo "$killStatus" | grep "$process"; then
        killOutput=1
        break
    fi
done

if [ "$killOutput" -eq 0 ]
then
    echo -e " $greenCheck"
else
    echo -e " $redCross"
    printf "\e[33m%s\e[0m\n" "Error in Killing processes. Please check manually."
    echo -e "Press enter to continue"
    read -r
    printf "\033[1A\033[0K"
    printf "\033[1A\033[0K"
    printf "\033[1A\033[0K"
fi