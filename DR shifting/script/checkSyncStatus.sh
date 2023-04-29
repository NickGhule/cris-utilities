#!/usr/bin/env bash

mainPath='/home/nickghule/data/cris/DR shifting'
source "$mainPath"/resource/globals.sh

case "$1" in
    "CR")
        dbCon="filePath"
        ;;
    "WR")
        dbCon="filePath"
        ;;
    "WC")
        dbCon="filePath"
        ;;
    "KR")
        dbCon="filePath"
        ;;
    *)
        echo "Invalid Zone Code"
        exit 1
        ;;
esac


while true; do
    # get sync status from both production and DR
    echo -en "Sync status: "
    # TODO: uncomment below line and remove next two lines
    # productionSyncStatus="$($dbCon -e 'select publication_name , progress from ml_subscription order by publication_name;')"
    # drSyncStatus="$($dbCon -e 'select publication_name , progress from ml_subscription order by publication_name;')"
    productionSyncStatus="$(cat output/prodSync.txt)"
    drSyncStatus="$(cat output/drsync.txt)"

    loadingAnimation 4
    # remove last line from both files
    productionSyncStatus="$(echo "$productionSyncStatus" | head -n -1)"
    drSyncStatus="$(echo "$drSyncStatus" | head -n -1)"

    #  check if production and DR sync status are same
    if [ "$productionSyncStatus" == "$drSyncStatus" ]; then
        echo -e "$greenCheck"
        exit 0
    else
        echo -e "$redCross" "Sync Mismatch"
        echo -e "$(diff <(echo "$productionSyncStatus") <(echo "$drSyncStatus"))"
        printf "\e[33m%s\e[0m\n" "Sync status mismatch. Please check manually."
        read -r -p "Do you want to check again? (Yes/No) :" yn
        # delete last lines
        printf "\033[3A"
        case $yn in
            [Yy]* ) continue;;
            [Nn]* ) exit 1;;
            * ) echo "Please answer yes or no.";;
        esac
    fi

    
done
