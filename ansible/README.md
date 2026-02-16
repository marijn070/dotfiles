# Ansible Setup for Development Environment

This Ansible playbook installs CLI tools and applications across different Linux distributions (Arch, Fedora, Debian/Ubuntu).

## Prerequisites

Install Ansible:

**Arch Linux:**
```bash
sudo pacman -S ansible
```

**Fedora:**
```bash
sudo dnf install ansible
```

**Debian/Ubuntu:**
```bash
sudo apt update
sudo apt install ansible
```

## Usage

Run the playbook from the ansible directory:

```bash
cd ~/.local/share/chezmoi/ansible
ansible-playbook -i inventory.yml playbook.yml --ask-become-pass
```

Or from anywhere:
```bash
ansible-playbook -i ~/.local/share/chezmoi/ansible/inventory.yml \
  ~/.local/share/chezmoi/ansible/playbook.yml --ask-become-pass
```

## What gets installed

### CLI Tools
- **eza** - Modern ls replacement with colors and icons
- **fish** - Friendly interactive shell
- **bat** - Cat clone with syntax highlighting
- **fzf** - Fuzzy finder for command line
- **ripgrep** - Fast grep alternative
- **fd** - Fast find alternative
- **starship** - Cross-shell prompt
- **zoxide** - Smarter cd command that learns your habits

### Applications
- **Zen Browser** - Privacy-focused Firefox-based browser
  - Installed to `/opt/zen-browser-bin`
  - Configured to work with 1Password

## Notes

- Package names are automatically adjusted for different distributions
- On Debian/Ubuntu, some tools are installed via cargo when not available in repos
- Symlinks are created for `bat` and `fd` on Debian/Ubuntu for consistency
- The playbook is idempotent - safe to run multiple times
