--load plugins
vim.cmd([[packadd packer.nvim]])
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    --syntax highlighting
    use 'nvim-treesitter/nvim-treesitter'
    use "lukas-reineke/indent-blankline.nvim"
    --lsp
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'
    --themes
    use 'ellisonleao/gruvbox.nvim'
    --status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    --autopair
    use 'windwp/nvim-autopairs'
end)

--theme settings
vim.o.background = "dark"
require("gruvbox").setup()
vim.cmd([[colorscheme gruvbox]])

--treesitter settings
local tsconfigs = require 'nvim-treesitter.configs'
tsconfigs.setup {
    ensure_installed = { "c", "lua", "vim", "help", "python", "rust" },
    highlight = {
        enable = true,
    }
}

--autopair settings
require("nvim-autopairs").setup {}

--indent guide settings
require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = false,
    char = '┃'
}

--lualine settings
require('lualine').setup {
    options = {
        theme = 'gruvbox_dark',
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
        icons_enabled = true,
    }
}

--lsp settings
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "sumneko_lua", "pyright", "clangd", "rust_analyzer" } })

local lspconf = require("lspconfig")
lspconf.sumneko_lua.setup {}
lspconf.pyright.setup {}
lspconf.clangd.setup {}
lspconf.rust_analyzer.setup {}

--neovim settings
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

--mappings
local key_mapper = function(mode, key, result)
    vim.api.nvim_set_keymap(
        mode,
        key,
        result,
        {noremap = true, silent = true}
    )
end

key_mapper('', '<up>', '<nop>')
key_mapper('', '<down>', '<nop>')
key_mapper('', '<left>', '<nop>')
key_mapper('', '<right>', '<nop>')
key_mapper('i', 'jk', '<ESC>')
key_mapper('v', 'jk', '<ESC>')

