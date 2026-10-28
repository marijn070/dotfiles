-- Keep only your personal keybinding overrides here. Add new bindings or
-- use o.rebind to replace defaults.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

o.rebind("SUPER + T", "Terminal", { omarchy = "terminal" })

o.rebind("SUPER + CTRL + D", "hyprmoncfg" ,"omarchy-shell shell toggle crmne.hyprmoncfg")

-- Keep one dedicated Herdr session in its own scratchpad.
o.window({ initial_title = "^herdr$" }, { workspace = "special:herdr" })
o.rebind("SUPER + A", "Herdr scratchpad", os.getenv("HOME") .. "/.local/bin/herdr-scratchpad")

o.rebind("SUPER + F", "Yazi", { tui = "yazi" })

-- Calendar overlay. SUPER + SHIFT + C was previously bound to Config.
o.rebind("SUPER + SHIFT + C", "Calendar", os.getenv("HOME") .. "/.local/bin/rencal-toggle")
o.bind("SUPER + SHIFT + ALT + C", "Config", { launch = "edit-configs" })

-- Maximize, Close
hl.bind("SUPER + M", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Toggle the Zotero search panel. This replaces the default zoom-in shortcut.
o.rebind("SUPER + CTRL + Z", "Zotero search", "omarchy-shell shell toggle marijn.zotero")

-- Toggle Omamail
o.rebind("SUPER + SHIFT + M", "Omamail", "omarchy shell shell toggle omamail '{}'")

-- Open Signal
o.rebind("SUPER + SHIFT + S", "Signal", { omarchy = "signal" })


-- Provide a dedicated key for the Keybindings overview without overwriting SUPER+K
o.bind("SUPER + ALT + K", "Keybindings", "omarchy-menu-keybindings")

require("bindings.navigation")
require("bindings.planify")
