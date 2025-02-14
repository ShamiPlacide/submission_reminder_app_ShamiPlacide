#!/bin/bash

# Prompt for user's name
read -p "Enter your name: " userName

# Define main directory
main_dir="submission_reminder_${userName}"

# Create directory structure
mkdir -p "$main_dir/config"
mkdir -p "$main_dir/modules"
mkdir -p "$main_dir/app"
mkdir -p "$main_dir/assets"

# Create necessary files
touch "$main_dir/config/config.env"
touch "$main_dir/assets/submissions.txt"
touch "$main_dir/app/reminder.sh"
touch "$main_dir/modules/functions.sh"
touch "$main_dir/startup.sh"
touch "$main_dir/README.md"

# Populate config.env
cat << EOF > "$main_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Populate submissions.txt with sample student records
cat << EOF > "$main_dir/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Gilbert, Shell Navigation, not submitted
Innocent, Shell Navigation, not submitted
Auriane, Shell Navigation, submitted
Musiime, Shell Navigation, submitted
Mentrum, Shell Navigation, submitted
EOF

# Populate functions.sh
cat << 'EOF' > "$main_dir/modules/functions.sh"
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
EOF

# Populate reminder.sh
cat << 'EOF' > "$main_dir/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

# Populate startup.sh
cat << 'EOF' > "$main_dir/startup.sh"
#!/bin/bash

# Load environment variables and functions
source ./config/config.env
source ./modules/functions.sh

# Path to submission file
submissions_file="./assets/submissions.txt"

# Check if submissions file exists
if [ ! -f "$submissions_file" ]; then
    echo "Error: Submissions file ($submissions_file) is missing!"
    exit 1
fi

# Display assignment details from the environment variables
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"

echo "----------------------------------------------"

# Call the function to check submissions
check_submissions "$submissions_file"

# Final message
echo "Reminder application executed successfully!"
EOF

# Populate README.md
cat << EOF > "$main_dir/README.md"
# Submission Reminder App

This application helps students track and receive alerts about upcoming assignment deadlines.

## Setup Instructions:
1. Run the setup script:
   \`\`\`
   chmod +x setup_all.sh
   ./setup_all.sh
   \`\`\`
2. Navigate to the created directory and start the app:
   \`\`\`
   cd submission_reminder_${userName}/scripts
   chmod +x startup.sh
   ./startup.sh
   \`\`\`

## Project Structure:
- \`config.env\` → Stores environment variables
- \`submissions.txt\` → Contains student assignment records
- \`reminder.sh\` → Handles reminder notifications
- \`functions.sh\` → Includes helper functions
- \`startup.sh\` → Starts the application

## Author:
Created by **${userName}**
EOF

# Make scripts executable
chmod +x "$main_dir/modules/functions.sh"
chmod +x "$main_dir/startup.sh"
chmod +x "$main_dir/app/reminder.sh"

echo "Setup complete! Running the application..."
cd "$main_dir"
./startup.sh

