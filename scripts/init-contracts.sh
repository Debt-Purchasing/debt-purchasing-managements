#!/bin/bash

# Create contracts repository
cd $(dirname "$0")/..
mkdir -p contracts
cp -r debt-purchasing-contracts/* contracts/

# Initialize git repository
cd contracts
git init
git add .
git commit -m "Initial commit"

echo "Contracts repository initialized!" 