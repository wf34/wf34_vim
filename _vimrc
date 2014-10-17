    " for painless copy-paste
    set pastetoggle=<F10>

    " Enable syntax highlighting.
	syntax on
	
	" Automatically indent when adding a curly bracket, etc.
    set smartindent
        
	" Tabs should be converted to a group of 4 spaces.
	" This is the official Python convention
    " (http://www.python.org/dev/peps/pep-0008/)
	" I didn't find a good reason to not use it everywhere.
	set shiftwidth=4
    set tabstop=4
    set smarttab
    set expandtab
	
    " Minimal number of screen lines to keep above and below the cursor.
	set scrolloff=999
	
	" Use UTF-8.
	set encoding=utf-8
        
	" Set color scheme that I like.
	if has("gui_running")
	    colorscheme desert
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
	    colorscheme darkblue
    endif

	" Search, higlighting search results and highlighting matched brackets
    set showmatch
    set hlsearch
    set incsearch
	
	" Status line
	set laststatus=2
	set statusline=
    set statusline+=%-3.3n\                      " buffer number
	set statusline+=%f\                          " filename
	set statusline+=%h%m%r%w                     " status flags
	set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
	set statusline+=%=                           " right align remainder
	set statusline+=0x%-8B                       " character value
    set statusline+=%-14(%l,%c%V%)               " line, character
	set statusline+=%<%P                         " file position
        
	" Show line number, cursor position.
	set ruler
	" Obvious requirement
	set number
	"No reserve filecopies ~filename.txt 
	set nobackup
    " Better look
    set antialias
    " Current line highlighted
    if has("gui_running")
        set cursorline
    else
        set cursorline
        hi CursorLine cterm=NONE ctermbg=darkgrey
    endif

    " Print special symbols
    " set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
    " set list
    " Signal the too long line
    autocmd FileType text setlocal textwidth=80
    au FileType c,cc,cpp,h,hpp,py,sh au BufWinEnter * let w:m1=matchadd('ErrorMsg', '\%>80v.\+', -1)

    " NerdTREE plugin configs
    autocmd VimEnter * NERDTree | wincmd p
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType")
    \ && b:NERDTreeType == "primary") | q | endif
    " hide/show nerdtree on NE
    :command NE NERDTreeToggle


" Lines added by the Vim-R-plugin command :RpluginConfig (2014-мар-19 00:46):
set nocompatible
filetype plugin on
filetype indent on

" Required by Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/vimfiles/bundle/Vundle.vim/
let path='~/vimfiles/bundle'
call vundle#begin(path)

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'scrooloose/nerdtree'
"Plugin 'vim-scripts/Vim-R-plugin'
call vundle#end()            " required
filetype plugin indent on    " required


"no junkfiles
set noswapfile

"" YouCompleteMe 
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'

" CMake syntax highlight
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt setf cmake 
