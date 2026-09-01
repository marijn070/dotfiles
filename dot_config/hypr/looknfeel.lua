-- Shared appearance overrides.
-- Theme-specific appearance belongs in ~/.config/omarchy/themes/<theme>/hyprland.lua.

hl.config({
  general = {
    gaps_out = {
      top = 8,
      bottom = 12,
      left = 12,
      right = 12,
      border_size = 3,
    },
  },
  decoration = {
    rounding = 4,
    inactive_opacity = 0.75,
    shadow = {
      enabled = true,
      range = 5,
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

})


hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "default", style = "slidevert" })
