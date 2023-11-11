-- Clangd --------------------------------------------------
local defaults = require 'plugins.lsp.defaults'
local lspconfig = require 'lspconfig'
local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

local function create_call_make(client)
    return function()
        local build_dir = client.workspace_folders[1].name .. '/build'
        local buildcmd  = "cd " .. build_dir .. " && "
        if vim.fn.isdirectory(build_dir) == 0 then
            vim.fn.mkdir(build_dir)
            buildcmd = buildcmd .. "cmake .. && "
        end
        buildcmd = buildcmd .. "make -j $(nproc)"
        require 'functions'.open_terminal(buildcmd)
    end
end

local function clang_on_attach(client, buffnr)
    vim.keymap.set('n', '<leader>m', create_call_make(client), {})
    defaults.on_attach(client, buffnr)
end

lspconfig.clangd.setup {
    on_attach = clang_on_attach,
    cmd = { "clangd",
        "--background-index",
        "--pch-storage=memory",
        "--clang-tidy",
        "--suggest-missing-includes",
        "--cross-file-rename",
        "--header-insertion=never" },
    capabilities = capabilities
}
