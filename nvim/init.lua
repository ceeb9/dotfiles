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
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

--lsp settings
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = {
    "lua_ls",
    "pyright",
    "clangd",
    "rust_analyzer",
    "html",
    "eslint",
    "cssls"}
})

local lspconf = require("lspconfig")
lspconf.lua_ls.setup {
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
}

lspconf.pyright.setup {}
lspconf.clangd.setup {}
lspconf.rust_analyzer.setup {}
lspconf.eslint.setup({
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
})

lspconf.html.setup {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snipperSupport = true
lspconf.cssls.setup {
    capabilities = capabilities,
}

-- autocomplete settings
vim.opt.completeopt = {
    'menu',
    'menuone',
    'noselect',
}

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
        {name = 'nvim_lsp', keyword_length = 1},
        {name = 'buffer', keyword_length = 2},
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

