#!/bin/bash

# Create frontend repository
cd $(dirname "$0")/..
mkdir -p frontend
cp -r debt-purchasing-frontend/* frontend/

# Initialize git repository
cd frontend
git init
git add .
git commit -m "Initial commit"

echo "Frontend repository initialized!" 