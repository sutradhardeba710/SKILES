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

## 📦 Configured Skills

Currently included in [`skills.txt`](./skills.txt):

1. **`ui-ux-pro-max`** — UI/UX design intelligence for web, mobile, and desktop (from [`nextlevelbuilder/ui-ux-pro-max-skill`](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill)).
2. **`frontend-design`** — Comprehensive frontend design skill (from [`anthropics/skills`](https://github.com/anthropics/skills)).

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

### Windows CMD
```cmd
my-skills
```

### Windows PowerShell
```powershell
my-skills
# or
my-skills.ps1
```

### Target Specific Agents or Global Scope
You can pass any regular `skills` CLI flags directly through:

```bash
# Install only for Claude Code
my-skills --agent claude-code

# Install only for Antigravity / Cursor
my-skills --agent antigravity

# Install globally to user profile instead of project-level
my-skills -g
```

---

## ➕ Adding More Skills

To add more skills, simply open [`skills.txt`](./skills.txt) and add the repository URL or shorthand:

```text
# Example whole repository
vercel-labs/agent-skills

# Example specific skill from a repository
https://github.com/anthropics/skills --skill frontend-design
```

Save the file and push to GitHub:
```bash
git add skills.txt
git commit -m "add new favorite skill"
git push
```

Every project you run `my-skills` in will now automatically receive the new skills!
