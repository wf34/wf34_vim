"
" wf34 vimrc
"

"## GENERAL CONFIGURATION ##################################################
    " enable jumping between buffers without saving them every time
    set hidden
    set autowrite
    set noshowmode
    " Enable syntax highlighting.
    syntax on
    filetype plugin on
    " Automatically indent when adding a curly bracket, etc.
    set smartindent
    " Tabs
    set shiftwidth=2
    set softtabstop=0
    set tabstop=2
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
    " line numbers
    set number
    " Show line number, cursor position.
    set ruler
    "No reserve filecopies ~filename.txt 
    set nobackup
    "no junkfiles
    set noswapfile
    "line to indicate line length limit
    set colorcolumn=100

    " Set Leader
    let mapleader = ","

    " kill bad habit
    noremap <up> <nop>
    noremap <down> <nop>
    noremap <left> <nop>
    noremap <right> <nop>

    " split switching
    nnoremap <A-j> : <C-W><J>
    nnoremap <A-k> : <C-W><K>
    nnoremap <A-l> : <C-W><L>
    nnoremap <A-h> : <C-W><H>

    " save
    nnoremap <C-S> : w <CR>

    " navigation
    nnoremap <Leader>l :ls<CR>:b<Space>

"## PLUGINS CONFIGURATION ##################################################
    call plug#begin('~/.vim/plugged')
        Plug 'Valloric/YouCompleteMe', { 'on' : [] }
        Plug 'rdnetto/YCM-Generator', { 'on' : [] }
        Plug 'scrooloose/nerdtree'
        Plug 'wincent/command-t'
        Plug 'itchyny/lightline.vim'
        Plug 'rking/ag.vim'
        Plug 'jeffkreeftmeijer/vim-numbertoggle'
        Plug 'rafi/awesome-vim-colorschemes'
        Plug 'kopischke/vim-fetch'
        Plug 'ConradIrwin/vim-bracketed-paste'
        Plug 'lervag/vimtex', { 'for' : ['tex', 'bib'] }
        Plug 'derekwyatt/vim-fswitch', { 'for' : ['c', 'cpp'] }
        Plug 'jeaye/color_coded', { 'for' : ['c', 'cpp'] }
        Plug 'embear/vim-uncrustify', { 'for' : ['c', 'cpp'] }
    call plug#end()

    augroup load_ycm
      autocmd!
      autocmd InsertEnter * call plug#load('YouCompleteMe') | autocmd! load_ycm
    augroup END

"## COLOR #########################################################
  set background=dark
  colorscheme two-firewatch

	if has("gui_running")
    set guioptions-=M
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    " Font. Very important.
    if has('win32') || has('win64')
        set guifont=Consolas:h12:cANSI
    elseif has('unix')
        set guifont=Iosevka\ Term\ Light\ 14
    endif
    " Try it with no mouse
    set mousehide
    " in case rightclick needed
    " set mousemodel = popup
  else
    set term=screen-256color
  endif
"## MISCELLIOUS #################################################
    " CMake syntax highlight
    autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt setf cmake
    " OpenGL shader highlight
    au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl
    " auto-commenting switched off
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    " buffer navigation
    nnoremap <C-l> : bn<CR>
    nnoremap <C-h> : bp<CR>

    " search cancel
    nnoremap <Leader>/ : noh<CR>

    "" Disable filetype-based indentation settings
    "filetype indent off
    "
    "" Disable loading filetype-based general configuration
    "filetype plugin off
    "
    "" These may be combined for brevity (disabling both)
    "filetype plugin indent off

    " clipboard paste
    nnoremap <silent> <S-Insert> "+p
    " clipboard copy
    vnoremap <silent> <C-Insert> "+y

"## PLUGIN CONFIGURATIONS #################################################

    "-- NerdTREE ----------------------------------------------------------
        " autostart and unfold tree
        autocmd VimEnter * NERDTree | wincmd p |
                \ if  0 != argc() && filereadable(argv(0)) && !isdirectory(argv(0)) |
                \     NERDTreeFind |
                \ endif |
                \ wincmd p |
                \ NERDTreeToggle
        

        " hide / show shortcut on NE
        command NE NERDTreeToggle

        " autoclose if last buffer
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

        " actualize tree as navigate through buffers **** works fucking messy, so rem out:
        " autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif

        let g:NERDTreeWinSize = 18

    "-- YouCompleteMe -----------------------------------------------------
        " let g:ycm_global_ycm_extra_conf =
        "     \'~/.vim/bundle/YouCompleteMe/.ycm_conf.py'

        " disable preview window appearence
        set completeopt -=preview
        let g:ycm_add_preview_to_completeopt = 0
        " switch ycm off/on [next line rem - it's on]
        " let g:loaded_youcompleteme = 1
        let g:ycm_python_binary_path = 'python3'
        let g:ycm_confirm_extra_conf = 0
        let g:ycm_show_diagnostics_ui = 0

    "-- Vim-LaTeX ---------------------------------------------------------
        let g:vimtex_latexmk_continuous = 0
        let g:vimtex_fold_enabled = 0
        let g:vimtex_latexmk_build_dir = 'build'
        let g:vimtex_imaps_enabled = 0
        let g:vimtex_indent_enabled = 0
        command Co VimtexCompile
        command Rei VimtexReinit
 
    "-- lightline -------------------------------------------------------
        set laststatus=2

    "-- ag.vim (silver searcher) ------------------------------------------
        let g:ag_working_path_mode="r"
        nnoremap <Leader>a : Ag!<SPACE>
        nnoremap <Leader><C-a> : Ag!<CR>

     "-- vim-fswitch ------------------------------------------------------
        " Comfortable mapping for switching source and header files
        nnoremap <Leader>s : FSHere<CR>

     "-- vim-numbertoggle -------------------------------------------------
        let g:UseNumberToggleTrigger = 1
        let g:NumberToggleTrigger = "<F2>"


    "-- color_coded -------------------------------------------------------
        let g:color_coded_enabled = 0
        let g:color_coded_filetypes = ['c', 'cpp', 'h', 'hpp', 'cxx', 'cc']

    "-- uncrustify -------------------------------------------------------
        let g:uncrustify_config_file = '/home/dmk0v/projects/sdc/tools/uncrustify/googlecpp.cfg'
        let g:uncrustify_debug = 1
        nnoremap <Leader>U : call Uncrustify() <CR>

    "-- command-t -------------------------------------------------------
      let g:CommandTCancelMap = ['<ESC>', '<C-c>']
