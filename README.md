# dotfiles

The chezmoi source directory for my machines.

## Layout

- `dot_config/`, `dot_local/`, `dot_bashrc`, `dot_gitconfig.tmpl` - the managed
  `$HOME` tree, in chezmoi source naming.
- `zed/settings.json` and `joplin/` - files that live in the repository itself;
  chezmoi links to them from `$HOME` (see the `symlink_*.tmpl` files) so the
  application writes straight into the repo. They are listed in
  `.chezmoiignore` so chezmoi does not also create them under `$HOME`.
- `ansible/` - provisioning (packages, keyd, 1Password, rust, zen-browser),
  run once by `run_once_before_ansible-setup.sh` and on change by
  `run_onchange_ansible-playbook.sh.tmpl`.
- `.chezmoiexternal.toml` - Omarchy plugin repositories, cloned by chezmoi.

## Omarchy-specific content

`.config/omarchy`, `.config/hypr`, `.config/hyprmoncfg`, `.config/waybar`,
`.config/walker` and `.config/swayosd`, and the plugin repositories in
`.chezmoiexternal.toml`, are applied only on Omarchy. Detection is automatic:
`.chezmoiignore` and `.chezmoiexternal.toml` test `.chezmoi.osRelease.id`
against `omarchy`, so a non-Omarchy machine skips all of it with no setup step.

## Not tracked

Runtime state is deliberately out of the repository: log files, Herdr session
and release-notes state, nested `.git` directories, and plugin payloads that
Herdr installs itself under `.config/herdr/plugins/github/`.

# Setup on a new machine

1. install chezmoi
2. `chezmoi init --apply marijn070`

That is all - the Omarchy gating and the ansible provisioning run themselves.

## Omarchy Fingerprint setup

On omarchy i setup the fingerprint to be disabled when the lid was closed.

### 1. create lid check script

create the script `/usr/local/bin/pam-lid-check`

```bash
#!/usr/bin/env bash

# detect lid state
LID_STATE=$(cat /proc/acpi/button/lid/*/state 2>/dev/null | awk '{print $2}')

# if closed → fail → skip fingerprint
if [ "$LID_STATE" = "closed" ]; then
    exit 0
fi

# lid open → allow fingerprint
exit 1
```

### 2. create a pam unit enabling fprintd only when the lid is open

In the `/etc/pam.d/` folder, create a file named `fprint-conditional` with the following content:

```
auth [success=1 default=ignore] pam_exec.so quiet /usr/local/bin/pam-lid-check
auth sufficient pam_fprintd.so
```

### 3. set the corresponding lines in the pam config to this script

wherever the fprint is referenced in the pam folder (`rg fprint /etc/pam.d`), replace the line

```
auth sufficient pam_fprintd.so
```

with

```
auth include fprint-conditional
```
