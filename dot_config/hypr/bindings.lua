-- Application bindings.
hl.unbind("SUPER + T")
o.bind("SUPER + T", "Terminal", { omarchy = "terminal" })
hl.unbind("SUPER + F")
o.bind("SUPER + F", "Yazi", { tui = "yazi" })
o.bind("SUPER + ALT + RETURN", "Tmux", { omarchy = "terminal-tmux" })
o.bind("SUPER + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + SHIFT + F", "File manager", { omarchy = "nautilus" })
o.bind("SUPER + ALT + SHIFT + F", "File manager (cwd)", { omarchy = "nautilus-cwd" })
o.bind("SUPER + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + SHIFT + ALT + B", "Browser (private)", { omarchy = "browser --private" })
o.bind("SUPER + SHIFT + M", "Music", { omarchy = "or-focus spotify-launcher" })
o.bind("SUPER + SHIFT + ALT + M", "Music TUI", { tui = "cliamp", focus = true })
o.bind("SUPER + SHIFT + N", "Editor", { omarchy = "editor" })
o.bind("SUPER + SHIFT + D", "Docker", { tui = "lazydocker" })
o.bind("SUPER + SHIFT + G", "Signal", { launch = "signal-desktop", focus = "^signal$" })
o.bind("SUPER + SHIFT + O", "Obsidian", { launch = "obsidian", focus = "^obsidian$" })
o.bind("SUPER + SHIFT + SLASH", "Passwords", { launch = "1password" })
o.bind("SUPER + SHIFT + E", "Email", { launch = "thunderbird" })

-- Web app bindings.
o.bind("SUPER + SHIFT + A", "ChatGPT", { webapp = "https://chatgpt.com" })
o.bind("SUPER + SHIFT + ALT + A", "Grok", { webapp = "https://grok.com" })
o.bind("SUPER + SHIFT + Y", "YouTube", { webapp = "https://youtube.com/" })
o.bind("SUPER + SHIFT + W", "WhatsApp", { webapp = "https://web.whatsapp.com/", focus = true })
o.bind("SUPER + SHIFT + I", "Immich", { webapp = "https://photos.marijnderijk.com/", focus = true })

o.bind("SUPER + SHIFT + S", "Google Maps", { webapp = "https://maps.google.com/", focus = true })

-- Configure
o.bind("SUPER + SHIFT + C", "Config", { launch = "edit-configs" })

-- Maximize, Close
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + M", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

hl.unbind("SUPER + code:61")

-- Planify Tasks
hl.unbind("SUPER + P")
hl.unbind("SUPER + SHIFT + P")
o.bind("SUPER + P", "Add Task", { launch = "planify.quick-add" })
o.bind("SUPER + SHIFT + P", "Planify", { launch = "planify" })

-- Vim Motions
hl.unbind("SUPER + H")
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")
hl.unbind("SUPER + SHIFT + H")
hl.unbind("SUPER + SHIFT + J")
hl.unbind("SUPER + SHIFT + K")
hl.unbind("SUPER + SHIFT + L")

hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- moving between workspaces
hl.bind("SUPER + CTRL + J", hl.dsp.focus({ workspace = "m+1" }))
hl.bind("SUPER + CTRL + K", hl.dsp.focus({ workspace = "m-1" }))
hl.unbind("SUPER + mouse_up")
hl.unbind("SUPER + mouse_down")
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "m+1" }))
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "m-1" }))

hl.unbind("SUPER + GRAVE")
hl.unbind("SUPER + code:11")
hl.unbind("SUPER + code:12")
hl.unbind("SUPER + code:13")
hl.unbind("SUPER + code:14")
hl.unbind("SUPER + code:15")
hl.unbind("SUPER + code:16")
hl.unbind("SUPER + code:17")
hl.unbind("SUPER + code:18")
hl.unbind("SUPER + code:19")
hl.unbind("SUPER + SHIFT + GRAVE")
hl.unbind("SUPER + SHIFT + code:10")
hl.unbind("SUPER + SHIFT + code:11")
hl.unbind("SUPER + SHIFT + code:12")
hl.unbind("SUPER + SHIFT + code:13")
hl.unbind("SUPER + SHIFT + code:14")
hl.unbind("SUPER + SHIFT + code:15")
hl.unbind("SUPER + SHIFT + code:16")
hl.unbind("SUPER + SHIFT + code:17")
hl.unbind("SUPER + SHIFT + code:18")
hl.unbind("SUPER + SHIFT + code:19")

hl.bind("SUPER + GRAVE", hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 5 }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 6 }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 7 }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 8 }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 9 }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 10 }))
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 11 }))

hl.bind("SUPER + SHIFT + GRAVE", hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 8 }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 9 }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 10 }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 11 }))

hl.bind("SUPER + CTRL + SHIFT + J", hl.dsp.window.move({ workspace = "+1" }))
hl.bind("SUPER + CTRL + SHIFT + K", hl.dsp.window.move({ workspace = "-1" }))


-- Add extra bindings below.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Overwrite existing bindings with hl.unbind() first if needed.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, { omarchy = "walker -m symbols" })
