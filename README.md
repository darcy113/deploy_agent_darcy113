# Student Attendance Tracker Deployment Agent

## Run

chmod +x setup_project.sh
./setup_project.sh

## Features

- Creates project directory structure
- Copies required files
- Updates attendance thresholds using sed
- Verifies Python installation
- Validates project structure
- Handles Ctrl+C interruption

## Archive Feature

While the script is running, press:

Ctrl + C

The script will:

1. Create attendance_tracker_<name>_archive.tar.gz
2. Remove the incomplete project directory
3. Exit safely