-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
hl.config({
    general = {
        gaps_out = {
            top = 8,
            bottom = 12,
            left = 12,
            right = 12
        },
        gaps_in = 5,
        -- border_size = 0,
    },
    decoration = {
        -- Use round window corners.
        -- Remove window borders (applies globally)
        rounding = 8,

        -- border_part_of_window = false,

        shadow = {
            enabled = true,
            -- render_power = 1,
            range = 0,
            sharp = true,
            offset = {5,5},
        },

        -- Dim unfocused windows (0.0 = no dim, 1.0 = fully dimmed).
        dim_inactive = true,
        dim_strength = 0.1,

        inactive_opacity = 0.75,

        blur = {
            enabled = true,
            size = 5,
            passes = 2,
            new_optimizations = true
        },

    },
})

hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "default", style = "slidevert" })


require("omarchy.current.theme.hypr-shadow")

-- workspace rules
-- hl.workspace_rule({ workspace = "1", gaps_in = 0, gaps_out = { top = 0 }, no_rounding = true, no_border = true })

hl.workspace_rule({ workspace = "w[v1]", no_border = true })

-- -- terminal rules
-- hl.window_rule({
--     name = "blur terminal",
--     match = { class = "com.mitchellh.ghostty" },
--     opacity = "0.9 0.6",
--     -- border_size = 0,
-- })
