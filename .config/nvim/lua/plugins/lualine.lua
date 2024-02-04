return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        options = {
            theme = 'catppuccin',
            section_separators = '',
            component_separators = '',
            icons_enabled = true,
        }
    },
}
