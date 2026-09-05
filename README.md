# SKILES 🚀

> **One-Command Favorite AI Skills Manager & Automated Installer**

Maintain your favorite AI agent skills in one central GitHub repository and install all of them into any project with a single command.

---

## 🎯 How It Works

Instead of manually installing skills one-by-one whenever you start a new project:

```bash
New Project ➔ Open Terminal ➔ my-skills ➔ All Favorite Skills Installed! ✅
```

---

## 📦 Pre-configured Favorite Skills

Configured in [`skills.txt`](./skills.txt):

1. **`ui-ux-pro-max` (Full Suite - 7 Skills)**:
   - `ui-ux-pro-max` — UI/UX design intelligence (searchable styles, product palettes, font pairings, 119 UX guidelines)
   - `ui-styling` — Radix UI, Tailwind CSS, shadcn/ui styling
   - `design` — Brand identity, tokens, logo generation, CIP mockups
   - `design-system` — Token architecture, component specs
   - `slides` — HTML presentations with Chart.js
   - `brand` — Brand voice, visual identity & guidelines
   - `banner-design` — Multi-platform banner & ad design
2. **`frontend-design`** — Anthropic frontend design system for intentional, polished visual UI.

---

## ⚡ Quick Setup

### 1. Add to Windows PATH (One-time)

To run `my-skills` from any directory or terminal, add this folder to your PATH.

**Automatic:**
Run this command in PowerShell from this directory:
```powershell
.\add-to-path.ps1
```

**Manual:**
1. Press `Win + S` and search for **Environment Variables**.
2. Select **Edit the system environment variables** > click **Environment Variables**.
3. Under **User variables**, select `Path` and click **Edit**.
4. Click **New** and paste the path to this folder (e.g., `C:\Users\<user>\.gemini\antigravity\scratch\SKILES`).
5. Click **OK** on all windows, then close and reopen your terminal.

---

## 💻 Usage

Navigate into any project directory and run:

### Universal Install (Copies to Detected Agents & `.agents/skills`)
```cmd
my-skills
```

### Install Specifically for Claude Code (`.claude/skills`)
```cmd
my-skills --agent claude-code
```

### Install for Multiple Agents (e.g. Claude Code & Cursor)
```cmd
my-skills --agent claude-code cursor
```

### Install Globally to User Profile
```cmd
my-skills -g
```

---

## 🔧 Key Features & Fixes Included

- **Full Physical Copy (`--copy`)**: Automatically enabled by default. Copies the actual, full original files (scripts, python tools, design databases, CSVs) directly into your project's agent directories instead of failing symlinks on Windows.
- **BOM-Safe Parsing**: Robust against UTF-8 Byte Order Marks and ignores comment lines starting with `#`.
- **Argument Passthrough**: Accepts any CLI flags (`--agent`, `-g`, etc.) and forwards them directly to the `skills` CLI.

---

## ➕ Adding More Skills

To add more skills, simply edit [`skills.txt`](./skills.txt):

```text
# Install all skills from a repository
https://github.com/nextlevelbuilder/ui-ux-pro-max-skill --skill *

# Install one specific skill from a repository
https://github.com/anthropics/skills --skill frontend-design
```

Then commit and push:
```bash
git add .
git commit -m "update skills"
git push
```