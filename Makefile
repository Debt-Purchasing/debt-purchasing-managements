.PHONY: help list-tasks new-task count-tasks update-readme stats

# Default target
help:
	@echo "Available commands:"
	@echo "  make list-tasks            - List all tasks"
	@echo "  make count-tasks           - Count tasks by status"
	@echo "  make update-readme         - Update tasks README with current stats"
	@echo "  make new-task TYPE=<type>  - Create new task template (type: contracts, backend, frontend, general)"
	@echo "  make stats                 - Generate task statistics"

# List all tasks
list-tasks:
	@echo "Listing all tasks:"
	@find tasks -type f -name "*.md" ! -name "README.md" | sort

# Count tasks by status
count-tasks:
	@echo "Tasks by status:"
	@echo "  In Progress: $$(grep -r "## Status" tasks --include="*.md" | grep -c "In Progress")"
	@echo "  Not Started: $$(grep -r "## Status" tasks --include="*.md" | grep -c "Not Started")"
	@echo "  Completed:   $$(grep -r "## Status" tasks --include="*.md" | grep -c "Completed")"
	@echo "  Total:       $$(find tasks -type f -name "*.md" ! -name "README.md" | wc -l)"

# Create a new task from template
new-task:
	@if [ -z "$(TYPE)" ]; then \
		echo "Error: TYPE parameter is required"; \
		echo "Usage: make new-task TYPE=<type> [where type is contracts, backend, frontend, or general]"; \
		exit 1; \
	fi
	@if [ ! -d "tasks/$(TYPE)" ]; then \
		echo "Error: Invalid type. Choose from: contracts, backend, frontend, general"; \
		exit 1; \
	fi
	@read -p "Enter task name (e.g., implement_feature): " name; \
	read -p "Enter task title: " title; \
	read -p "Enter task description: " description; \
	echo "# Task: $$title\n\n## Description\n$$description\n\n## Acceptance Criteria\n- [ ] Criteria 1\n- [ ] Criteria 2\n- [ ] Criteria 3\n\n## Dependencies\n- None\n\n## Estimated Effort\nTBD\n\n## Status\nNot Started\n\n## Notes\n- Add notes here" > "tasks/$(TYPE)/$$name.md"; \
	echo "Created new task: tasks/$(TYPE)/$$name.md"

# Update README.md with current stats
update-readme:
	@CONTRACTS_TOTAL=$$(find tasks/contracts -type f -name "*.md" | wc -l); \
	BACKEND_TOTAL=$$(find tasks/backend -type f -name "*.md" | wc -l); \
	FRONTEND_TOTAL=$$(find tasks/frontend -type f -name "*.md" | wc -l); \
	GENERAL_TOTAL=$$(find tasks/general -type f -name "*.md" | wc -l); \
	CONTRACTS_COMPLETED=$$(grep -r "## Status" tasks/contracts --include="*.md" | grep -c "Completed"); \
	BACKEND_COMPLETED=$$(grep -r "## Status" tasks/backend --include="*.md" | grep -c "Completed"); \
	FRONTEND_COMPLETED=$$(grep -r "## Status" tasks/frontend --include="*.md" | grep -c "Completed"); \
	GENERAL_COMPLETED=$$(grep -r "## Status" tasks/general --include="*.md" | grep -c "Completed"); \
	CONTRACTS_PROGRESS=$$(grep -r "## Status" tasks/contracts --include="*.md" | grep -c "In Progress"); \
	BACKEND_PROGRESS=$$(grep -r "## Status" tasks/backend --include="*.md" | grep -c "In Progress"); \
	FRONTEND_PROGRESS=$$(grep -r "## Status" tasks/frontend --include="*.md" | grep -c "In Progress"); \
	GENERAL_PROGRESS=$$(grep -r "## Status" tasks/general --include="*.md" | grep -c "In Progress"); \
	CONTRACTS_NOTSTARTED=$$((CONTRACTS_TOTAL - CONTRACTS_COMPLETED - CONTRACTS_PROGRESS)); \
	BACKEND_NOTSTARTED=$$((BACKEND_TOTAL - BACKEND_COMPLETED - BACKEND_PROGRESS)); \
	FRONTEND_NOTSTARTED=$$((FRONTEND_TOTAL - FRONTEND_COMPLETED - FRONTEND_PROGRESS)); \
	GENERAL_NOTSTARTED=$$((GENERAL_TOTAL - GENERAL_COMPLETED - GENERAL_PROGRESS)); \
	TOTAL=$$((CONTRACTS_TOTAL + BACKEND_TOTAL + FRONTEND_TOTAL + GENERAL_TOTAL)); \
	COMPLETED=$$((CONTRACTS_COMPLETED + BACKEND_COMPLETED + FRONTEND_COMPLETED + GENERAL_COMPLETED)); \
	PROGRESS=$$((CONTRACTS_PROGRESS + BACKEND_PROGRESS + FRONTEND_PROGRESS + GENERAL_PROGRESS)); \
	NOTSTARTED=$$((CONTRACTS_NOTSTARTED + BACKEND_NOTSTARTED + FRONTEND_NOTSTARTED + GENERAL_NOTSTARTED)); \
	sed -i "s/| Contracts | [0-9]* | [0-9]* | [0-9]* | [0-9]* |/| Contracts | $$CONTRACTS_TOTAL | $$CONTRACTS_COMPLETED | $$CONTRACTS_PROGRESS | $$CONTRACTS_NOTSTARTED |/g" tasks/README.md; \
	sed -i "s/| Backend | [0-9]* | [0-9]* | [0-9]* | [0-9]* |/| Backend | $$BACKEND_TOTAL | $$BACKEND_COMPLETED | $$BACKEND_PROGRESS | $$BACKEND_NOTSTARTED |/g" tasks/README.md; \
	sed -i "s/| Frontend | [0-9]* | [0-9]* | [0-9]* | [0-9]* |/| Frontend | $$FRONTEND_TOTAL | $$FRONTEND_COMPLETED | $$FRONTEND_PROGRESS | $$FRONTEND_NOTSTARTED |/g" tasks/README.md; \
	sed -i "s/| General | [0-9]* | [0-9]* | [0-9]* | [0-9]* |/| General | $$GENERAL_TOTAL | $$GENERAL_COMPLETED | $$GENERAL_PROGRESS | $$GENERAL_NOTSTARTED |/g" tasks/README.md; \
	sed -i "s/| \*\*Total\*\* | \*\*[0-9]*\*\* | \*\*[0-9]*\*\* | \*\*[0-9]*\*\* | \*\*[0-9]*\*\* |/| **Total** | **$$TOTAL** | **$$COMPLETED** | **$$PROGRESS** | **$$NOTSTARTED** |/g" tasks/README.md; \
	echo "Updated tasks/README.md with current statistics."

# Generate statistics
stats: count-tasks
	@echo ""
	@echo "Completion percentage: $$(echo "scale=2; 100 * $$(grep -r "## Status" tasks --include="*.md" | grep -c "Completed") / $$(find tasks -type f -name "*.md" ! -name "README.md" | wc -l)" | bc)%" 