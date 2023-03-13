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

-- diagnostic message configs
vim.diagnostic.config({
    virtual_text = false
})
vim.o.updatetime = 1000
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
