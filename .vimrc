" --- General Settings ---
set nocompatible            " Disable compatibility with old Vi, enabling Vim features
syntax enable               " Enable syntax highlighting
filetype plugin indent on   " Enable file type plugins and indentation
set hidden                  " Allow buffers to be hidden without being written
set autoread                " Automatically re-read files if they change on disk
set history=1000            " Increase command history size
set ruler                   " Always show cursor position
set showmatch               " Highlight matching brackets/parentheses
set visualbell              " Use a visual flash instead of a beep for errors
set backspace=indent,eol,start " Make backspace work intuitively across indents and line breaks
set encoding=utf-8          " Use UTF-8 encoding

" --- UI Settings ---
set number                  " Show absolute line numbers
set relativenumber          " Show relative line numbers (great for navigation)
set cursorline              " Highlight the current line
set background=dark         " Adjust colors for a dark terminal background (use 'light' if needed)
set wildmenu                " Enhance command-line completion menu

" --- Indentation & Tabs ---
set tabstop=4               " A tab character occupies 4 spaces on screen
set shiftwidth=4            " Indent/dedent commands use 4 spaces
set softtabstop=4           " Backspace and tab keys use 4 spaces in insert mode
set expandtab               " Use spaces instead of tabs
set autoindent              " Copy indentation from the previous line
set smartindent             " Smarter indentation rules for coding

" --- Searching ---
set incsearch               " Show search matches as you type
set ignorecase              " Case-insensitive search
set smartcase               " Case-sensitive search only if uppercase letters are used in the pattern
set hlsearch                " Highlight search results

" --- Keyboard Mappings (Optional but highly recommended) ---
" Remap jj to escape in insert mode, much easier to reach than the Esc key
inoremap jj <Esc>

" Set <space> as the leader key instead of the default backslash
let mapleader = ' '
