-- installing vimwiki
return {
    'vimwiki/vimwiki',
    init = function()
        vim.g.vimwiki_list = {
            {
                path = '/home/marijn/vimwiki/',
                syntax = 'markdown',
                listsyms = ' ○◐●✓',
                ext = '.md',
            }
        }
    end
}
