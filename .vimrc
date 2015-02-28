"
" wf34 vimrc
"

"## GENERAL CONFIGURATION ##################################################
    " enable jumping between buffers without saving them every time
    set hidden
    set autowrite
    " for painless copy-paste
    set pastetoggle=<F10>
    " Enable syntax highlighting.
    syntax on
    " Automatically indent when adding a curly bracket, etc.
    set smartindent
    " Tabs
    set shiftwidth=4
    set tabstop=4
    set smarttab
    set expandtab
    " Minimal number of screen lines to keep above and below the cursor.
    set scrolloff=999
    " Use UTF-8.
    set encoding=utf-8
    " Search, higlighting search results and highlighting matched brackets
    set showmatch
    set hlsearch
    set incsearch
    " Show line number, cursor position.
    set ruler
    " Obvious requirement
    set number
    "No reserve filecopies ~filename.txt 
    set nobackup
    "no junkfiles
    set noswapfile
    "line to indicate line length limit
    set colorcolumn=80


"## COLOR #########################################################
	" color scheme
	if has("gui_running")
        colorscheme molokai "desert
        set lines=999 columns=999 
        " Don't display the menu or toolbar. Just the screen. 
        set guioptions-=m 
        set guioptions-=T 
        " Font. Very important. 
        if has('win32') || has('win64') 
            set guifont=Consolas:h12:cANSI
        elseif has('unix') 
            let &guifont="Monospace 12" 
        endif
        " Try it with no mouse
        set mousehide
	else
	    colorscheme molokai "darkblue
    endif
    " molokai theme
    let g:molokai_original = 1



"## VUNGLE CONFIGURATION ##################################################
    " Required by Vundle
    set nocompatible              " be iMproved, required
    filetype off                  " required
    filetype plugin indent on    " required   
    " set the runtime path to include Vundle and initialize
    if has('win32') || has('win64')
        set rtp+=~/vimfiles/bundle/Vundle.vim/
        let path='~/vimfiles/bundle'
        call vundle#begin(path)
    elseif has('unix')
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#begin()
    endif
    " Plugin list
        Plugin 'gmarik/Vundle.vim' " required line
        Plugin 'Valloric/YouCompleteMe'
        Plugin 'scrooloose/nerdtree'
        Plugin 'vim-scripts/Vim-R-plugin'
        Plugin 'lervag/vim-latex'
        Plugin 'octol/vim-cpp-enhanced-highlight'
        Plugin 'bling/vim-airline'
    call vundle#end()



"## PLUGIN CONFIGURATIONS #################################################

    "-- NerdTREE ----------------------------------------------------------
        autocmd VimEnter * NERDTree | wincmd p
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType")
        \ && b:NERDTreeType == "primary") | q | endif
        " hide / show shortcut on NE
        command NE NERDTreeToggle

    "-- Vim-R-plugin ------------------------------------------------------
        set nocompatible
        filetype plugin on
        filetype indent on

    "-- YouCompleteMe -----------------------------------------------------
        let g:ycm_global_ycm_extra_conf =
            \'~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'

        " disable preview window appearence
        set completeopt -=preview
        let g:ycm_add_preview_to_completeopt = 0
        " switch ycm off/on [next line rem - it's on]
        " let g:loaded_youcompleteme = 1

    "-- Vim-LaTeX ---------------------------------------------------------
        let g:latex_latexmk_continuous = 0
        let g:latex_fold_enabled = 0
        command Co VimLatexCompile
        command Rei VimLatexReinit
 
    "-- vim-cpp-enhanced-highlight ----------------------------------------
        let g:cpp_class_scope_highlight = 1
        let g:cpp_experimental_template_highlight = 1

    "-- vim-airline -------------------------------------------------------
        let g:airline#extensions#tabline#enabled = 1

"## MISCELLIOUS #################################################
    " CMake syntax highlight
    autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt setf cmake
    " OpenGL shader highlight
    au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl
    " auto-commenting switched off
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o



