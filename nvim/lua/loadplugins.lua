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
    use 'folke/tokyonight.nvim'
    use 'xiyaowong/nvim-transparent'

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
