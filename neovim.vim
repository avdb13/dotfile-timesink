set encoding=utf-8

set nocompatible
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set number
set laststatus=2
set equalalways
" Keep my lines 100 chars at most
set colorcolumn=120

let mapleader=","

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
Plug 'preservim/nerdtree'
Plug 'marko-cerovac/material.nvim'
Plug 'folke/trouble.nvim'
" Plug 'arthurxavierx/vim-caser'
Plug 'nvim-lua/plenary.nvim'

" Completion framework
Plug 'hrsh7th/nvim-cmp'

Plug 'm4xshen/autoclose.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-ts-autotag'

Plug 'turbio/bracey.vim'

Plug 'wakatime/vim-wakatime'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

Plug 'mrcjkb/rustaceanvim'

" A clean, dark Vim colorscheme
Plug 'cocopon/iceberg.vim'
Plug 'arzg/vim-colors-xcode'

Plug 'NvChad/nvim-colorizer.lua'
Plug 'xiyaowong/transparent.nvim'

" A light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim'
" The fancy start screen for Vim
Plug 'mhinz/vim-startify'
" Comment stuff out
Plug 'tpope/vim-commentary'

Plug 'tpope/vim-fugitive'

Plug 'ghifarit53/tokyonight-vim'
Plug 'folke/tokyonight.nvim'

Plug 'm4xshen/autoclose.nvim'

Plug 'arthurxavierx/vim-caser'
call plug#end()

syntax enable
filetype plugin indent on

set termguicolors
colorscheme tokyonight-moon

highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none

let g:neoformat_run_all_formatters = 1

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-tab>"

" Colors
" set background=dark
let g:material_terminal_italics = 1
let g:lightline = {
  \ 'colorscheme': 'tokyonight',
  \ }


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


" Trigger configuration
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" If you want :UltiSnipsEdit to split your window
let g:UltiSnipsEditSplit="vertical"

" let g:lightline = { 'colorscheme': 'one' }
let g:lightline.separator = { 'left': "\ue0c8", 'right': "\ue0ca" }
" let g:lightline.subseparator = { 'left': "\ue0c8", 'right': "\ue0ca" }
let g:lightline.tabline_separator = { 'left': "\ue0c8", 'right': "\ue0ca" }
let g:lightline.tabline_subseparator = { 'left': "\ue0c8", 'right': "\ue0ca" }

let g:NERDTreeChDirMode = 2

" Mappings
nnoremap <C-n> :NERDTreeToggle<CR>
inoremap jj <Esc>`^
nnoremap <C-t> :terminal<CR>
nnoremap <silent> <leader>rs :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
nnoremap <Space> :noh<CR>

xmap <leader>a <Plug>(EasyAlign)

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>x :Colors<CR>
nnoremap <leader>i :Lines<CR>
nnoremap <leader>s :Snippets<CR>
nnoremap <leader>m :Maps<CR>
nnoremap <leader>n :tabnew<CR>
nnoremap <leader>j :tabprev<CR>
nnoremap <leader>k :tabnext<CR>

" Removing trailing whitespaces
" au FileType c
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

" Nasty workaround to get YCM working
" au BufNewFile,BufRead *.tsx set filetype=typescript`

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

set foldmethod=indent
set foldnestmax=10
set foldlevel=2

set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

let g:bracey_browser_command = 'librewolf-bin --new-window'
lua require('init')

nnoremap <Leader>r :RustLsp codeAction<CR>
