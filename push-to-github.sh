#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Management repository URL
repo_url="git@github.com:Debt-Purchasing/debt-purchasing-managements.git"

echo "Setting up debt-purchasing-managements repository..."

# Add all task management files
git add .gitignore package.json SETUP.md README.md Makefile scripts/ push-to-github.sh tasks/

# Commit if there are changes
if git diff-index --quiet HEAD 2>/dev/null; then
    echo "No changes to commit in repository"
else
    git commit -m "Task management repository setup"
fi

# Add remote if it doesn't exist
if ! git remote | grep -q "^origin$"; then
    git remote add origin $repo_url
fi

# Push repository
echo "Pushing to GitHub..."
git push -u origin main || git push -u origin master

echo "------------------------------------"
echo "Repository pushed successfully!"
echo ""
echo "Next steps:"
echo "1. Clone the repository to start managing tasks: git clone $repo_url"
echo "2. Create a new task: npm run new-task"
echo "3. List all tasks: npm run list-tasks"
echo "4. Get task statistics: npm run stats" 