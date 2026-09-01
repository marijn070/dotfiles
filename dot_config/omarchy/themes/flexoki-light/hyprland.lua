-- Flexoki Light-specific appearance overrides.

local active_border_color = "#2c2c2b"
local inactive_border_color = "rgba(595959aa)"

hl.config({
  general = {
    gaps_out = {
      top = 8,
      bottom = 15,
      left = 8,
      right = 15,
    },
    gaps_in = 6,
    border_size = 3,
    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  decoration = {
    shadow = {
      range = 0,
      sharp = true,
      offset = { 7, 7 },
      color = active_border_color,
      color_inactive = inactive_border_color,
    },

    dim_inactive = true,
    dim_strength = 0.1,

    blur = {
      enabled = true,
      size = 5,
      passes = 2,
      new_optimizations = true,
    },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
  },
})

hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "default", style = "slidevert" })
