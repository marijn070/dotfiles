$env.config.show_banner = false
$env.config.buffer_editor = 'helix'

$env.config.completions.algorithm = "fuzzy"

# carapace
source omarchy-carapace.nu
source $"($nu.cache-dir)/carapace.nu"

$env.config.edit_mode = 'helix'
$env.config.cursor_shape.helix_insert = "blink_line"
$env.config.cursor_shape.helix_normal = "blink_block"

$env.config.keybindings ++= [({
    name: complete_history_hint
    modifier: control
    keycode: Char_l
    mode: helix_normal
    event: { edit: Clear }
})]

$env.PROMPT_INDICATOR_VI_NORMAL = "❮ "
$env.PROMPT_INDICATOR_VI_INSERT = "❯ "
$env.STARSHIP_CONFIG = $env.XDG_CONFIG_HOME | path join "starship-nu.toml"

$env.GNC_FILE = "/home/marijn/Documents/3_Marijns_Klusjes/Boekhouding/marijns_klusjes.gnucash"

# zoxide
source ~/.zoxide.nu


# aliases
alias cd = z
alias hx = helix
alias cat = bat
alias chezmio = chezmoi
alias lg = lazygit

# functions
def invoice [] {

    cd ~/Projects/gnucash_invoice/
    just latest
    cd out
    let invoice_pdf = ls | sort-by modified | last | get name | path expand
    thunderbird -compose $"from=marijn@marijnsklusjes.nl,attachment=($invoice_pdf)"
    let answer = (input -d "Y" -n 1 "save PDF to paperless? [Y/n]")
    if ($answer | str capitalize) == "Y" {
        print "Saving PDF"
        cp $invoice_pdf ~/Paperless
    }
    
}

def fonts [] {
    fc-list
    | lines
    | parse "{path}: {name}:style={styles}"
    | update name {split row "," | first | str trim}
    | update styles {split row "," | each {str trim} }
    | update path {path basename}
    | group-by name
    | items {|name, rows| {name: $name, styles: ($rows.styles
        | flatten
        | uniq
        | sort
        | str join ", ")}
    }
    | sort-by name
}

use ~/Projects/gnucash_invoice/nucash/

