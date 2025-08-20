#!/bin/bash

source /boot/config/plugins/lsi-mon/lsi-mon.cfg

STORCLI=$STORCLIVER
controllers=$($STORCLI show nolog | grep -i "Number of Controllers" | head -n1 | awk -F"=" '{split($2,a," "); print a[1]}')

for (( c=0; c<$controllers; c++ )); do
    INFO="$($STORCLI /c$c show all nolog)"

    MODEL=$(echo "$INFO" | grep -i "Model" | head -n1 | awk -F"=" '{split($2,a," "); print a[1]}' | xargs)
    CONTROLLER=$(echo "$INFO" | grep -i "Adapter Type" | head -n1 | awk -F"=" '{split($2,a," "); print a[1]}' | xargs)
    SERIAL=$(echo "$INFO" | grep -i "Serial Number" | head -n1 | awk -F"=" '{split($2,a," "); print a[1]}' | xargs)
    FW_VER=$(echo "$INFO" | grep -i "Firmware Version" | head -n1 | awk -F"=" '{split($2,a," "); print a[1]}' | xargs)
    TEMP=$(echo "$INFO" | grep -i "ROC temperature" | head -n1 | awk -F"=" '{split($2,a," "); print a[1]}' | xargs)

    # Output one line per controller, tab-separated
    echo "$c	$MODEL	$CONTROLLER	$SERIAL	$FW_VER	$TEMP"
done
