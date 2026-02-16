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

### Essential Tools (installed first)

- **1Password** - Password manager with SSH agent integration
- **1Password CLI** - Command-line interface for 1Password

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

### Post-Installation

- **Chezmoi Git Remote** - Automatically switches from HTTPS to SSH if applicable
  - Enables push access using 1Password SSH agent

## Workflow for New Systems

1. **Clone dotfiles via HTTPS** (no authentication needed):

   ```bash
   chezmoi init https://github.com/yourusername/dotfiles.git
   ```

2. **Run the playbook** (installs 1Password, CLI tools, etc.):

   ```bash
   chezmoi apply
   # or manually:
   cd ~/.local/share/chezmoi/ansible
   ansible-playbook -i inventory.yml playbook.yml --ask-become-pass
   ```

3. **Configure 1Password SSH agent**:
   - Open 1Password
   - Enable SSH agent in settings
   - Add your SSH keys to 1Password

4. **Remote automatically switches to SSH**:
   - The playbook will detect HTTPS remote and switch to SSH
   - Future `chezmoi update` and git operations will use SSH

## Notes

- Package names are automatically adjusted for different distributions
- On Debian/Ubuntu, some tools are installed via cargo when not available in repos
- Symlinks are created for `bat` and `fd` on Debian/Ubuntu for consistency
- The playbook is idempotent - safe to run multiple times
- 1Password is installed first so SSH keys are available for the git remote switch
- Rust toolchain is installed to user's home directory (`~/.cargo`), not system-wide
