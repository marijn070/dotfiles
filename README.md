# Dotfiles

This is a collection of my dotfiles. I use [GNU Stow](https://www.gnu.org/software/stow/) to manage them.
In order to use them, you must have git and stow installed.

SSH Keys are stored by the 1Password CLI. Make sure this is installed.
Once that is done, copy the .ssh folder to your home directory

Now, to clone the repository and install the dotfiles, run the following commands:

```bash
git clone personalgit:marijn070/dotfiles.git ~/dotfiles
```

Notice how we use `personalgit` instead of `github` in the URL.
This is because I use a custom SSH configuration to use different SSH keys for different hosts.

Finally, to symlink the dotfiles to your home directory, run the following commands:

```bash
cd ~/dotfiles
stow --adopt *
```

This will symlink all the dotfiles to your home directory.

## Gnucash

When installing gnucash as a Flatpak, I use flatpak override commands to set environment variables. Firstly, to set the language of gnucash to dutch, we run

```bash
sudo flatpak override --env=LANG="nl_NL" --env=LANGUAGE="nl_NL" org.gnucash.GnuCash
```

Then, to correctly set the user data and user config directories, run

```bash
sudo flatpak override --env=GNC_CONFIG_HOME="$HOME/.config/gnucash/config/" org.gnucash.GnuCash
sudo flatpak override --env=GNC_DATA_HOME="$HOME/.config/gnucash/data/" org.gnucash.GnuCash
```
