#!/bin/bash

# Prompt the user for their name (we'll hardcode it for Yohan as per your request)
echo "Please enter your name:"
read yourName

# Output the assignment details
echo "Assignment: Shell Navigation"
echo "Days remaining to submit: 2 days"

# Create the main directory with the user's name (hardcoded for Yohan)
main_dir="submission_reminder_Yohan"
mkdir -p "$main_dir"

# Create subdirectories
mkdir -p "$main_dir/config"
mkdir -p "$main_dir/scripts"
mkdir -p "$main_dir/data"

# Create files in their respective directories
touch "$main_dir/config/config.env"
touch "$main_dir/scripts/reminder.sh"
touch "$main_dir/scripts/functions.sh"
touch "$main_dir/scripts/startup.sh"
touch "$main_dir/data/submissions.txt"

# Populate config.env with actual content
cat <<EOL > "$main_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL

# Populate reminder.sh with actual content
cat <<EOL > "$main_dir/scripts/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ../config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOL

# Populate functions.sh with actual content
cat <<EOL > "$main_dir/scripts/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOL

# Populate submissions.txt with at least 5 additional student records
cat <<EOL > "$main_dir/data/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
EOL

# Create the startup.sh script
cat <<EOL > "$main_dir/scripts/startup.sh"
#!/bin/bash

# Source the configuration and function files
source "$main_dir/config/config.env"
source "$main_dir/scripts/functions.sh"

# Start the reminder app
echo "Starting the Submission Reminder App..."
while true; do
    check_reminders
    sleep $REMINDER_INTERVAL
done
EOL

# Make all scripts executable
chmod +x "$main_dir/scripts/reminder.sh"
chmod +x "$main_dir/scripts/functions.sh"
chmod +x "$main_dir/scripts/startup.sh"

echo "Environment setup completed for $main_dir!"
