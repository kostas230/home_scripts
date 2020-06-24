set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-latex/vim-latex'

call vundle#end()
filetype plugin indent on

" Always enable status line
set laststatus=2

" Enable syntax highlighting
syntax on

" Display line number
set number

" Highlight current line
set cursorline
hi CursorLine cterm=NONE ctermbg=236 ctermfg=NONE

" Encoding
set encoding=utf-8

" Highlight matching search patterns
set hlsearch
" Enable incremental search
set incsearch
" Include matching uppercase words with lowercase search term
set ignorecase
" Include only uppercase words with uppercase search term
set smartcase

" Display options
set showmode
set showcmd

" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=5
" Fixes common backspace problems
set backspace=indent,eol,start

" Speed up scrolling in Vim
set ttyfast

" Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

let g:powerline_pycmd="py3"
let g:tex_flavor="latex"
