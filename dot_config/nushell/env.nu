$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

$env.NUPM_HOME = ($env.XDG_DATA_HOME | path join "nupm")
$env.NU_LIB_DIRS = $env.NU_LIB_DIRS | append ($env.NUPM_HOME | path join "modules")

