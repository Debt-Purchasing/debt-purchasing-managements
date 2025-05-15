# Debt Purchasing Platform

A decentralized platform for buying and selling debt positions on Aave V3, enabling efficient debt trading and management.

## Project Structure

This repository is structured to separate concerns into three main components:

1. **debt-purchasing-contracts**: Smart contracts for managing debt positions
2. **debt-purchasing-backend**: API server and automation bot
3. **debt-purchasing-frontend**: User interface for interacting with the platform

After initialization, these components will be available as Git submodules in:

- `contracts/`
- `backend/`
- `frontend/`

## Getting Started

For detailed setup instructions, please see the `SETUP.md` file.

### Quick Start

```bash
# Initialize the project structure
./scripts/init-all.sh

# Build and set up each component
make setup

# Start the development environment
make dev
```

## Architecture Overview

The platform enables users to sell their debt positions under specific conditions, allowing buyers to acquire these positions profitably.

- **Contracts**: Integrate with Aave V3 to manage debt positions, sales, and ownership
- **Backend**: Indexes on-chain events, serves data to the frontend, and automates debt sales
- **Frontend**: Provides interfaces for borrowers and buyers to interact with the platform

## License

This project is licensed under the MIT License.
