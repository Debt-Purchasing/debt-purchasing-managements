#!/bin/bash

# Create backend repository
cd $(dirname "$0")/..
mkdir -p backend
cp -r debt-purchasing-backend/* backend/

# Initialize git repository
cd backend
git init
git add .
git commit -m "Initial commit"

echo "Backend repository initialized!" 