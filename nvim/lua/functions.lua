local open_terminal = function(command)
    local EDITOR_WIDTH = vim.api.nvim_list_uis()[1].width
    local EDITOR_HEIGHT = vim.api.nvim_list_uis()[1].height
    local TERM_WINDOW_WDITH = math.ceil(math.min(90, EDITOR_WIDTH / 1.5))
    local TERM_WINDOW_HEIGHT = math.ceil(math.min(120, EDITOR_HEIGHT / 1.5))
    local TERM_POS_Y = (EDITOR_HEIGHT - TERM_WINDOW_HEIGHT) * 0.4
    local TERM_POS_X = (EDITOR_WIDTH - TERM_WINDOW_WDITH) * 0.5
    local winnr = vim.api.nvim_open_win(0, true,
        {
            relative = "editor",
            border   = { "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌" },
            style    = "minimal",
            width    = TERM_WINDOW_WDITH,
            height   = TERM_WINDOW_HEIGHT,
            row      = TERM_POS_Y,
            col      = TERM_POS_X
        })
    if not command then
        vim.api.nvim_set_current_win(winnr)
        vim.cmd(':terminal')
        vim.cmd(':startinsert')
    else
        vim.api.nvim_set_current_win(winnr)
        vim.cmd(':terminal ' .. command)
    end
end

vim.keymap.set('n', '<leader>t', open_terminal, {})

return { open_terminal = open_terminal }
