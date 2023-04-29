#!/usr/bin/env bash

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

echo -en "Killing Users :"
killOutput=$($dbCon "exec sp_killUsers")
loadingAnimation 4


# TODO: check output of sp_killUsers
if [ "$killOutput" -eq 0 ]
then
    echo -e " $greenCheck"
else
    echo -e " $redCross"
    printf "\e[33m%s\e[0m\n" "Error in killing users. Please check manually."
    echo -e "Press enter to continue"
    read -r
    exit 1
fi