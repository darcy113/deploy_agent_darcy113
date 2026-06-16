#!/bin/bash

PROJECT_NAME=""

cleanup() {

    echo "Interrupt detected"

    if [ -n "$PROJECT_NAME" ] && [ -d "$PROJECT_NAME" ]; then

        tar -czf "${PROJECT_NAME}_archive.tar.gz" "$PROJECT_NAME"

        rm -rf "$PROJECT_NAME"

        echo "Archive created"

    fi

    exit 1
}

trap cleanup SIGINT

read -p "Enter project name: " NAME

PROJECT_NAME="attendance_tracker_${NAME}"

mkdir -p "$PROJECT_NAME/Helpers"
mkdir -p "$PROJECT_NAME/reports"

cp attendance_checker.py "$PROJECT_NAME/"
cp assets.csv "$PROJECT_NAME/Helpers/"
cp config.json "$PROJECT_NAME/Helpers/"
cp reports.log "$PROJECT_NAME/reports/"

read -p "Update thresholds? (y/n): " ANSWER

if [ "$ANSWER" = "y" ]; then

    read -p "Warning threshold: " WARNING
    read -p "Failure threshold: " FAILURE

    WARNING=${WARNING:-75}
    FAILURE=${FAILURE:-50}

    sed -i "s/75/$WARNING/g" "$PROJECT_NAME/Helpers/config.json"
    sed -i "s/50/$FAILURE/g" "$PROJECT_NAME/Helpers/config.json"

fi

echo "Checking Python..."

if python3 --version >/dev/null 2>&1; then
    echo "Python installed"
else
    echo "Python missing"
fi

if [ -f "$PROJECT_NAME/attendance_checker.py" ] &&
   [ -f "$PROJECT_NAME/Helpers/assets.csv" ] &&
   [ -f "$PROJECT_NAME/Helpers/config.json" ] &&
   [ -f "$PROJECT_NAME/reports/reports.log" ]; then

    echo "Directory structure valid"

else

    echo "Directory structure invalid"

fi