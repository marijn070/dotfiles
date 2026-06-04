-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
local gap = 8
hl.config({
    general = {
        gaps_out = { top = 0, bottom = gap, left = gap, right = gap },
        gaps_in = gap / 2,
    },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
hl.config({
    decoration = {
        -- Use round window corners.
        rounding = 12,

        -- Dim unfocused windows (0.0 = no dim, 1.0 = fully dimmed).
        dim_inactive = true,
        dim_strength = 0.10,

        inactive_opacity = 0.85,
        blur = {
            enabled = true,
            size = 5,
            passes = 2,
            new_optimizations = true
        },

    },
})

hl.config({
    animations = {
        -- workspace_wraparound = true,
    }
})

hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "default", style = "slidevert" })

-- workspace rules
hl.workspace_rule({ workspace = "1", gaps_in = 0, gaps_out = { top = 0 }, no_rounding = true, no_border = true })

-- -- terminal rules
-- hl.window_rule({
--     name = "blur terminal",
--     match = { class = "com.mitchellh.ghostty" },
--     opacity = "0.9 0.6",
--     -- border_size = 0,
-- })
