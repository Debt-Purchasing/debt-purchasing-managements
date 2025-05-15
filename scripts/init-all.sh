#!/bin/bash

# Initialize git repository for root project
cd $(dirname "$0")/..
git init
git add .
git commit -m "Initial commit"

# Create directories for submodules
mkdir -p contracts backend frontend

# Run initialization scripts
chmod +x scripts/init-contracts.sh
chmod +x scripts/init-backend.sh
chmod +x scripts/init-frontend.sh

./scripts/init-contracts.sh
./scripts/init-backend.sh
./scripts/init-frontend.sh

# Add submodules to root repository
git submodule add ./contracts
git submodule add ./backend
git submodule add ./frontend

git add .
git commit -m "Add submodules"

echo "All repositories initialized successfully!" 