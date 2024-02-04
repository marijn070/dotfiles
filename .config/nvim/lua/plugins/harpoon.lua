return { 
    'ThePrimeagen/harpoon',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require('telescope').load_extension('harpoon')
        local mark = require('harpoon.mark')
        local ui = require('harpoon.ui')
        vim.keymap.set('n', '<leader>a', mark.add_file)
        vim.keymap.set('n', '<leader>fh', ui.toggle_quick_menu)
        vim.keymap.set('n', '<a-1>', function() ui.nav_file(1) end)
        vim.keymap.set('n', '<a-2>', function() ui.nav_file(2) end)
        vim.keymap.set('n', '<a-3>', function() ui.nav_file(3) end)
        vim.keymap.set('n', '<a-4>', function() ui.nav_file(4) end)
    end,
}
