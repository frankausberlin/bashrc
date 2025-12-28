# The Luxury Python Workflow
## 2025 💎 Edition

---

**Tooling:** `uv`, `VS Code`, `Ruff`, `Mamba`  
**Philosophy:** Speed, strictness, and automation.

---

## Table of Contents
- [Phase 0: Python System](#phase-0-python-system)
- [Phase 1: The Birth of a Project](#phase-1-the-birth-of-a-project)
- [Phase 2: VS Code Configuration](#phase-2-vs-code-luxury-configuration)
- [Phase 3: Tuning pyproject.toml](#phase-3-tuning-the-pyprojecttoml)
- [Phase 4: Pre-commit Hooks](#phase-4-pre-commit-hooks)
- [The Daily Workflow](#the-daily-workflow)
- [Troubleshooting](#troubleshooting)

---

## Phase 0: Python System

An environment based on MiniForge Mamba **(ds12, ds11)**—a well-equipped toolbox for the **data scientist**: experimental, comprehensive, playful, and integrated into a **Jupyter** environment with **CUDA**.

### Core Scripts

The **basic mechanism** relies on implementing **two rules** in `.bashrc` and using custom scripts:

| Script | Purpose |
|--------|---------|
| `act <env>` | Activate a specific environment and remember it in `.lastenv` |
| `rlb` | Reload bashrc (`source ~/.bashrc`) |
| `jl [folder]` | Start Jupyter Lab |
| `pyinit` | Create all for a new python project |

### Jupyter Lab Launcher

```bash
jl () {
    # source jl in .bash_lib
}
```

> ⚠️ **Security Note:** This configuration disables authentication (`token=''`) and XSRF protection. Use **only for local development**, never on shared or public networks.

### Bashrc Rules

1. If bash is executed within VS Code, the mamba environment is **not** activated.
2. If `rlb` is executed after a folder change and a uv environment exists (`./.venv`), that environment is activated instead of mamba.

```bash
# Insert in .bashrc
# Do not execute the conda/mamba block in vscode or if a .venv exists
if [ "$TERM_PROGRAM" != "vscode" ] && [ ! -d ./.venv ]; then
    deactivate 2>/dev/null || true  # deactivate any existing .venv environment
    
    # >>> conda initialize >>>
    #   ... (Conda/Mamba initialization block)
    # <<< conda initialize <<<
    # >>> mamba initialize >>>
    #   ...
    # <<< mamba initialize <<<

else
    # Deactivate mamba/conda env if active (twice: env -> base; base -> none)
    [[ -n "$CONDA_PREFIX" ]] && conda deactivate > /dev/null 2>&1
    [[ -n "$CONDA_PREFIX" ]] && conda deactivate > /dev/null 2>&1
    # Load custom env file if it exists
    [ -d ./.venv ] && source .venv/bin/activate
fi
```

### Data Science Environment (Python 3.12)

Current environment prescription (changes weekly 😎):

```bash
# (Re)create a data science environment with all the goodies
py=3.12 && ENV_NAME="ds${py: -2}"  # Python 3.XY --> 'dsXY'

# Clean slate
mamba deactivate
mamba remove -y -n $ENV_NAME --all 2>/dev/null

# Create base environment with core ML/DL frameworks
mamba create -y -n $ENV_NAME python=$py \
    google-colab uv pytorch torchvision torchaudio \
    tensorflow scikit-learn jax \
    -c pytorch -c conda-forge

mamba activate $ENV_NAME

# Add AI/ML tools, LLM frameworks, and development utilities
uv pip install -U \
    jupyterlab jupyter_http_over_ws jupyter-ai[all] jupyterlab-github \
    xeus-python shell-gpt llama-index langchain langchain-ollama \
    langchain-openai langchain-community transformers[torch] evaluate \
    accelerate google-genai nltk tf-keras rouge_score huggingface-hub \
    datasets unstructured[all-docs] jupytext hrid fastai opencv-python \
    soundfile nbdev vllm ollama setuptools wheel graphviz mcp PyPDF2 \
    ipywidgets click==8.1.3
    # ⚠️ Use ipywidgets==7.7.1 for Python < 3.12 (compatibility issue!)

# Enable Jupyter extensions and register kernel
jupyter labextension enable jupyter_http_over_ws
echo $ENV_NAME > ~/.startenv
python -m ipykernel install --user --name $ENV_NAME --display-name $ENV_NAME
```

Add to `.bashrc` for auto-activation:
```bash
mamba activate $(cat ~/.startenv)
act() { [ "$#" -ne 0 ] && echo $1 > ~/.startenv && mamba activate $1; }
```

---

## Phase 1: The Birth of a Project

### Quick Setup

| Step | Command | Purpose |
|------|---------|---------|
| 1 | `mkdir my_project && cd my_project` | Create project directory |
| 2 | `uv init --lib --python 3.12` | Initialize with src-layout |
| 3 | `uv add --dev ruff pytest pytest-cov` | Add dev dependencies |
| 4 | `uv sync && rlb` | Sync environment & reload bash |
| 5 | `git init` | Initialize version control |

### Detailed Steps

```bash
# 1. Initialize the Project (src-layout recommended for packages)
mkdir my_project && cd my_project
uv init --lib --python 3.12

# 2. Add Essential Development Tools
uv add --dev ruff pytest pytest-cov mypy

# 3. Finalize Environment
uv sync && rlb

# 4. Version Control Setup
git init
curl -s "https://www.toptal.com/developers/gitignore/api/python,linux,vscode" > .gitignore
```

### Resulting Project Structure

```
my_project/
├── .git/
├── .gitignore
├── .python-version
├── .venv/
│   ├── bin/
│   ├── lib/
│   └── pyvenv.cfg
├── pyproject.toml
├── README.md
├── src/
│   └── my_project/
│       └── __init__.py
├── tests/                    # Create this!
│   └── __init__.py
└── uv.lock
```

> 💡 **Why src-layout?** It prevents accidental imports from the working directory, ensures you're testing the installed package, and is the modern standard for Python packaging.

---

## Phase 2: VS Code "Luxury" Configuration

Create `.vscode/settings.json` and all needed with the script:

```bash
pyinit
```

```json
{
  "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
  "python.analysis.typeCheckingMode": "basic",
  "python.analysis.autoImportCompletions": true,
  
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "charliermarsh.ruff",
  "editor.codeActionsOnSave": {
    "source.fixAll.ruff": "always",
    "source.organizeImports.ruff": "always"
  },
  
  "python.testing.pytestEnabled": true,
  "python.testing.pytestArgs": ["tests"],
  
  "files.exclude": {
    "**/__pycache__": true,
    "**/*.pyc": true,
    ".pytest_cache": true,
    ".ruff_cache": true
  }
}
```

### Recommended VS Code Extensions

Install these for the full luxury experience:

```bash
code --install-extension ms-python.python
code --install-extension charliermarsh.ruff
code --install-extension ms-python.mypy-type-checker
code --install-extension ms-toolsai.jupyter
code --install-extension tamasfe.even-better-toml
```

### Optional: EditorConfig

Create `.editorconfig` for cross-editor consistency:

```ini
root = true

[*]
indent_style = space
indent_size = 4
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true

[*.{yml,yaml,json,toml}]
indent_size = 2

[Makefile]
indent_style = tab
```

---

## Phase 3: Tuning the pyproject.toml

Add the following to your `pyproject.toml`:

```toml
[tool.ruff]
line-length = 88
target-version = "py312"
src = ["src"]

[tool.ruff.lint]
select = [
    "E",    # pycodestyle errors
    "W",    # pycodestyle warnings
    "F",    # Pyflakes
    "I",    # isort (import sorting)
    "B",    # flake8-bugbear
    "C90",  # mccabe complexity
    "N",    # pep8-naming
    "UP",   # pyupgrade
    "ANN",  # flake8-annotations (type hints)
    "S",    # flake8-bandit (security)
    "PTH",  # flake8-use-pathlib
]
ignore = [
    "ANN101",  # Missing type annotation for self
    "ANN102",  # Missing type annotation for cls
]

[tool.ruff.lint.mccabe]
max-complexity = 10

[tool.ruff.lint.per-file-ignores]
"tests/*" = ["S101", "ANN"]  # Allow assert and skip type hints in tests

[tool.pytest.ini_options]
testpaths = ["tests"]
pythonpath = ["src"]
addopts = [
    "-v",
    "--tb=short",
    "--strict-markers",
]

[tool.mypy]
python_version = "3.12"
warn_return_any = true
warn_unused_configs = true
ignore_missing_imports = true

[tool.coverage.run]
source = ["src"]
branch = true

[tool.coverage.report]
exclude_lines = [
    "pragma: no cover",
    "if TYPE_CHECKING:",
    "raise NotImplementedError",
]
```

### Ruff Rules Explained

| Rule Set | Description |
|----------|-------------|
| `E`, `W` | PEP 8 style (errors & warnings) |
| `F` | Logical errors (undefined names, unused imports) |
| `I` | Import sorting (replaces isort) |
| `B` | Common bugs and design problems |
| `C90` | Cyclomatic complexity checks |
| `N` | PEP 8 naming conventions |
| `UP` | Upgrade syntax to latest Python |
| `ANN` | Type annotation enforcement |
| `S` | Security issue detection |
| `PTH` | Prefer pathlib over os.path |

---

## Phase 4: Pre-commit Hooks

### Setup

```bash
uv add --dev pre-commit
uv run pre-commit install
```

Create `.pre-commit-config.yaml`:

```yaml
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.8.4
    hooks:
      - id: ruff
        args: [--fix]
      - id: ruff-format

  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v5.0.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
      - id: check-merge-conflict

  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.14.1
    hooks:
      - id: mypy
        additional_dependencies: []
```

---

## The Daily Workflow

### Essential Commands

| Task | Command |
|------|---------|
| Add a package | `uv add <package>` |
| Add dev dependency | `uv add --dev <package>` |
| Remove a package | `uv remove <package>` |
| Sync environment | `uv sync` |
| Run script | `uv run python src/my_project/main.py` |
| Run tests | `uv run pytest` |
| Run with coverage | `uv run pytest --cov` |
| Lint check | `uv run ruff check .` |
| Auto-fix lint | `uv run ruff check . --fix` |
| Format code | `uv run ruff format .` |
| Type check | `uv run mypy src/` |
| Build package | `uv build` |

### Workflow Aliases (add to `.bashrc`)

```bash
alias uvr='uv run'
alias uvt='uv run pytest'
alias uvl='uv run ruff check .'
alias uvf='uv run ruff check . --fix && uv run ruff format .'
```

---

## Troubleshooting

### Common Issues

**Problem:** VS Code not detecting the virtual environment
```bash
# Solution: Reload window or explicitly set the interpreter
# Press Ctrl+Shift+P → "Python: Select Interpreter" → Choose .venv
```

**Problem:** `uv sync` fails with resolver errors
```bash
# Solution: Clear the cache and retry
uv cache clean
uv sync --refresh
```

**Problem:** Mamba environment still activates in VS Code
```bash
# Solution: Ensure .bashrc rules are correctly placed
# Check that TERM_PROGRAM is set: echo $TERM_PROGRAM
```

**Problem:** Import errors in tests
```bash
# Solution: Ensure src is in pythonpath (pyproject.toml) and run:
uv pip install -e .
```

---

## Quick Reference Card

```bash
# New project setup (copy-paste ready)
PROJECT_NAME="my_project"
mkdir $PROJECT_NAME && cd $PROJECT_NAME
uv init --lib --python 3.12
uv add --dev ruff pytest pytest-cov mypy pre-commit
mkdir -p tests && touch tests/__init__.py
git init
curl -s "https://www.toptal.com/developers/gitignore/api/python,linux,vscode" > .gitignore
uv run pre-commit install
uv sync && rlb
code .
```

---

*Happy coding! 🐍✨*
