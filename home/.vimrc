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
" Syntax highlighting
Plugin 'sheerun/vim-polyglot'

" " GnuPG Encription
Plugin 'jamessan/vim-gnupg'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'


" terminal mux
Plugin 'kassio/neoterm'
"
" utility
Plugin 'mattn/webapi-vim'
"
" Pandoc things
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-latex/vim-latex'
"
" git
Plugin 'tpope/vim-fugitive'
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
Plugin 'vim-scripts/utl.vim'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/repeat.vim'
Plugin 'majutsushi/tagbar'
"
" " Python
Plugin 'vim-scripts/indentpython.vim'

" " Rust
" Plugin 'rust-lang/rust.vim'

Plugin 'sillybun/vim-repl'

" " Linters
Plugin 'dense-analysis/ale'

" " clojure
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'
" Plugin 'guns/vim-clojure-static'
" Plugin 'guns/vim-clojure-highlight'
" " Clojure repl
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-salve'
Plugin 'tpope/vim-classpath'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fireplace'
"
" " coffeescript
"Plugin 'kchmck/vim-coffee-script'
"
" " editor extras
"" Plugin 'powerline/powerline'
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
" neoterm {{{
" terminal mux
let g:neoterm_autoscroll = 1
let g:neoterm_keep_term_open = 0
let g:neoterm_auto_repl_cmd = 0


nmap <silent> <leader>pcb :vertical botright Tnew<CR>
nmap <silent> <leader>pcl :vertical botright T lumo<CR>
nmap <silent> <leader>pcc :vertical botright T clj<CR>
nmap <silent> <leader>pd :TcloseAll<CR>
nmap <silent> <leader>pR :TREPLSendFile<CR>
" nmap <silent> <leader>pf vaf:TREPLSendSelection<CR>
" nmap <silent> <leader>pe vie:TREPLSendSelection<CR>
xmap <silent> <leader>pp :TREPLSendSelection<CR>
" }}}
" vim-orgmode {{{
let g:org_indent = 0
let g:org_todo_keywords = [['TODO(t)', 'PROCESSING(p)', '|', 'DONE(d)'], ['|', 'CANCELED(c)']]
let g:org_todo_keyword_faces = [['IN-PROGRESS', 'cyan'],
			      \ ['CANCELED', [':foreground red', ':background black', ':weight bold',
			      \   ':slant italic', ':decoration underline']]]

let g:org_agenda_files = ['~/code/*/*/*.org', '~/index.org']
" }}}
" vim-repl {{{
" }}}
" color scheme{{{
set t_Co=256
syntax on "enable
" colorscheme vim70style
colorscheme distinguished
" colorscheme github
" " }}}
" Sliming {{{
let g:slime_target = "tmux"
" }}}
" {{{ vim-header
" let g:header_field_author = 'Aaron Niskin'
" let g:header_field_author_email = 'aaron@niskin.org'
" let g:header_field_filename = 0
" let g:header_field_timestamp_format = '%Y-%m-%d'
" let g:header_exclude_file_types = ['rst']
" }}}
" Powerline {{{
let g:python_highlight_all = 1
" python3 from powerline.vim import setup as powerline_setup
" python3 powerline_setup()
" python3 del powerline_setup
" set laststatus=2
" }}}
" NerdTree {{{
let NERDTreeShowHidden=1
" }}}
" Airline{{{
let g:airline_theme = g:colors_name
" let g:airline_powerline_fonts = 1                    " Fancy symbols
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
	let g:indent_guides_enable_on_vim_startup = 0        " doit when vim starts
	let g:indent_guides_auto_colors = 1                  " guide colors set by colorscheme
	let g:indent_guides_exclude_filetypes = ['help']     " don't doit to these
	let g:indent_guides_start_level = 1                  " start level
