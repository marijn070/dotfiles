-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

hl.unbind("SUPER + T")
o.bind("SUPER + T", "Terminal", { omarchy = "terminal" })

-- Keep one dedicated Herdr session in its own scratchpad.
o.window({ initial_title = "^herdr$" }, { workspace = "special:herdr" })
hl.unbind("SUPER + A")
o.bind("SUPER + A", "Herdr scratchpad", os.getenv("HOME") .. "/.local/bin/herdr-scratchpad")

hl.unbind("SUPER + F")
o.bind("SUPER + F", "Yazi", { tui = "yazi" })

-- Configure
hl.unbind("SUPER + SHIFT + C")
o.bind("SUPER + SHIFT + C", "Config", { launch = "edit-configs" })

-- Maximize, Close
hl.unbind("SUPER + Q")
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + M", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

hl.unbind("SUPER + code:61")

-- Toggle the Zotero search panel. This replaces the default zoom-in shortcut.
hl.unbind("SUPER + CTRL + Z")
o.bind("SUPER + CTRL + Z", "Zotero search", "omarchy-shell shell toggle marijn.zotero")

-- Toggle Omamail
hl.unbind("SUPER + SHIFT + M")
o.bind("SUPER + SHIFT + M", "Omamail", "omarchy shell shell toggle omamail '{}'")

-- Open Signal
hl.unbind("SUPER + SHIFT + S")
o.bind("SUPER + SHIFT + S", "Signal", { omarchy = "signal" })


-- Provide a dedicated key for the Keybindings overview without overwriting SUPER+K
o.bind("SUPER + ALT + K", "Keybindings", "omarchy-menu-keybindings")

require("bindings.navigation")
require("bindings.planify")
