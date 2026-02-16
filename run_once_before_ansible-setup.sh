#!/bin/sh

# Check if ansible is installed
if ! command -v ansible-playbook >/dev/null 2>&1; then
    echo "Ansible is not installed. Installing..."

    # Detect distro and install ansible
    if command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --noconfirm ansible
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y ansible
    elif command -v apt >/dev/null 2>&1; then
        sudo apt update
        sudo apt install -y ansible
    else
        echo "Unable to detect package manager. Please install Ansible manually."
        exit 1
    fi
fi

# Run the ansible playbook
echo "Running Ansible playbook to setup development environment..."
cd "${HOME}/.local/share/chezmoi/ansible" || exit 1

# Run playbook (will prompt for sudo password)
ansible-playbook -i inventory.yml playbook.yml --ask-become-pass

echo "Ansible setup complete!"
