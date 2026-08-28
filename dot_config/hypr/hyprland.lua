-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile("/usr/share/omarchy/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- default workspaces
o.window("zen", { workspace = 2 })
o.window("org.mozilla.Thunderbird", { workspace = 10 })
o.window("signal", { workspace = 11 })
o.window("chrome-web.whatsapp.com__-Default", { workspace = 11 })
o.window("Spotify", { workspace = 9 })

-- float ZenNotes quick capture
hl.window_rule({ match = { title = "ZenNotes Quick Capture" }, float = true })

-- Herdr always gapless
hl.window_rule({ match = { title = "Herdr" }, fullscreen_state =  3 })

-- Added by hyprmoncfg: its generated monitor rules load last, so nothing before this can override the applied layout.
dofile(os.getenv("HOME") .. "/.config/hypr/hyprmoncfg-monitors.lua")
