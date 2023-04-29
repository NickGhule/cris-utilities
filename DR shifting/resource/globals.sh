#!/usr/bin/env bash

# Path: DR shifting/resource/globals.sh

# parameters
greenCheck="\e[32m\xE2\x9C\x94\e[0m"
redCross="\e[31m\xE2\x9C\x98\e[0m"

# functions
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