#!/bin/bash
# Description: This script is used to enable/disable terminal and update IP/MAC address

# define variables
dbCon="path to database connection file"

echo "Welcome to Terminal Management System"
echo "  1. Enable Terminal"
echo "  2. Disable Dumb Terminal"
echo "  3. Update IP Address"
echo "  4. Update MAC Address"
echo "  5. Modify Terminal Parameters"
echo "  6. Exit"

read -p "Enter your choice: " choice

case $choice in
1)
    echo "Enter Terminal Code"
    read -n 6 terminal_code
    echo "Enabling Terminal"
    $dbCon "exec uts_update_terminal_value '$terminal_code', 'E'"
    echo "Terminal Code: $terminal_code"
    ;;
2)
    echo "Enter Terminal Code"
    read -n 6 terminal_code
    echo "Disabling Terminal"
    $dbCon "exec uts_update_terminal_value '$terminal_code', 'D'"
    echo "Terminal Code: $terminal_code"
    ;;
3)
    echo "Enter Terminal Code"
    read -n 6 terminal_code
    echo "Enter IP Address"
    read ip_address
    echo "Updating IP Address"
    $dbCon "exec uts_update_terminal_value '$terminal_code', 'I', '$ip_address'"
    echo "Terminal Code: $terminal_code"
    echo "IP Address: $ip_address"
    ;;
4)
    echo "Enter Terminal Code"
    read -n 6 terminal_code
    echo "Enter MAC Address"
    read mac_address
    echo "Updating MAC Address"
    $dbCon "exec uts_update_terminal_value '$terminal_code', 'M', '$mac_address'"
    echo "Terminal Code: $terminal_code"
    echo "MAC Address: $mac_address"
    ;;
5)
    echo "Enter Terminal Code"
    read -n 6 terminal_code
    clear
    echo "Select the parameters to update"
    echo "  1. Update Payment Modes"
    echo "  2. Update Missing Parameters"
    echo "  3. Exit"

    read -p "Enter your choice: " parameterChoice

    case $parameterChoice in
    1)
        echo "Enter Payment Modes C- cash, B- Bank, U- UPI"
        echo "ex. For cash and bank enter CB"
        echo "ex. For cash, bank and UPI enter CBU"
        read -p "Enter Modes: " payment_modes
        echo "Updating Payment Modes"
        $dbCon "exec uts_modify_terminal_parameters_tc '$terminal_code', 'ALLOW_PAY_MODE', '$payment_modes'"
        echo "Terminal Code: $terminal_code"
        echo "Payment Modes: $payment_modes"
        ;;
    2)
        echo "Enter Terminal Code"
        read -n 6 terminal_code
        echo "updating missing parameters"
        $dbCon "exec uts_modify_terminal_parameters_tc '$terminal_code', 'MISSING_PARAMS', 'Y'"
        echo "Terminal Code: $terminal_code"
        ;;
    3)
        echo "Exiting"
        ;;
    *)
        echo "Invalid Choice"
        ;;
    esac
    ;;
6)
    echo "Exiting"
    ;;
*)
    echo "Invalid Choice"
    ;;
esac

