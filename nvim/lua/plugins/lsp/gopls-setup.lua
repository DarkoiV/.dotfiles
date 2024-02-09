-- Gopls --------------------------------------------------
local defaults = require 'plugins.lsp.defaults'
local lspconfig = require 'lspconfig'
local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

lspconfig.gopls.setup {
    on_attach = defaults.on_attach,
    capabilities = capabilities,
}
