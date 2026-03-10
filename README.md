# Setup on a new machine

1. install chezmoi
2. `chezmoi init marijn070`

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
