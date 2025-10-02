-- Gopls --------------------------------------------------
local defaults = require 'plugins.lsp.defaults'
local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

vim.lsp.config.gopls = {
    on_attach = defaults.on_attach,
    capabilities = capabilities,
}
