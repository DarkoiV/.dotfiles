local cmp                 = require("cmp")
local snippy              = require("snippy")

local has_words_before    = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local tab_behaviour       = function(fallback)
	if cmp.visible() then
		cmp.select_next_item()
	elseif snippy.can_expand_or_advance() then
		snippy.expand_or_advance()
	elseif has_words_before() then
		cmp.complete()
	else
		fallback()
	end
end

local shift_tab_behaviour = function(fallback)
	if cmp.visible() then
		cmp.select_prev_item()
	elseif snippy.can_jump(-1) then
		snippy.previous()
	else
		fallback()
	end
end

vim.opt.completeopt       = { 'menu', 'menuone', 'noselect' }
local select_opts         = { behavior = cmp.SelectBehavior.Insert }

cmp.setup({
	snippet = {
		expand = function(args)
			require 'snippy'.expand_snippet(args.body)
		end,
	},
	mapping = {
		['<TAB>'] = cmp.mapping(tab_behaviour, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(shift_tab_behaviour, { "i", "s" }),
		['<Up>'] = cmp.mapping.select_prev_item(select_opts),
		['<Down>'] = cmp.mapping.select_next_item(select_opts),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp',               keyword_length = 1 },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'snippy',                 keyword_length = 2 },
		{ name = 'path',                   keyword_length = 2 },
		{ name = 'buffer',                 keyword_length = 3 },
	})
})
