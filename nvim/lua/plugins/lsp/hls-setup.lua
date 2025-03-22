-- HLS -----------------------------------------------------
local defaults = require 'plugins.lsp.defaults'
local lspconfig = require 'lspconfig'
local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

lspconfig.hls.setup {
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    on_attach = function(_, buffnr)
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        defaults.on_attach(_, buffnr)
    end,
    capabilities = capabilities
}
