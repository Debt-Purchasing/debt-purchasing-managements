# Setting Up the Debt Purchasing Platform

This document provides detailed instructions on how to set up the Debt Purchasing Platform.

## Prerequisites

- Git
- Node.js (v16+)
- Foundry (for contracts)
- MongoDB (for backend)

## Option 1: Clone With Existing Submodules

If all repositories are already set up in GitHub:

```bash
# Clone the repository with all submodules
git clone --recurse-submodules https://github.com/yourusername/debt-purchasing.git
cd debt-purchasing

# Install dependencies and build all components
make setup
```

## Option 2: Initialize From Scratch

If you're setting up the repositories for the first time:

```bash
# 1. Clone this repository
git clone https://github.com/yourusername/debt-purchasing.git
cd debt-purchasing

# 2. Make sure scripts are executable
chmod +x scripts/*.sh

# 3. Run the initialization script
./scripts/init-all.sh

# 4. Install dependencies and build all components
make setup
```

## Manually Setting Up Each Repository

If you prefer to set up each repository individually:

### Contracts

```bash
# From the root directory
./scripts/init-contracts.sh
cd contracts
forge install
forge build
```

### Backend

```bash
# From the root directory
./scripts/init-backend.sh
cd backend
npm install
```

### Frontend

```bash
# From the root directory
./scripts/init-frontend.sh
cd frontend
npm install
```

## Development Workflow

After setting up the repositories, you can start the development environment:

```bash
# Start backend and frontend development servers
make dev

# Or using npm
npm run dev
```

## Additional Commands

```bash
# Clean all build artifacts
make clean

# Run all tests
make test

# Build all components for production
make build
```
