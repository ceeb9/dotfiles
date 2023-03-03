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

    --autocomplete
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'saadparwaiz1/cmp_luasnip'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'L3MON4D3/LuaSnip'

    --themes
    use 'ellisonleao/gruvbox.nvim'

    --status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    --autopair
    use 'windwp/nvim-autopairs'

    -- markdown preview plugin
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
end)

-- diagnostic message configs
vim.diagnostic.config({
    virtual_text = false
})
vim.o.updatetime = 1000
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

--lsp settings
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = {
    "lua_ls",
    "pyright",
    "clangd",
    "rust_analyzer",
    "html",
    "denols",
    "cssls"}
})

local lspconf = require("lspconfig")

local cmp = require('cmp')
local luasnip = require('luasnip')
local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
            end
    },
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp'},
    },
    window = {
        documentation = cmp.config.window.bordered()
    },
    formatting = {
        fields = {'menu', 'kind', 'abbr'}
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['<C-k>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-j>'] = cmp.mapping.select_next_item(select_opts),

        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, {'i', 's'}),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, {'i', 's'}),
    }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconf['lua_ls'].setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false;
            },
            telemetry = {
                enable = false;
            }
        },
    },
})

lspconf.pyright.setup {
    capabilities = capabilities,
}
lspconf.clangd.setup {
    capabilities = capabilities,
}
lspconf.rust_analyzer.setup {
    capabilities = capabilities,
}
lspconf.denols.setup {
    capabilities = capabilities,
}
lspconf.html.setup {
    capabilities = capabilities,
}
lspconf.cssls.setup {
    capabilities = capabilities,
}

-- autocomplete settings
vim.opt.completeopt = {
    'menu',
    'menuone',
    'noselect',
}


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

-- markdown preview plugin
vim.cmd('let g:mkdp_auto_start = 1')
vim.cmd("let g:mkdp_theme = 'dark'")

--lualine settings
require('lualine').setup {
    options = {
        theme = 'gruvbox_dark',
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
        icons_enabled = true,
    }
}


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

