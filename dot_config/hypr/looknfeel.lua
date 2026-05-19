-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
-- hl.config({
--   general = {
--     -- No gaps between windows or borders.
--     gaps_in = 0,
--     gaps_out = 0,
--     border_size = 0,

--     -- Change to niri-like side-scrolling layout.
--     layout = "scrolling",
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
hl.config({
    decoration = {
        -- Use round window corners.
        rounding = 10,

        -- Dim unfocused windows (0.0 = no dim, 1.0 = fully dimmed).
        dim_inactive = true,
        dim_strength = 0.10,
    },
})

hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "default", style = "slidevert" })
