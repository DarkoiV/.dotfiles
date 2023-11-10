local tree = require("nvim-tree")

local EDITOR_WIDTH = vim.api.nvim_list_uis()[1].width
local EDITOR_HEIGHT = vim.api.nvim_list_uis()[1].height
local TREE_WINDOW_WDITH = math.ceil(math.min(90, EDITOR_WIDTH / 1.5))
local TREE_WINDOW_HEIGHT = math.ceil(math.min(100, EDITOR_HEIGHT / 1.5))
local TREE_POS_Y = (EDITOR_HEIGHT - TREE_WINDOW_HEIGHT) * 0.4
local TREE_POS_X = (EDITOR_WIDTH - TREE_WINDOW_WDITH) * 0.5

local isSpecialFileName = function(name)
    if string.sub(name, 1, 4) == "init" then
        return true
    end
    return false
end

local sortSpecialNameFilesFirst = function(a, b)
    if isSpecialFileName(a.name) and isSpecialFileName(b.name) then
        return a.name < b.name
    elseif isSpecialFileName(a.name) then
        return true
    elseif isSpecialFileName(b.name) then
        return false
    else
        return a.name < b.name
    end
end

local sortFiles = function(a, b)
    if a.type == "directory" and b.type == "directory" then
        return a.name < b.name
    elseif a.type == "directory" then
        return true
    elseif b.type == "directory" then
        return false
    else
        return sortSpecialNameFilesFirst(a, b)
    end
end

tree.setup
{
    hijack_cursor = true,
    sort =
    {
        sorter = function(nodes)
            table.sort(nodes, sortFiles)
        end
    },
    view =
    {
        float =
        {
            enable = true,
            open_win_config =
            {
                relative = "editor",
                border   = { "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌" },
                style    = "minimal",
                width    = TREE_WINDOW_WDITH,
                height   = TREE_WINDOW_HEIGHT,
                row      = TREE_POS_Y,
                col      = TREE_POS_X
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
