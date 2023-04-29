#!/usr/bin/env bash

# show green checkmark
export greenCheck="\e[32m\xE2\x9C\x94\e[0m"
export redCross="\e[31m\xE2\x9C\x98\e[0m"

# loading animation loop spinner for 3 seconds
function loadingAnimation() {
    local -r delay='0.75'
    local spinstr='\|/-'
    local temp
    # for $1 times
    for (( i=1; i<=$1; i++ )); do
        # print the spinner
        temp="${spinstr#?}"
        printf " [%c] " "$temp"
        # move the spinner char to the start
        spinstr=$temp${spinstr%"$temp"}
        # wait for 0.75 seconds
        sleep $delay
        # print the backspace character
        printf "\b\b\b\b\b"

    done
    printf "    \b\b\b\b"
}
export -f loadingAnimation

# 1) Stop sync service
./script/stopSync.sh wr

# 2) Lock users to production DB
./script/lockUsers.sh WR

# 3) Check if mobilink farm disabled
echo -en "Mobilink farm disabled? (Yes/No) :"
read -r mobilinkFarmDisabled
echo -en "\033[1A"
echo -en "\033[2K"
if [[ "$mobilinkFarmDisabled" == "Yes" || "$mobilinkFarmDisabled" == "yes" || "$mobilinkFarmDisabled" == "y" || "$mobilinkFarmDisabled" == "Y" ]]; then
    echo -e "Mobilink farm disabled: " "$greenCheck"
else
    echo -e "Mobilink farm disabled: " "$redCross"
fi

# 4) Check if DNS farm disabled
echo -en "DNS farm disabled? (Yes/No) :"
read -r dnsFarmDisabled
echo -en "\033[1A"
echo -en "\033[2K"
if [[ "$dnsFarmDisabled" == "Yes" || "$dnsFarmDisabled" == "yes" || "$dnsFarmDisabled" == "y" || "$dnsFarmDisabled" == "Y" ]]; then
    echo -e "DNS farm disabled: " "$greenCheck"
else
    echo -e "DNS farm disabled: " "$redCross"
fi

# utsmum@10.224.68.71 Utsmum@321

# 5) Stop web services
./script/stopWebServices.sh WR

# 6) Kill users connected to production DB
./script/killUsers.sh WR

# 7) Check Sync Progress
./script/checkSyncProgress.sh WR

# 8) Insert Dummy ticket to DR DB


# 9) Check Cluster Status


# 10) Check database backup

