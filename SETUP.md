# Development Environment Setup

This repository uses **chezmoi** for dotfile management and **Ansible** for system-level package installation.

## Quick Start on a New Machine

1. **Install chezmoi** (if not already installed):

   ```bash
   # Arch Linux
   sudo pacman -S chezmoi

   # Fedora
   sudo dnf install chezmoi

   # Debian/Ubuntu
   sudo apt install chezmoi
   ```

2. **Clone dotfiles via HTTPS** (no SSH keys needed yet):

   ```bash
   chezmoi init https://github.com/yourusername/dotfiles.git
   ```

3. **Apply dotfiles and run setup**:

   ```bash
   chezmoi apply
   ```

   This will:
   - Install Ansible (if not already installed)
   - Install 1Password and 1Password CLI
   - Install Rust toolchain and CLI tools
   - Install Zen Browser
   - Switch git remote from HTTPS to SSH (after 1Password is set up)
   - Copy your dotfiles to the correct locations

4. **Configure 1Password SSH agent**:
   - Open 1Password application
   - Go to Settings → Developer
   - Enable SSH agent
   - Your SSH keys from 1Password are now available

5. **Verify SSH setup**:

   ```bash
   ssh -T git@github.com
   # Should authenticate using 1Password
   ```

## What Gets Installed

### 1Password (installed first)

- **1Password** - Password manager with SSH agent support
- **1Password CLI** - Command-line interface for 1Password

### Rust CLI Tools (via Ansible)

- **Rust toolchain** - Installed to `~/.cargo`
- **eza** - Modern ls replacement
- **fish** - Friendly interactive shell (set as default shell)
- **bat** - Cat with syntax highlighting
- **fzf** - Fuzzy finder
- **ripgrep** - Fast grep
- **fd** - Fast find
- **starship** - Cross-shell prompt
- **zoxide** - Smart cd command

### Applications (via Ansible)

- **Zen Browser** - Privacy-focused browser with 1Password integration

### Dotfiles (via chezmoi)

- Bash configuration
- Git configuration
- Zen browser desktop files and wrapper scripts
- Local scripts and utilities
