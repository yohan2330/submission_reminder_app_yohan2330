#!/bin/bash

# Display startup message
echo "Starting the Submission Reminder App..."

# Assignment details (you can modify these)
assignment="Shell Navigation"
days_remaining=2

# Function to display the reminder
show_reminder() {
    echo "Assignment: $assignment"
    echo "Days remaining to submit: $days_remaining days"
}

# Show the reminder once at startup
show_reminder

# Optional: Simulate the app running with a few reminders (remove or adjust as needed)
for ((i=1; i<=2; i++)); do
    sleep 5  # Wait 5 seconds between reminders
    echo "Reminder #$i:"
    show_reminder
done

# Exit message
echo "Submission Reminder App is running. Check back later or stop with Ctrl+C if needed."
