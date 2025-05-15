.PHONY: setup build test clean

# Default target
all: setup build test

# Setup all components
setup:
	@echo "Setting up all components..."
	cd contracts && forge install
	cd backend && npm install
	cd frontend && npm install
	@echo "Setup complete."

# Build all components
build:
	@echo "Building all components..."
	cd contracts && forge build
	cd backend && npm run build
	cd frontend && npm run build
	@echo "Build complete."

# Run tests for all components
test:
	@echo "Running tests for all components..."
	cd contracts && forge test
	cd backend && npm test
	cd frontend && npm test
	@echo "Tests complete."

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	cd contracts && forge clean
	rm -rf backend/node_modules backend/dist
	rm -rf frontend/node_modules frontend/build
	@echo "Clean complete."

# Setup only the contracts component
setup-contracts:
	@echo "Setting up contracts..."
	cd contracts && forge install
	@echo "Contracts setup complete."

# Setup only the backend component
setup-backend:
	@echo "Setting up backend..."
	cd backend && npm install
	@echo "Backend setup complete."

# Setup only the frontend component
setup-frontend:
	@echo "Setting up frontend..."
	cd frontend && npm install
	@echo "Frontend setup complete."

# Run development environment
dev:
	@echo "Starting development environment..."
	concurrently "cd backend && npm run dev" "cd frontend && npm start" 