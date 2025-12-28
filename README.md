# .bashrc Configuration

A comprehensive and luxurious Bash configuration tailored for Python development, AI/ML workflows, and modern tooling. This setup integrates seamlessly with Conda/Mamba environments, supports uv-based project management, and includes a rich collection of aliases and functions for productivity.

## 🚀 Key Features

### Environment Management
- **Smart Environment Activation**: Automatically activates the last used Conda/Mamba environment on shell startup
- **VS Code Integration**: Prevents environment conflicts by not activating Conda in VS Code terminals
- **uv Support**: Detects and activates local `.venv` environments created by uv in project directories
- **Environment Switching**: Use `act <env>` to switch environments and remember your choice
- **Force Mode**: Use `rlb m` to force conda activation (red prompt indicators) even when uv environments exist
- **Smart Terminal Prompt**: Enhanced PS1 showing random emojis, user/host info, current directory, and Python environment status with color-coded environment indicators (green=conda, cyan=uv, red=force mode)

### Development Tools
- **Jupyter Lab Launcher** (`jl`): Start Jupyter Lab with optimized settings for local development
- **File Manager** (`nxx`): Enhanced nnn file manager with cd-on-quit functionality
- **Android Development** (`adx`): ADB utilities for managing Android devices and packages
- **Path Management**: `exportadd` for safely adding paths to environment variables
- **Custom Exports**: `exportfolder` loads environment variables from `~/.config/_exports`
- **Luxury Project Initializer** (`pyinit`): Automated Python project setup with uv, VS Code configuration, and best practices

### Productivity Aliases
- **Navigation**: Quick aliases like `l` (~/labor), `g` (~/labor/gits), `d` (~/Downloads)
- **Development**: Launch PyCharm (`pc`), Cursor (`cursor`), KiloCode (`kc`)
- **AI/ML Tools**: One-command launches for ComfyUI, Stable Diffusion WebUI, Dify, Flowise, LibreChat, PySpur, Deer Flow, Magnetic UI, AnythingLLM, LM Studio, Pinokio, N8N, Redis, Gemini, Open WebUI
- **System Management**: System updates (`suu`), Docker container management (`stop`)
- **Git Automation**: AI-powered Git commit (`gico`) - automatically generates commit messages using AI based on git diff
- **Shell Management**: `rlb` reloads bashrc, `rlb m` forces conda mode (red prompt)
- **Error Handling**: Automatic error logging and `wtf` alias for AI-powered error explanations

### Modern Tooling Integration
- **Package Managers**: Homebrew, Bun, NVM, Cargo
- **Search & Completion**: FZF keybindings and fuzzy completion
- **Remote Connections**: SSH aliases for Android devices
- **Cloud Services**: Google Drive mounting, ngrok tunnels for N8N

### Automation Scripts
- **Auto Sync and Commit** (`auto.sh`): Automatically syncs configuration files from home directory and performs AI-powered Git commits with generated messages

## 🐍 Python Ecosystem Support

This configuration is designed around a sophisticated Python development workflow featuring:

### Core Components
- **Mamba/Conda**: Global environments for data science and AI (e.g., `ds12` with PyTorch, TensorFlow, JAX)
- **uv**: Modern Python package manager for project-local virtual environments
- **Jupyter Lab**: Enhanced launcher with Colab compatibility and security settings for local use

### AI/ML Stack
- **LLM Frameworks**: LangChain, LlamaIndex, Transformers, vLLM, Ollama
- **AI Tools**: ShellGPT for command-line AI assistance, Jupyter AI extensions
- **ML Workspaces**: Docker-based ML environments with GPU support
- **Specialized Apps**: ComfyUI, Stable Diffusion, Dify, Flowise, LibreChat, Open WebUI, PySpur, Deer Flow, Magnetic UI, AnythingLLM, LM Studio, Pinokio
- **AI Platforms**: N8N workflow automation, Redis stack, Gemini CLI, Open WebUI

### Development Workflow
For the complete luxury Python development experience, see [`pydev_lux.md`](pydev_lux.md) - a comprehensive guide covering:
- Environment setup with MiniForge Mamba
- Project initialization with uv
- VS Code configuration with Ruff linting
- Pre-commit hooks and testing
- Daily development commands

## 📦 Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/bashrc.git
   cd bashrc
   ```

2. Copy the configuration files to your home directory:
   ```bash
   cp .bashrc ~/.bashrc
   cp .bash_lib ~/.bash_lib
   cp .bash_aliases ~/.bash_aliases
   ```

3. Reload your shell:
   ```bash
   source ~/.bashrc
   ```

## ⚙️ Configuration

- **Environment Files**: Place custom environment variables in `~/.config/_exports/` (one file per variable)
- **Default Environment**: Set your preferred Conda environment in `~/.startenv`
- **Current Working Directory**: Use `cw` to save/restore your working folder

## 🔧 Requirements

- Bash shell
- Conda/Mamba (MiniForge recommended)
- uv (for modern Python project management)
- Various tools as needed (nnn, adb, docker, etc.)

## 🤝 Contributing

Feel free to submit issues, feature requests, or pull requests to enhance this configuration.

## 📄 License

This project is open source. Please check individual tool licenses for any restrictions.

---

*Crafted for the modern developer who values speed, automation, and a touch of luxury in their workflow.* ✨
