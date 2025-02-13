#!/bin/bash

# Prompt for user's name
read -p "Enter your name: " userName

# Define the main directory name
main_dir="submission_reminder_${userName}"

# Create main directory
mkdir -p "$main_dir"

# Create subdirectories
mkdir -p "$main_dir/app"
mkdir -p "$main_dir/config"
mkdir -p "$main_dir/modules"
mkdir -p "$main_dir/assets"

# Create necessary files
touch "$main_dir/config/config.env"
touch "$main_dir/app/reminder.sh"
touch "$main_dir/modules/functions.sh"
touch "$main_dir/assets/submission.txt"
touch "$main_dir/README.md"

# Populate README.md with basic instructions
cat << EOF > "$main_dir/README.md"
# Submission Reminder App

This application helps students track and receive alerts about upcoming assignment deadlines.

## Setup Instructions:
1. Run the setup script:
   \`\`\`
   chmod +x create_environment.sh
   ./create_environment.sh
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

echo "Project structure for $main_dir has been created successfully!"

