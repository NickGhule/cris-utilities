#!/bin/bash

# This script is used to transfer stock from one zone to another zone.
dbConCR="filePath"
dbConWR="filePath"
dbConWC="filePath"
dbConKR="filePath"


# start the spinner in the backgrou

read -rp "Enter your Zone Code (CR/WR/WC/KR): " zoneCode

# Check if the zone code is valid or not CR/WR/WC/KR
case $zoneCode in
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


# Display banner for the zone
echo "==============================================="
echo "Welcome to $zoneCode Zone Transfer/Borrow Utility"
echo "==============================================="

# Select recieved or transfer
echo "1. Borrowed Stock from other Zone"
echo "2. Transferred Stock to other Zone"
read -rp "Enter your choice: " choice

clear 

case $choice in
    1)
        # Borrowed Stock from other Zone
        # valid zone codes are ('CR', 'WR', 'WC', 'KR', 'EC', 'EO', 'ER', 'KR', 'NC', 'NE', 'NF', 'NR', 'NW', 'SB', 'SC', 'SE', 'SR', 'SW')
        printf "\n\nValid Zone Codes are: CR, WR, WC, KR, EC, EO, ER, KR, NC, NE, NF, NR, NW, SB, SC, SE, SR, SW \n"
        read -rp "Enter the zone code from which you want to borrow stock: " borrowZoneCode
        transferZoneCode=$zoneCode
        if ! { [ "$borrowZoneCode" == "CR" ] || [ "$borrowZoneCode" == "WR" ] || [ "$borrowZoneCode" == "WC" ] || [ "$borrowZoneCode" == "KR" ] || [ "$borrowZoneCode" == "EC" ] || [ "$borrowZoneCode" == "EO" ] || [ "$borrowZoneCode" == "ER" ] || [ "$borrowZoneCode" == "KR" ] || [ "$borrowZoneCode" == "NC" ] || [ "$borrowZoneCode" == "NE" ] || [ "$borrowZoneCode" == "NF" ] || [ "$borrowZoneCode" == "NR" ] || [ "$borrowZoneCode" == "NW" ] || [ "$borrowZoneCode" == "SB" ] || [ "$borrowZoneCode" == "SC" ] || [ "$borrowZoneCode" == "SE" ] || [ "$borrowZoneCode" == "SR" ] || [ "$borrowZoneCode" == "SW" ] ;} 
        then
            echo "Invalid Zone Code"
            exit 1
        fi

        ;;
    2)
        # Transferred Stock to other Zone
        printf "\n\nValid Zone Codes are: CR, WR, WC, KR, EC, EO, ER, KR, NC, NE, NF, NR, NW, SB, SC, SE, SR, SW \n"
        read -rp "Enter the zone code to which you want to transfer stock: " transferZoneCode
        borrowZoneCode=$zoneCode
        # Check if the zone code is valid in the list
        if ! { [ "$transferZoneCode" == "CR" ] || [ "$transferZoneCode" == "WR" ] || [ "$transferZoneCode" == "WC" ] || [ "$transferZoneCode" == "KR" ] || [ "$transferZoneCode" == "EC" ] || [ "$transferZoneCode" == "EO" ] || [ "$transferZoneCode" == "ER" ] || [ "$transferZoneCode" == "KR" ] || [ "$transferZoneCode" == "NC" ] || [ "$transferZoneCode" == "NE" ] || [ "$transferZoneCode" == "NF" ] || [ "$transferZoneCode" == "NR" ] || [ "$transferZoneCode" == "NW" ] || [ "$transferZoneCode" == "SB" ] || [ "$transferZoneCode" == "SC" ] || [ "$transferZoneCode" == "SE" ] || [ "$transferZoneCode" == "SR" ] || [ "$transferZoneCode" == "SW" ] ;} 
        then
            echo "Invalid Zone Code"
            exit 1
        fi
        ;;
    *)
        echo "Invalid Choice"
        exit 1
        ;;
esac

if [ "$borrowZoneCode" == "$transferZoneCode" ]
then
    echo "Borrow Zone and Transfer Zone cannot be same"
    exit 1
fi

# Enter the stock from and to range
read -rp "Enter the Start stock range: " stockFrom
read -rp "Enter the End stock range: " stockTo

# check if stock number is valid and matches CCCNNNNNNNN
if ! [[ "$stockFrom" =~ ^[A-Z]{3}[0-9]{8}$ ]] || ! [[ "$stockTo" =~ ^[A-Z]{3}[0-9]{8}$ ]]
then
    echo "Invalid Stock Number"
    exit 1
fi

clear

echo "==============================================="
echo "Confirm the details: "
echo "Borrow Zone: $borrowZoneCode"
echo "Transfer Zone: $transferZoneCode"
echo "Stock From: $stockFrom"
echo "Stock To: $stockTo"
echo "==============================================="
read -rp "Are you sure you want to continue? (y/n): " confirm

if [ "$confirm" == "y" ] || [ "$confirm" == "Y" ]
then
    if [ "$choice" -eq 1 ]
    then
        echo "Borrowing stock from $borrowZoneCode to $transferZoneCode"
        # TODO: uncomment below Code for production
        # output=$($dbCon "exec borrowStock '$borrowZoneCode', '$stockFrom', '$stockTo'")
        # # check if the output contains "Error" or not
        # if [[ "$output" =~ "Error" ]]
        # then
        #     echo "Error while Borrowing stock"
        #     echo "$output"
        #     exit 1
        # fi
        # 
        echo "Borrowed stock from $borrowZoneCode to $transferZoneCode".
        # show warning message in yellow color
        echo -e "\033[33mWarning: Please inform $transferZoneCode Zone to update the stock in their database.\033[0m"
    else
        echo "Transferring stock from $transferZoneCode to $borrowZoneCode"
        # TODO: uncomment below Code for production
        # output=$($dbCon "exec transferStock '$transferZoneCode', '$stockFrom', '$stockTo'")
        # # check if the output contains "Error" or not
        # if [[ "$output" =~ "Error" ]]
        # then
        #     echo "Error while transferring stock"
        #     echo "$output"
        #     exit 1
        # fi
        echo "transferred stock from $transferZoneCode to $borrowZoneCode"
        # show warning message in yellow color
        echo -e "\033[33mWarning: Please inform $borrowZoneCode Zone to update the stock in their database.\033[0m"
    fi
else
    echo "Exiting the script"
    exit 1
fi