require('loadplugins')
require('themes')
require('syntaxhighlighting')
require('statusbar')
require('lsp')
require('completion')
require('keymappings')
require("nvim-autopairs").setup {}
require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = false,
    char = '┃'
}

-- markdown preview plugin
vim.cmd('let g:mkdp_auto_start = 0')
vim.cmd("let g:mkdp_theme = 'dark'")

vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.expandtab = true

vim.opt.cursorline = true
vim.opt.termguicolors = true


