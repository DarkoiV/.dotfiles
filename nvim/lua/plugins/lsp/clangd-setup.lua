-- Clangd --------------------------------------------------
local defaults = require 'plugins.lsp.defaults'
local lspconfig = require 'lspconfig'
local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

lspconfig.clangd.setup {
    on_attach = defaults.on_attach,
    cmd = { "clangd",
        "--background-index",
        "--pch-storage=memory",
        "--clang-tidy",
        "--suggest-missing-includes",
        "--cross-file-rename",
        "--header-insertion=never" },
    capabilities = capabilities
}