augroup END
" " }}}
" General options{{{
let mapleader = "["
augroup vanilla
	autocmd!
	" Standard things
	autocmd BufRead,BufNewFile * set wrap linebreak breakindent autoindent foldmethod=marker noshowmode number relativenumber ignorecase smartcase backup noswapfile backupdir=~/.vim-tmp sw=2 ts=2 sts=2 expandtab
	" Keybindings
	autocmd BufRead,BufNewFile * noremap <leader>a :ALENextWrap<CR>
	autocmd BufRead,BufNewFile * noremap <leader>r :REPLToggle<CR>
	autocmd BufRead,BufNewFile * noremap <leader>n :NERDTreeToggle<CR>
	autocmd BufRead,BufNewFile * noremap <leader>ev :vsplit $MYVIMRC<CR>
	autocmd BufRead,BufNewFile * nnoremap <C-J> a<CR><Esc>k$
	" To load .vimrc file from local directory
	autocmd BufRead,BufNewFile * set exrc
	autocmd BufRead,BufNewFile * set secure
	autocmd BufWritePre * :%s/\s\+$//e
	" open NERDTree on vim startup
	" autocmd vimenter * NERDTree
	autocmd VimEnter * wincmd w
	" close vim if only NERDTree left
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
"}}}
" FileType specific things.  {{{
augroup fileAssociations
	autocmd!
	" File-extension / FileType Associations
	autocmd BufRead,BufNewFile *.hcl,*.hcl.tpl     set filetype=hcl
	autocmd BufRead,BufNewFile *.nomad,*.nomad.tpl set filetype=hcl
	autocmd BufRead,BufNewFile *.pkr,*.pkr.tpl     set filetype=hcl
	autocmd BufRead,BufNewFile *.cljs.hl,*.boot    set filetype=clojure
	autocmd BufRead,BufNewFile *.md                set filetype=markdown
	autocmd BufRead,BufNewFile *.org               set filetype=org
	autocmd BufRead,BufNewFile *.yaml,*.yml        set filetype=yaml
	autocmd BufRead,BufNewFile *.py                set filetype=python
	autocmd BufRead,BufNewFile *.rs                set filetype=rust
	autocmd BufRead,BufNewFile *.asc               set filetype=gpg
	autocmd BufRead,BufNewFile *.h,*.c,*.cpp       set filetype=cpp
	autocmd BufRead,BufNewFile *.conf              set filetype=conf
	" FileType specific setlocals
	autocmd Filetype org        setlocal tw=72 noexpandtab
	autocmd FileType gitcommit  setlocal tw=72
	autocmd FileType tex        setlocal sw=4 ts=4 sts=4 spell
	autocmd FileType markdown   setlocal sw=4 ts=4 sts=4 spell
	autocmd FileType c          setlocal sw=4 ts=4 sts=4
	autocmd FileType cpp        setlocal sw=4 ts=4 sts=4
	autocmd FileType clojure    setlocal sw=2 ts=2 sts=2 lispwords+=page,cell-let,this-as,add-watch
	autocmd FileType javascript setlocal sw=2 ts=2 sts=2 expandtab
	autocmd FileType java       setlocal sw=4 ts=4 sts=4 noexpandtab
	autocmd FileType python     setlocal sw=4 ts=4 sts=4 ai expandtab formatprg=autopep8\ -
	autocmd FileType python     set omnifunc=pythoncomplete#Complete
	autocmd FileType rust       setlocal sw=4 ts=4 sts=4 ai expandtab
	autocmd FileType yaml       setlocal sw=2 ts=2 sts=2 expandtab
	autocmd FileType sh         setlocal sw=2 ts=2 sts=2 noexpandtab
	autocmd FileType json       setlocal sw=4 ts=4 sts=4 noexpandtab

	" FileType specific keybindings
	autocmd FileType c++ nnoremap <C-P> :w <CR> :! g++ -std=c++11 %
	autocmd FileType tex nnoremap <C-P> :w <CR> :! pdflatex % <CR> :! latexmk -c <CR> <CR>
	autocmd FileType rmd nnoremap <C-P> :w <CR> :! R -e "rmarkdown::render('"%"')" <CR>
augroup END
" }}}
