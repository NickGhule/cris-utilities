#!/usr/bin/env bash

zoneCode="$1"
terminalCode="$2"
# get terminal ip address
terminalIP="$(grep "$terminalCode" ./resources/terminalIP_"$zoneCode" | awk '{print $3}')"
terminalType="$(grep "$terminalCode" ./resources/terminalIP_"$zoneCode" | awk '{print $6}')"

if [ -z "$terminalIP" ]
then
    echo "Invalid Terminal ID"
    exit 1
fi

if [ "$terminalType" = "DUMB" ]
then
    echo "Dumb Terminal cannot be Connected"
    exit 1
fi

# check ping status
if ping -c 1 "$terminalIP" &> /dev/null
then
    printf "\e[32m%s\e[0m\n" "$terminalCode $terminalIP Terminal Connected"
else
    printf "\e[31m%s\e[0m\n" "$terminalCode $terminalIP Terminal Not Connected"
    # check packet loss percentage
    packetLoss="$(ping -c 10 "$terminalIP" | grep "packet loss" | awk '{print $6}' | cut -d "%" -f 1)"
    if [ "$packetLoss" -gt 50 ]
    then
        printf "\e[31m%s\e[0m\n" "Packet Loss Percentage is $packetLoss"
        echo "Please check manually"
        exit 1
    else
        printf "\e[33m%s\e[0m\n" "Packet Loss Percentage is $packetLoss"
        echo "Please check manually"
        exit 1
    fi
fi

# Connect to terminal using ssh
ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=no -o LogLevel=ERROR -o BatchMode=yes -o UserKnownHostsFile=/dev/null sybuts@"$terminalIP"



















