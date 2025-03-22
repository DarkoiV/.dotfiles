-- JAVA LANGUAGE SERVER ------------------------------------
local defaults = require 'plugins.lsp.defaults'
local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

require 'lspconfig'.java_language_server.setup {
    on_attach = defaults.on_attach,
    capabilities = capabilities
}
