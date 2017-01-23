" required by vundle {{{
"
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"
Plugin 'gmarik/Vundle.vim'
"
" "}}}

" Plugins {{{
" " GnuPG Encription
Plugin 'jamessan/vim-gnupg'
"
" utility
Plugin 'mattn/webapi-vim'
"
" Pandoc things
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-rmarkdown'
"
" git
"Plugin 'tpope/vim-fugitive'
Plugin 'mattn/gist-vim'
"
" " searching
"Plugin 'kien/ctrlp.vim'
"Plugin 'kien/ctrlspace.vim'
"
" " completion
Plugin 'ervandew/supertab'
"
" " editing
"Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
"
" " helpers
"Plugin 'tpope/vim-dispatch'
"Plugin 'tpope/vim-projectionist'
"
" " html
"Plugin 'mattn/emmet-vim'
"
" " clojure
Plugin 'tpope/vim-fireplace'
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'
Plugin 'guns/vim-clojure-static'
Plugin 'guns/vim-clojure-highlight'
"Plugin 'rkneufeld/vim-boot'
"
" " coffeescript
"Plugin 'kchmck/vim-coffee-script'
"
" " editor extras
Plugin 'bling/vim-airline'
Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'guns/xterm-color-table.vim'
"
" " color schemes
"Plugin 'vim-scripts/wombat256.vim'
"Plugin 'altercation/vim-colors-solarized'
Plugin 'flazz/vim-colorschemes'
"
" " }}}
"
" required by vundle {{{
"
call vundle#end()
filetype plugin indent on
"
" " }}}
"
" vim options{{{
set wrap
set shiftwidth=2
set tabstop=2
set softtabstop=2 
set noexpandtab
set linebreak
set nolist     		" list disables linebreak
""set breakindent
set autoindent
set foldmethod=marker
set noshowmode
set number
set relativenumber
set backup
set swapfile
set backupdir=~/.vim-tmp
set directory=~/.vim-tmp
set ignorecase    " case insensitive searching
set smartcase     " If I type capitals, then searches are case sensitive
no ' $
no " ^

nmap <C-J> a<CR><Esc>k$
"}}}
"
" LaTeX options{{{
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
"}}}
"
" color scheme{{{
set t_Co=256
syntax on "enable
" colorscheme vim70style
colorscheme distinguished
" colorscheme github
" " }}}
"
" Airline{{{
"let g:airline_theme = 'wombat'                       " Airline colorscheme
"let g:airline_powerline_fonts = 1                    " Fancy symbols
let g:airline#extensions#tabline#enabled = 1         " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t'     " Show just the filename
let g:airline#extensions#tabline#tab_nr_type = 1     " Show buffer #, not # of splits
let g:airline#extensions#tabline#show_tab_nr = 1     " Show buffer # in tabline
let g:airline#extensions#tabline#show_tab_type = 1   " Show the tab type
let g:airline#extensions#tabline#buffer_idx_mode = 1 " Show buffer index
set laststatus=2 				     " To have airline show allways
" " }}}
"
" Indent Guides{{{
let g:indent_guides_enable_on_vim_startup = 1        " doit when vim starts
let g:indent_guides_auto_colors = 0                  " guide colors set by colorscheme
let g:indent_guides_exclude_filetypes = ['help']     " don't doit to these
let g:indent_guides_start_level = 1                  " start level
" " }}}
"
" FileType specific things.  {{{
"   to associate hoplon files with clojure syntax
augroup amniskin
	autocmd!
	autocmd BufRead,BufNewFile *.cljs.hl,*.boot set filetype=clojure
	autocmd BufRead,BufNewFile *.md set filetype=markdown
	autocmd BufRead,BufNewFile *.asc set filetype=gpg
  autocmd FileType clojure setlocal lispwords+=page,cell-let,this-as,add-watch
augroup END

" setting tabstop to 4 four JavaScript
autocmd FileType tex :setlocal sw=4 ts=4 sts=4 spell
autocmd FileType tex :map <C-P> :w <CR> :! pdflatex % <CR> :! latexmk -c <CR> <CR>
autocmd FileType markdown :setlocal sw=4 ts=4 sts=4 spell
autocmd FileType clojure :setlocal sw=2 ts=2 sts=2 
autocmd FileType javascript :setlocal sw=4 ts=4 sts=4 
autocmd FileType python :setlocal sw=4 ts=4 sts=4 
" }}}
