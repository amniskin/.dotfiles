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
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'guns/xterm-color-table.vim'
"
" " color schemes
"Plugin 'vim-scripts/wombat256.vim'
"Plugin 'altercation/vim-colors-solarized'
Plugin 'flazz/vim-colorschemes'
"
" " }}}

" required by vundle {{{
"
call vundle#end()
filetype plugin indent on
"
" " }}}

" color scheme{{{
set t_Co=256
syntax on "enable
" colorscheme vim70style
colorscheme distinguished
" colorscheme github
" " }}}

" Airline{{{
let g:airline_theme = g:colors_name
"let g:airline_powerline_fonts = 1                    " Fancy symbols
let g:airline#extensions#tabline#enabled = 1         " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t'     " Show just the filename
let g:airline#extensions#tabline#tab_nr_type = 1     " Show buffer #, not # of splits
let g:airline#extensions#tabline#show_tab_nr = 1     " Show buffer # in tabline
let g:airline#extensions#tabline#show_tab_type = 1   " Show the tab type
let g:airline#extensions#tabline#buffer_idx_mode = 1 " Show buffer index
set laststatus=2 				     " To have airline show allways
" " }}}

" Indent Guides{{{
augroup indentguides
	autocmd!
	set background=dark
	let g:indent_guides_enable_on_vim_startup = 1        " doit when vim starts
	let g:indent_guides_auto_colors = 1                  " guide colors set by colorscheme
	let g:indent_guides_exclude_filetypes = ['help']     " don't doit to these
	let g:indent_guides_start_level = 1                  " start level
augroup END
" " }}}

" General options{{{
augroup vanilla
	autocmd!
	autocmd BufRead,BufNewFile * let mapleader = "\\"
	" Standard things
	autocmd BufRead,BufNewFile * set wrap sw=2 ts=2 softtabstop=2 noexpandtab linebreak nolist breakindent autoindent foldmethod=marker noshowmode number relativenumber ignorecase smartcase
	autocmd BufRead,BufNewFile * set backup noswapfile
	autocmd BufRead,BufNewFile * set backupdir=~/.vim-tmp
	" Keybindings
	autocmd BufRead,BufNewFile * noremap <leader>ev :vsplit $MYVIMRC<CR>
	autocmd BufRead,BufNewFile * nnoremap <C-J> a<CR><Esc>k$
	" To load .vimrc file from local directory
	autocmd BufRead,BufNewFile * set exrc
	autocmd BufRead,BufNewFile * set secure
augroup END
"}}}

" FileType specific things.  {{{
augroup fileAssociations
	autocmd!
	" File-extension / FileType Associations
	autocmd BufRead,BufNewFile *.cljs.hl,*.boot set filetype=clojure
	autocmd BufRead,BufNewFile *.md             set filetype=markdown
	autocmd BufRead,BufNewFile *.asc            set filetype=gpg
	autocmd BufRead,BufNewFile *.h,*.c,*.cpp    set filetype=cpp
	" FileType specific setlocals
	autocmd FileType tex        setlocal sw=4 ts=4 sts=4 spell
	autocmd FileType markdown   setlocal sw=4 ts=4 sts=4 spell
	autocmd FileType c          setlocal sw=4 ts=4 sts=4
	autocmd FileType cpp        setlocal sw=4 ts=4 sts=4
	autocmd FileType clojure    setlocal sw=2 ts=2 sts=2 lispwords+=page,cell-let,this-as,add-watch
	autocmd FileType javascript setlocal sw=4 ts=4 sts=4
	autocmd FileType python     setlocal sw=4 ts=4 sts=4
	" FileType specific keybindings
	autocmd FileType c++ nnoremap <C-P> :w <CR> :! g++ -std=c++11 %
	autocmd FileType tex nnoremap <C-P> :w <CR> :! pdflatex % <CR> :! latexmk -c <CR> <CR>
augroup END
" }}}
