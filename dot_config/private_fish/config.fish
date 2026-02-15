if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

set -g fish_key_bindings fish_vi_key_bindings

fish_add_path -p ~/.local/bin
fish_add_path -p ~/bin

# rustup shell setup
fish_add_path -p $HOME/.cargo/bin

# use zoxide
zoxide init fish | source

# Starship
function starship_transient_prompt_func
    starship module character
end

function starship_transient_rprompt_func
    starship module time
end

starship init fish | source
enable_transience

# Source helper functions (inspired by omarchy)
source $__fish_config_dir/helpers.fish

# use the 1password plugin
if test -e ~/.config/op/plugins.sh
    source ~/.config/op/plugins.sh
end

# get venv to work
set -gx WORKON_HOME $HOME/.virtualenvs
set -gx VIRTUALENVWRAPPER_PYTHON /usr/bin/python3

# set 1password as the ssh key agent
if not set -q SSH_AUTH_SOCK
    set SSH_AUTH_SOCK $HOME/.1password/agent.sock
end

# set zed as editor
set -gx EDITOR zed

# aliases
alias cat='bat'
alias la='ls -a'
alias cd='z'
alias ls='eza --icons'
alias lg='lazygit'
