"" Display numbers
set number
set relativenumber

" Expand tabs to spaces = 4 
set tabstop=4
set shiftwidth=4
set expandtab

call plug#begin()
"Main plugins
    Plug 'nvim-tree/nvim-tree.lua'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'dcampos/nvim-snippy'
    Plug 'rose-pine/neovim'

"CMP plugs
    Plug 'dcampos/cmp-snippy'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
    Plug 'hrsh7th/cmp-path'
call plug#end()

"File Tree explorer
:lua require("tree-settings")
:nnoremap <leader>n :NvimTreeFindFileToggle<CR>
:nnoremap <leader>N :NvimTreeToggle<CR>

:lua require("cmp-settings")
:lua require("lsp-settings")
:lua require("rose-pine-settings")

