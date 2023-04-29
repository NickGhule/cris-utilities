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
# define list of users to be locked
usersToLock="nikhil amey"

echo -en "Locking Users :"
for user in $usersToLock; do
    "$($dbCon exec util_mum_syslogins_oprn "$user" 'L')"
done
loadingAnimation 4


lockStatus="$($dbCon exec util_mum_syslogins_oprn)"
lockOutput=0

for user in $usersToLock; do
    if [ "$(echo "$lockStatus" | grep "$user" | awk '{print $2}')" -eq 3 ]; then
        continue
    else
        lockOutput=1
        break
    fi
done

if [ "$lockOutput" -eq 0 ]
then
    echo -e " $greenCheck"
else
    echo -e " $redCross"
    printf "\e[33m%s\e[0m\n" "Error in locking users. Please check manually."
    echo -e "Press enter to continue"
    read -r
    exit 1
fi