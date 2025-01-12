#!/bin/bash

WORK_DIR="/var/lib/packagemonitor"

# Verifica daca directorul de lucru exista
if [ ! -d "$WORK_DIR" ]; then
    echo "Directorul de lucru nu există: $WORK_DIR"
    exit 1
fi

# Meniu principal
echo "1. Lista pachetelor instalate curent"
echo "2. Lista pachetelor șterse"
echo "3. Istoricul unui pachet"
echo "4. Operații dintr-un interval de timp"
echo -n "Alege opțiunea: "
read OPTION

case $OPTION in
    1)
        echo "Pachete instalate curent:"
        for PACKAGE in "$WORK_DIR"/*; do
            if grep -q "install" "$PACKAGE/history.log" && ! grep -q "remove" "$PACKAGE/history.log"; then
                LAST_INSTALL=$(grep "install" "$PACKAGE/history.log" | tail -1 | awk '{print $1, $2}')
                echo "$(basename "$PACKAGE"): $LAST_INSTALL"
            fi
        done
        ;;
    2)
        echo "Pachete sterse:"
        for PACKAGE in "$WORK_DIR"/*; do
            if grep -q "remove" "$PACKAGE/history.log"; then
                LAST_REMOVE=$(grep "remove" "$PACKAGE/history.log" | tail -1 | awk '{print $1, $2}')
                echo "$(basename "$PACKAGE"): $LAST_REMOVE"
            fi
        done
        ;;
    3)
        echo -n "Introdu numele pachetului: "
        read PACKAGE
        HISTORY_FILE="$WORK_DIR/$PACKAGE/history.log"
        if [ -f "$HISTORY_FILE" ]; then
            cat "$HISTORY_FILE"
        else
            echo "Pachetul nu exista in istoricul monitorului."
        fi
        ;;
    4)
        echo -n "Introdu intervalul: "
        read START_DATE END_DATE
        for PACKAGE in "$WORK_DIR"/*; do
            echo "Operatii pentru $(basename "$PACKAGE"):"
            awk -v start="$START_DATE" -v end="$END_DATE" \
                '$1 " " $2 >= start && $1 " " $2 <= end' "$PACKAGE/history.log"
        done
        ;;
    *)
        echo "Optiune invalida."
        ;;
esac
