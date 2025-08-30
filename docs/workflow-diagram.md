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

