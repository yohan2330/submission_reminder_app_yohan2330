#!/bin/bash

# Source the configuration and function files
source "submission_reminder_Yohan/config/config.env"
source "submission_reminder_Yohan/scripts/functions.sh"

# Start the reminder app
echo "Starting the Submission Reminder App..."
while true; do
    check_reminders
    sleep 
done
