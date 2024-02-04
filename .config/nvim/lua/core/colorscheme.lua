vim.o.termguicolors = true
local chosen_color = require("core.chosen_color")

require("catppuccin").setup({
    flavour = chosen_color,

    transparent_background = true,
    dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    
})
vim.cmd.colorscheme "catppuccin"
