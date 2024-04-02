local tree = require("nvim-tree")

local EDITOR_WIDTH = vim.api.nvim_list_uis()[1].width
local EDITOR_HEIGHT = vim.api.nvim_list_uis()[1].height
local TREE_WINDOW_WDITH = math.ceil(math.min(90, EDITOR_WIDTH / 1.5))
local TREE_WINDOW_HEIGHT = math.ceil(math.min(100, EDITOR_HEIGHT / 1.5))
local TREE_POS_Y = (EDITOR_HEIGHT - TREE_WINDOW_HEIGHT) * 0.4
local TREE_POS_X = (EDITOR_WIDTH - TREE_WINDOW_WDITH) * 0.5

local function match(name, to)
    if (#name < #to) then return false end
    return string.sub(name, 1, #to) == to
end

local function isDirectory(node)
    return node.type == "directory"
end

local isNotSpecialFile = function(node)
    local specialNames = { "init", "CMakeLists.txt" }
    for _, v in pairs(specialNames) do
        if match(node.name, v) then
            return false
        end
    end
    return true
end

local isDotFile = function(node)
    return match(node.name, ".")
end

local byName = function(a, b)
    return a.name < b.name
end

local sortByRule = function(a, b, rule)
    if rule(a) and rule(b) then
        return nil
    elseif rule(a) then
        return true
    elseif rule(b) then
        return false
    else
        return nil
    end
end

local sortNodes = function(a, b)
    local rules = { isDirectory, isDotFile, isNotSpecialFile }
    for _, rule in pairs(rules) do
        local result = sortByRule(a, b, rule)
        if result ~= nil then return result end
    end
    return byName(a, b)
end

tree.setup
{
    hijack_cursor = true,
    sort_by = function(nodes)
        table.sort(nodes, sortNodes)
    end,
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
