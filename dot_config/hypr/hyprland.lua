-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Load user modules from ~/.config and Omarchy defaults from $OMARCHY_PATH.
package.path = os.getenv("HOME")
    .. "/.config/?.lua;"
    .. (os.getenv("OMARCHY_PATH") or (os.getenv("HOME") .. "/.local/share/omarchy"))
    .. "/?.lua;"
    .. package.path

-- All Omarchy default setups
require("default.hypr.omarchy")

-- Change your own setup in these files and override defaults.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- float planify
o.window("io.github.alainm23.planify", { float = true })

-- default workspaces
o.window("zen", { workspace = 2 })
o.window("org.mozilla.Thunderbird", { workspace = 10 })
o.window("signal", { workspace = 11 })
o.window("chrome-web.whatsapp.com__-Default", { workspace = 11 })
o.window("Spotify", { workspace = 9 })
