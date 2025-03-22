local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Specific LSP settings -----------------------------------
require "plugins.lsp.clangd-setup"
require "plugins.lsp.hls-setup"
require "plugins.lsp.gopls-setup"
require "plugins.lsp.luaLs-setup"
