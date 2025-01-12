#!/bin/bash

# Directorul de lucru
WORK_DIR="/var/lib/packagemonitor"

# Verifica daca directorul există
if [ ! -d "$WORK_DIR" ]; then
    echo "Directorul de lucru nu există: $WORK_DIR"
    exit 1
fi

# Parseaza logul dpkg
LOG_FILE="/var/log/dpkg.log"
if [ ! -f "$LOG_FILE" ]; then
    echo "Fisierul log nu exista: $LOG_FILE"
    exit 1
fi

# Procesare fisier log
grep -E " install | remove " "$LOG_FILE" | while read -r line; do
    # Extrage informatii: data, actiune, pachet
    DATE=$(echo "$line" | awk '{print $1, $2}')
    ACTION=$(echo "$line" | awk '{print $3}')
    PACKAGE=$(echo "$line" | awk '{print $4}')

    # Creeaza directorul pentru pachet
    PACKAGE_DIR="$WORK_DIR/$PACKAGE"
    mkdir -p "$PACKAGE_DIR"

    # Salveaza istoria operatiilor
    echo "$DATE $ACTION" >> "$PACKAGE_DIR/history.log"
done
