# SKILES 🚀

> **One-Command Favorite AI Skills Manager & Automated Installer**

Maintain your favorite AI agent skills in one central GitHub repository and install only the specific skills you need into any project with a single command.

---

## 🎯 How It Works

Instead of manually installing skills one-by-one whenever you start a new project:

```bash
New Project ➔ Open Terminal ➔ my-skills ➔ Specific Skills Installed! ✅
```

---

## 📦 Specific Skills Configured

Configured in [`skills.txt`](./skills.txt):

1. **`ui-ux-pro-max`** — UI/UX design intelligence (from [`nextlevelbuilder/ui-ux-pro-max-skill`](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill)).
2. **`frontend-design`** — Frontend design guidance (from [`anthropics/skills`](https://github.com/anthropics/skills)).

Installed into:
- **`.agents/skills/`** (Universal folder for Antigravity, Cursor, and supported agents).

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
4. Click **New** and paste the path to this folder (`C:\Users\<user>\.gemini\antigravity\scratch\SKILES`).
5. Click **OK** on all windows, then close and reopen your terminal.

---

## 💻 Usage

Navigate into any project directory and run:

### Universal Install (Installs only specific skills to `.agents/skills/`)
```cmd
my-skills
```

### Install Specifically for Another Agent (e.g. Claude Code `.claude/skills/`)
```cmd
my-skills --agent claude-code
```

### Install Globally to User Profile
```cmd
my-skills -g
```

---

## 🔧 Features Included

- **Specific Skills Only**: Installs only the exact skills specified (`ui-ux-pro-max` and `frontend-design`), skipping any extra unneeded skills from the repositories.
- **Specific Folder Target**: Defaults cleanly to `.agents/skills/` without creating clutter across dozens of unused agent directories.
- **Full Physical Copy (`--copy`)**: Copies all original files (Python tools, CSV databases, templates, and `SKILL.md`) physically into your project.
- **BOM-Safe**: Clean UTF-8 encoding with native comment handling.

---

## ➕ Adding More Skills

To add more skills, edit [`skills.txt`](./skills.txt):

```text
# Specific skill from a repository
https://github.com/anthropics/skills --skill frontend-design
```

Then commit and push:
```bash
git add .
git commit -m "update skills"
git push
```