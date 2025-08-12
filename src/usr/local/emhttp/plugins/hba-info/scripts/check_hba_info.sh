#!/bin/bash

STORCLI="/usr/local/bin/storcli64"

# Find all controller IDs (e.g., 0, 1, 2, ...)
controllers=$($STORCLI show | awk '/Controller =/ {print $3}')

for controller in $controllers; do
    CONTROLLER="/c$controller"
    INFO="$($STORCLI $CONTROLLER show all)"

    ADAPTER_TYPE=$(echo "$INFO" | grep -i "Product Name" | head -n1 | awk -F':' '{print $2}' | xargs)
    MODEL=$(echo "$INFO" | grep -i "Model Number" | head -n1 | awk -F':' '{print $2}' | xargs)
    SERIAL=$(echo "$INFO" | grep -i "Serial Number" | head -n1 | awk -F':' '{print $2}' | xargs)
    FW_VER=$(echo "$INFO" | grep -i "FW Version" | head -n1 | awk -F':' '{print $2}' | xargs)
    TEMP=$(echo "$INFO" | grep -i "Temperature" | head -n1 | awk -F':' '{print $2}' | xargs)

    # Output one line per controller, tab-separated
    echo "$controller	$ADAPTER_TYPE	$MODEL	$SERIAL	$FW_VER	$TEMP"
done
