#!/usr/bin/env node

/**
 * Task creation script for the Debt Purchasing Platform.
 * This script creates a new markdown file for a task in the specified component directory.
 */

const fs = require('fs');
const path = require('path');
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const TASK_TYPES = ['contracts', 'backend', 'frontend', 'general'];

// Task template
const generateTaskContent = (title, description, criteria = [], dependencies = [], effort = 'TBD', status = 'Not Started', notes = []) => {
  return `# Task: ${title}

## Description
${description}

## Acceptance Criteria
${criteria.map(c => `- [ ] ${c}`).join('\n')}

## Dependencies
${dependencies.map(d => `- ${d}`).join('\n')}

## Estimated Effort
${effort}

## Status
${status}

## Notes
${notes.map(n => `- ${n}`).join('\n')}
`;
};

// Main function
async function createTask() {
  // Ask for task type
  rl.question(`Task type (${TASK_TYPES.join(', ')}): `, (taskType) => {
    if (!TASK_TYPES.includes(taskType)) {
      console.error(`Error: Invalid task type. Choose from: ${TASK_TYPES.join(', ')}`);
      rl.close();
      return;
    }

    // Ask for task filename
    rl.question('Task filename (e.g., implement_feature): ', (filename) => {
      // Validate filename
      if (!/^[a-z0-9_]+$/.test(filename)) {
        console.error('Error: Filename must contain only lowercase letters, numbers, and underscores');
        rl.close();
        return;
      }

      const filePath = path.join('tasks', taskType, `${filename}.md`);
      
      // Check if file already exists
      if (fs.existsSync(filePath)) {
        console.error(`Error: Task file already exists: ${filePath}`);
        rl.close();
        return;
      }

      // Ask for task title
      rl.question('Task title: ', (title) => {
        // Ask for task description
        rl.question('Task description: ', (description) => {
          // Ask for acceptance criteria
          rl.question('Acceptance criteria (comma-separated): ', (criteriaStr) => {
            const criteria = criteriaStr.split(',').map(c => c.trim()).filter(c => c);
            if (criteria.length === 0) criteria.push('Criteria 1');

            // Ask for dependencies
            rl.question('Dependencies (comma-separated): ', (dependenciesStr) => {
              const dependencies = dependenciesStr.split(',').map(d => d.trim()).filter(d => d);
              if (dependencies.length === 0) dependencies.push('None');

              // Ask for effort estimate
              rl.question('Estimated effort (e.g., 2 days): ', (effort) => {
                effort = effort.trim() || 'TBD';

                // Ask for notes
                rl.question('Notes (comma-separated): ', (notesStr) => {
                  const notes = notesStr.split(',').map(n => n.trim()).filter(n => n);
                  if (notes.length === 0) notes.push('Add notes here');

                  // Generate task content
                  const content = generateTaskContent(title, description, criteria, dependencies, effort, 'Not Started', notes);

                  // Create directory if it doesn't exist
                  const dir = path.dirname(filePath);
                  if (!fs.existsSync(dir)) {
                    fs.mkdirSync(dir, { recursive: true });
                  }

                  // Write task file
                  fs.writeFileSync(filePath, content);
                  console.log(`Task created: ${filePath}`);

                  // Update README.md
                  console.log('Updating tasks README.md...');
                  require('child_process').execSync('make update-readme', { stdio: 'inherit' });

                  rl.close();
                });
              });
            });
          });
        });
      });
    });
  });
}

createTask(); 