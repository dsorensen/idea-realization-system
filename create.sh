#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Helper Functions ---
# Prints a formatted step message.
step() {
  echo "➡️  $1"
}

# Prints a success message.
success() {
  echo "✅ $1"
}

# Prints an error message and exits.
error() {
  echo "❌ Error: $1" >&2
  exit 1
}

# --- Dependency Check ---
step "Checking for dependencies..."
command -v git >/dev/null 2>&1 || error "git is required but it's not installed. Please install it to continue."
command -v gh >/dev/null 2>&1 || error "GitHub CLI (gh) is required but it's not installed. Please install it and authenticate with 'gh auth login'."
success "Dependencies found."

# --- Project Setup ---
REPO_NAME="idea-realization-system"

step "Creating project directory: $REPO_NAME"
mkdir -p "$REPO_NAME"
cd "$REPO_NAME"

step "Creating docs directory..."
mkdir -p docs

step "Creating documentation files..."

cat <<'EOF' > docs/project-brief.md
# Project Brief: Idea Realization System

## Executive Summary
This project, named the "Idea Realization System," aims to create a streamlined, low-friction workflow for taking a raw idea from a Notion database to a tangible, prototyped, and version-controlled project. The solution leverages BMad AI agents for planning, a Gemini-generated script for automated GitHub repository setup, integration with an AI prototyping tool for instant baseline creation, and an AI-assisted iteration loop within an IDE for rapid development. The core value is to dramatically increase the velocity of validated learning, allowing ideas to be tested and realized faster than ever before.

## Problem Statement
The journey from a raw, fleeting idea to a structured, tangible project is fraught with friction. The core problems are the high activation energy of project setup, the manual burden of synchronizing artifacts, slow development iteration cycles, and a lack of traceability. Solving this is critical to increasing the velocity of innovation and preventing valuable concepts from being abandoned.

## Proposed Solution
The solution is a defined workflow that uses BMad AI agents as expert partners. 
1. **Planning & Validation:** A user collaborates with planning agents in Gemini to produce project documents.
2. **Setup & Centralization:** A Gemini-generated script automates the creation of a GitHub repository for all documents, with links centralized in Notion.
3. **Rapid Prototyping:** A UI prompt is used with an AI tool to create an instant, interactive baseline.
4. **AI-Assisted Iteration:** In an IDE, execution agents build upon the baseline with a rapid-deployment feedback loop.

## MVP Scope
The MVP is a defined workflow where the primary deliverable is an agent-generated setup script that the user executes manually. It includes the planning phase, script generation/execution, and manual prototyping and code commit. It excludes any custom software that automates the triggers between tools.

## Post-MVP Vision
Future development will focus on automating the remaining manual steps, including a Notion-to-Gemini trigger and API-based integration with prototyping tools, eventually leading to a more autonomous build agent.
EOF

cat <<'EOF' > docs/workflow-diagram.md
# Project Workflow Diagram

```mermaid
graph TD
    subgraph "Phase 1: Planning (Any Device)"
        A[💡 Notion Idea] --> B[💬 Plan with BMad Agents in Gemini];
        B --> C{Final Outputs};
        C --> C1[Planning Docs];
        C --> C2[UI Prompt];
        C --> C3[Setup Script];
    end

    subgraph "Phase 2: Project Setup & Prototyping"
        C1 & C2 & C3 --> D{Are you on your laptop?};
        
        D -- "Yes --> Laptop Workflow" --> E["💻 Run Setup Script"];
        E --> F[(📂 GitHub Repo is Created)];
        F -- "Docs are committed" --> F;
        C2 --> G[🤖 Submit Prompt to AI Prototyper];
        G --> H[Prototype Code is Generated];
        F & H --> I[Commit Prototype Code to Repo];

        D -- "No --> Mobile Workflow" --> J["📱 Submit Prompt to AI Prototyper"];
        J --> K[View Live Prototype];
        K --> L["(Later) Run Setup Script on Laptop"];
        L --> M[(📂 GitHub Repo is Created)];
        M -- "Docs are committed" --> M;
        K & M --> N[Download & Commit Prototype Code];
    end

    subgraph "Phase 3: AI-Assisted Iteration (Laptop)"
        I --> O{BMAD-Powered IDE};
        N --> O;
        subgraph O
            direction LR
            O_User[👤 User]
            O_BMAD[🎭 Dev & QA Agents]
        end
        O -- "Iterate on code" --> O;
        O --> P[Commit changes to GitHub];
    end

    subgraph "Phase 4: Instant Review"
        P -- "`git push` triggers deploy" --> Q["🚀 Rapid Deploy Service (e.g., Vercel)"];
        Q --> R["🌍 Live Preview URL"];
        R -- "Feedback" --> O;
    end
```

EOF

success "Documentation files created."

# --- Git & GitHub ---

step "Initializing git repository..."
git init -b main
git add .
git commit -m "Initial commit: Add project brief and workflow diagram"
success "Local repository initialized and initial commit created."

step "Creating GitHub repository and pushing..."

# This command creates the repo on GitHub and pushes the current branch.
gh repo create "$REPO_NAME" --public --source=. --push
success "GitHub repository created and initial commit pushed."

# --- Finalization ---

echo ""
success "All done! Your new project is ready."
echo "✅ GitHub URL: $(gh repo view --json url -q .url)"
echo "✅ You can now 'cd $REPO_NAME' to enter your new project directory."
