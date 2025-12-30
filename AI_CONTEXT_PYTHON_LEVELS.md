# AI Context: Python Environment Architecture (Level 0-3)

## 🎯 Purpose of this document
This document serves as a master instruction for working in this repository. Every code change, every new script and every environment manipulation must respect the following 4-tier architecture.

---

## 🏗 The 4 Levels

### Level 0: OS Foundation / Build Primitives
- **Responsibility:** System packages, compilers, basic tools.
- **Tools:** `apt`, `build-essential`, `git`, `docker`, `openjdk`.
- **Rule:** No Python code is executed here. Here only the prerequisites for the tools are created.

### Level 1: User-Space Orchestrators (The Tools)
- **Responsibility:** Management tools that create or control environments.
- **Core tools:** - `uv` (Global Standard for Python Management)
  - `micromamba` (only the binary, for heavy runtimes)
  - `bashrc` / `.bash_lib` (The logic center)
- **Rule:** Tools live in the PATH, but never within an enabled environment. They are “stateless”.

### Level 2: Heavy / Shared Runtimes (Data Science Stack)
- **Responsibilities:** Large, long-lived environments with complex dependencies (CUDA, PyTorch).
- **Management:** Via `micromamba`.
- **Rule:** Are registered globally (e.g. as Jupyter Kernel) to be used from Level 3.

### Level 3: Project environments (workspaces)
- **Responsibilities:** Project specific, isolated environments.
- **Management:** Via `uv` (`.venv`, `pyproject.toml`).
- **Rule:** Disposable, reproducible, repo-local.

---

## 🛠 Specific work instructions for AI (Kilocode/MCP)

1. **Bash logic (`.bash_lib` & `.bashrc`):**
   - Functions must be “level-aware”.
   - Use the existing `exportadd` logic for path manipulations.
   - Prioritize activation: Level 3 (`.venv`) > Level 2 (`~/.startenv`).

2. **Python Workflows:**
   - Never install libraries globally.
   - Use `uv tool install` for CLI apps (Level 1).
   - Use `uv add` for project dependencies (level 3).

3. **Integration & Aliases:**
   - New aliases belong in `.bash_aliases`.
   - Complex logic belongs in `.bash_lib`.
   - The prompt (PS1) must reflect the status of the levels (colors!).

---

## 🚩 Current work order for the session
1. **Status Quo:** Analysis of the existing `.bash_lib` in the repo.
2. **Goal:** Optimize the `pyinit` function and Jupyter kernel integration according to level separation.
3. **Task:** Create robust bootstrap logic for the `devenv` notebook (L0/L1) and the `pythoncoding` notebook (L2/L3).

---
**Note to AI:** Work conservatively. Don't change paths without checking the effects on the other levels. Use existing variables from `.bash_lib`.