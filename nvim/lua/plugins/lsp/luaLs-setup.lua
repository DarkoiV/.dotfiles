-- LuaLs ---------------------------------------------------
local defaults = require 'plugins.lsp.defaults'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function initForNeovimConfig(client)
    client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
            runtime = {
                version = 'LuaJIT'
            },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true)
            },
            insert_final_newline = true
        }
    })

    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
end

vim.lsp.config.lua_ls = {
    on_attach = defaults.on_attach,
    capabilities = capabilities,
    root_dir = function(filename)
        local nvimConfig = lspconfig.util.root_pattern("init.vim")(filename)
        local luaConfig = lspconfig.util.root_pattern(".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml",
            "stylua.toml", "selene.toml", "selene.yml", ".git")(filename)
        return nvimConfig or luaConfig
    end,
    on_init = function(client)
        -- SETUP FOR NEOVIM FILES
        local root = client.workspace_folders[1].name
        if vim.loop.fs_stat(root .. '/init.vim') then
            initForNeovimConfig(client)
        end
        return true
    end
}
