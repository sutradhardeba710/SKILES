# SKILES 🚀

> **One-Word Command AI Skills Manager & Automated Installer**

Type just **`skills`** in any project folder to install your favorite skills automatically.

---

## ⚡ Instant Commands (Run from ANY folder)

| Command | What It Does |
|---|---|
| **`skills`** | **Installs all your favorite skills into the current project** |
| `add-skill <repo> [skill]` | Adds a new skill to your list, pushes to GitHub & installs it instantly |
| `skills list` | Shows your current favorite skills list in terminal |
| `skills edit` | Opens `skills.txt` in Notepad and auto-syncs to GitHub when closed |

*(Note: `my-skills` also continues to work as an alias).*

---

## 💻 How to Use It in Any New Project

1. Open CMD or PowerShell:
   ```cmd
   cd D:\Projects\MyNewProject
   ```
2. Run:
   ```cmd
   skills
   ```
3. Done! Both `ui-ux-pro-max` and `frontend-design` are physically copied into `.agents/skills/`.

---

## 📦 Current Favorite Skills

Configured in [`skills.txt`](./skills.txt):

1. **`ui-ux-pro-max`** — UI/UX design intelligence (from [`nextlevelbuilder/ui-ux-pro-max-skill`](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill)).
2. **`frontend-design`** — Frontend design system (from [`anthropics/skills`](https://github.com/anthropics/skills)).

Installed into:
- **`.agents/skills/`** (Universal folder for Antigravity, Cursor, and supported agents).

---

## ➕ How to Add Skills in the Future

```cmd
add-skill <repo-url> [skill-name]
```

Example:
```cmd
add-skill https://github.com/anthropics/skills webapp-testing
```
This automatically:
1. Adds it to `skills.txt`
2. Syncs and pushes to GitHub
3. Installs it into your current project!