set encoding=utf-8

set nocompatible
set background=dark
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set number
set laststatus=2
set equalalways
set colorcolumn=100
set termguicolors
set foldmethod=indent
set foldnestmax=10
set foldlevel=2
set completeopt=menuone,noinsert,noselect
set shortmess+=c

let mapleader=","

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

Plug 'mhinz/vim-startify'
Plug 'preservim/nerdtree'
Plug 'folke/trouble.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'tpope/vim-commentary'
Plug 'arthurxavierx/vim-caser'
Plug 'm4xshen/autoclose.nvim'

Plug 'folke/tokyonight.nvim'
Plug 'itchyny/lightline.vim'
Plug 'NvChad/nvim-colorizer.lua'
Plug 'xiyaowong/transparent.nvim'

Plug 'mrcjkb/rustaceanvim'
Plug 'tpope/vim-fugitive'
Plug 'wakatime/vim-wakatime'
call plug#end()

syntax enable
filetype plugin indent on

" Startify
let g:ascii = [
      \ '                      /^--^\     /^--^\     /^--^\',
      \ '                      \____/     \____/     \____/',
      \ '                     /      \   /      \   /      \',
      \ '                    |        | |        | |        |',
      \ '                     \__  __/   \__  __/   \__  __/',
      \ '|^|^|^|^|^|^|^|^|^|^|^|^\ \^|^|^|^/ /^|^|^|^|^\ \^|^|^|^|^|^|^|^|^|^|^|^|',
      \ '| | | | | | | | | | | | |\ \| | |/ /| | | | | | \ \ | | | | | | | | | | |',
      \ '########################/ /######\ \###########/ /#######################',
      \ '| | | | | | | | | | | | \/| | | | \/| | | | | |\/ | | | | | | | | | | | |',
      \ '|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|',
      \ ''
      \]
let g:startify_custom_header =
          \ 'startify#pad(g:ascii + startify#fortune#boxed())'

let g:lightline = { 'colorscheme': 'one' }
let g:lightline.separator = { 'left': "\ue0c8", 'right': "\ue0ca" }
" let g:lightline.subseparator = { 'left': "\ue0c8", 'right': "\ue0ca" }
let g:lightline.tabline_separator = { 'left': "\ue0c8", 'right': "\ue0ca" }
let g:lightline.tabline_subseparator = { 'left': "\ue0c8", 'right': "\ue0ca" }

inoremap jj <Esc>`^
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <leader>rs :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
nnoremap <Space> :noh<CR>
nnoremap <Leader>r :RustLsp codeAction<CR>
nnoremap <leader>n :tabnew<CR>
nnoremap <leader>j :tabprev<CR>
nnoremap <leader>k :tabnext<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

colorscheme tokyonight-night

lua require('init')
