# SKILES 🚀

> **One-Command Favorite AI Skills Manager & Automated Installer**

Maintain your favorite AI agent skills in one central GitHub repository and install only the specific skills you need into any project with a single command.

---

## ⚡ Quick 1-Command Shortcuts

You can run these commands from **any terminal or directory**:

| Command | What It Does |
|---|---|
| `my-skills` | Installs all your favorite skills into the current project |
| `add-skill <repo> [skill]` | Adds a new skill to your list, pushes to GitHub & installs it instantly! |
| `my-skills list` | Shows your current favorite skills list in terminal |
| `my-skills edit` | Opens `skills.txt` in Notepad and auto-syncs to GitHub when closed |

---

## ➕ Super-Easy: How to Add Skills in the Future

No manual file opening, no git commands needed! Just type:

```cmd
add-skill <repo-url> [skill-name]
```

### Examples:

1. **Add a specific skill**:
   ```cmd
   add-skill https://github.com/anthropics/skills webapp-testing
   ```
2. **Add all skills from a repository**:
   ```cmd
   add-skill vercel-labs/agent-skills
   ```
3. **Interactive mode (asks you what to add)**:
   ```cmd
   add-skill
   ```

**What happens automatically:**
1. It adds the line to `skills.txt`.
2. It automatically commits and pushes to GitHub.
3. It immediately installs the new skill into your current project!

---

## 📦 Current Favorite Skills

Configured in [`skills.txt`](./skills.txt):

1. **`ui-ux-pro-max`** — UI/UX design intelligence (from [`nextlevelbuilder/ui-ux-pro-max-skill`](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill)).
2. **`frontend-design`** — Frontend design system (from [`anthropics/skills`](https://github.com/anthropics/skills)).

Installed into:
- **`.agents/skills/`** (Universal folder for Antigravity, Cursor, and supported agents).

---

## 💻 Everyday Usage

Navigate into any project directory and run:

```cmd
my-skills
```

### Install for Claude Code specifically (`.claude/skills/`):
```cmd
my-skills --agent claude-code
```

### Install Globally:
```cmd
my-skills -g
```