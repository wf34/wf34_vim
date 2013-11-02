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
	
        " Minimal number of screen lines to keep above and below the cursor.
	set scrolloff=999
	
	" Use UTF-8.
	set encoding=utf-8
        
	" Set color scheme that I like.
	if has("gui_running")
	    colorscheme desert
	else
	    colorscheme darkblue
    endif

" Search, higlighting search results and highlighting matched brackets
    set showmatch
    set hlsearch
    set incsearch
    set ignorecase
	
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

" NerdTREE
autocmd VimEnter * NERDTree | wincmd p




