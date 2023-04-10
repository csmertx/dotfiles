" Vundle Setup
set nocompatible
filetype off

"""""""""" MAIN
set clipboard+=unnamed
set number
set numberwidth=3
set encoding=utf-8
set autoindent
set copyindent
set preserveindent
set hlsearch
set ts=4
set autoindent
set expandtab
set shiftwidth=4
set guifont=Hack\ 12
autocmd Filetype markdown setlocal syntax=OFF
"syntax on
"colorscheme challenger_deep
"colorscheme deep-space
colorscheme angr
" set fillchars+=vert:│

" Check spelling
"set spell
"setlocal spell spelllang=en_us
"[s == select previous word
"]s == select next word
"z= provides a list of words to replace current selection
:map <F7> :setlocal spell! spelllang=en_us<CR>

" enable all Python syntax highlighting features
let python_highlight_all = 1

"""""""""" KEY MAPS
" Remove trailing whitespace characters with F8
nnoremap <F8> :%s/\s\+$//e<cr>

" Comment multiple lines for C and CSS
"nnoremap <F7> :norm i/*   */<cr>

" Fix indentation
"nnoremap <F6> mzgg=G`z<cr>

" Comment lines selected in Visual Mode <#> with F3 [or : and norm i<character>]
" Uncomment with comment characters selected with x
" vnoremap <buffer> <F3> :'<,'>norm i# <CR>

" Execute Python programs with <F9>
autocmd FileType python nnoremap <buffer> <F3> :exec '!clear; python' shellescape(@%, 1)<cr>

""""""""" PLUGINS
" <> characters in examples should be omitted
"filetype plugin on

" Pathogen 200319 - Replaced with Vundle
"execute pathogen#infect()

""""" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'preservim/nerdtree'
Plugin 'Yggdroot/indentline'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'lervag/vimtex'
Plugin 'xuhdev/SingleCompile'
Plugin 'godlygeek/tabular'
Plugin 'henrik/vim-indexed-search'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'jamessan/vim-gnupg'
call vundle#end()
filetype plugin indent on

""" Vundle Help
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line"
" Install: git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" Error: Not an editor command: Plugin 'VundleVim/Vundle.vim' (See Refresh)
" Refresh: rm -rf ~/.vim/bundle/Vundle.vim && cd ~/.vim/bundle && git clone https://github.com/VundleVim/Vundle.vim.git
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Airline Config
let g:airline_powerline_fonts = 1
let g:airline_theme='behelit'
set statusline+=%F

" VIM-latexsuite
" set template with <:TTemplate>
" Save <foo.tex> before <:TTemplate>
" export to pdf with <:normal \ll>
"set grepprg=grep\ -nH\ $*
let g:tex_flavor = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_MultipleCompileFormats='pdf, aux'
"set runtimepath=/home/chris/.vim/bundle/vim-latex-1.10.0

" Tabular
vnoremap <buffer> <F9> :Tab /\|<cr>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:syntastic_ignore_files = ['']
let g:syntastic_mode_map = { 'mode': 'passive' }
nnoremap <F2> :SyntasticToggleMode<cr>

" Syntastic Checkers
let g:syntastic_c_checkers = ['gcc']

" Single Compile
nmap <F11> :SCCompile<cr>
nmap <F12> :SCCompileRun<cr>

" :w!!
" write the file when you accidentally opened it without the right (root) privileges
cmap w!! w !sudo tee % > /dev/null

" NerdTree
autocmd vimenter * NERDTree
let NERDTreeShowHidden=1
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeWinSize = 20
highlight VertSplit cterm=NONE
set fillchars+=vert:█
"" If no :NERDTreeToggle via F4, in NORMAL mode try CTRL + ww, then :q
nnoremap <F4> :NERDTreeToggle<cr>
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" | b# | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * wincmd p
autocmd VimEnter * NERDTreeFind
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Highlight Current Line Number
set cursorline
hi cursorline cterm=NONE
hi cursorlinenr cterm=bold
hi cursorlinenr ctermfg=white
hi cursorlinenr ctermbg=black
