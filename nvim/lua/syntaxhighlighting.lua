local tsconfigs = require 'nvim-treesitter.configs'
tsconfigs.setup {
    ensure_installed = { "c", "lua", "vim", "help", "python", "rust" },
    highlight = {
        enable = true,
    }
}

