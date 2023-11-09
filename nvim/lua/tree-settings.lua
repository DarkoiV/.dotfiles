local tree = require("nvim-tree")

local EDITOR_WIDTH = vim.api.nvim_list_uis()[1].width
local EDITOR_HEIGHT = vim.api.nvim_list_uis()[1].height
local TREE_WINDOW_WDITH = math.min(80, EDITOR_WIDTH / 1.5)
local TREE_WINDOW_HEIGHT = math.min(100, EDITOR_HEIGHT / 1.5)

tree.setup
{
    hijack_cursor = true,
    view = 
    {
        float = 
        {
            enable = true,
            open_win_config = 
            {
                relative = "editor",
                border = {"▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌"},
                style  = "minimal",
                width = TREE_WINDOW_WDITH,
                height = TREE_WINDO_HEIGHT,
                row = (EDITOR_HEIGHT - TREE_WINDOW_HEIGHT) * 0.4,
                col = (EDITOR_WIDTH - TREE_WINDOW_WDITH) * 0.5
            }
        },
    },
    actions = 
    {
        open_file = 
        {
            quit_on_open = true
        }
    },
    renderer = 
    {
        group_empty = true,
        highlight_opened_files = "all",
        indent_markers = 
        {
            enable = true
        },
        icons = 
        {
            git_placement = "after",
        }
    }
}

