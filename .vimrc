"=============================================================================
" vimrc --- Entry file for vim
" Copyright (c) 2016-2017 Shidong Wang & Contributors
" Author: Shidong Wang < wsdjeg at 163.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

" Note: Skip initialization for vim-tiny or vim-small.
if 1
    let g:_spacevim_if_lua = 0
    if has('lua')
        let s:plugin_dir = fnamemodify(expand('<sfile>'), ':h').'\lua'
        let s:str = s:plugin_dir . '\?.lua;' . s:plugin_dir . '\?\init.lua;'
        silent! lua package.path=vim.eval("s:str") .. package.path
        if empty(v:errmsg)
            let g:_spacevim_if_lua = 1
        endif
    endif
    execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'
endif
" vim:set et sw=2
set ai                          " set auto-indenting on for programming
set ruler                       " show the cursor position all the time
set nu			        " always display number
set tabstop=2                   " Tabs will be represented by to spaces in normal/visual mode
set softtabstop=2               " Tabs will be represented by two spaces
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " make that backspace key work the way it should
set cursorline                  " highlight current line
set wildmenu                    " visual autocomplete for command menu
set showmatch                   " highlight matching [{()}]
set nocompatible                " vi compatible is LAME
set showmode                    " show the current mode
set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
set copyindent			" copy the previous indentation for autoindenting
set wrap			" don't wrap lines
set smartcase			" ignore case if searchy patter is all lowercase, otherwise normal
set shiftround			" use multiple of shiftwidth
syntax on                       " turn syntax highlighting on by default
set autoindent                  " Sets indent to same as previous line
noremap <C-d> :sh<cr>           " ctrld to go to shell
set paste                       " Ensure paste works correctly
let g:vim_markdown_folding_disabled =1 "turn off folding
set incsearch                   " search as characters are entered
set hlsearch                    " highlight matches
set foldenable                  " enable folding
set foldlevelstart=10           " open most folds by default
set foldnestmax=10              " 10 nested fold max
set foldmethod=indent           " fold based on indent level
let mapleader=","               " leader is comma
inoremap jk <esc>               " jk is escape
nnoremap <leader>s :mksession<CR> " Vim super save all the windows
nnoremap <leader>a :Ag          " Silver Search set to ,a
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
                \:call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

