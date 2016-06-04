"""" @filename:		.vimrc 
"""" @date:		2016-06-4
"""" @author:		Hanlin Shi
"""" @version:		v1.11

"""" USE VUNDLE TO MANAGE PLUGINS
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
"" plugin on GitHub repo
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
"" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'ZoomWin'
"" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
"" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on  				" Indentation on
syntax on 						" Syntax highlighted
set number 						" Line number labeled
set mouse=a 						" Mouse enabled
set ttymouse=xterm2
set noswapfile						" Disable backup file
nmap <F8> :TagbarToggle<CR>				" Use F8 to use tagbar
2mat ErrorMsg '\%80v.'					" Highlight after 80 chars

"""" For the Java Course, use 4 space to replace TAB
au FileType java set tabstop=4 shiftwidth=4 expandtab
au FileType c set tabstop=2 shiftwidth=2 expandtab

"""" SWITCH WINDOW TO FULL-SIZE ('\\' in normal mode)
nnoremap <silent> <Leader><Leader> :ZoomWin<CR>

"""" AUTO COMPLETION ('tab' in insert mode, use 'shift+tab' if no completion is needed)
function! Smart_TabComplete()
	let line = getline('.')
	let substr = strpart(line, -1, col('.')+1)
	let substr = matchstr(substr, "[^ \t]*$")
	if (strlen(substr) == 0)
		return "\<tab>"
	endif
	let has_period = match(substr, '\.') != -1
	let has_slash  = match(substr, '\/') != -1
	if (!has_period && !has_slash)
		return "\<C-X>\<C-P>"
	elseif ( has_slash )
		return "\<C-X>\<C-F>"
	else
		return "\<C-X>\<C-O>"
	endif
endfunction
inoremap <tab> <c-r>=Smart_TabComplete()<CR>

"""" RELATIVE LINE NUMBERS ('ctrl+n' in normal mode)
function! NumberToggle()
	if(&relativenumber == 1)
		set norelativenumber
	else
		set relativenumber
	endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

"""" SWITCH BETWEEN SPLITS ('ctrl+{h,j,k,l}')
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"""" HIGHLIGHT CURRENT LINE ('\c' in normal mode)
set cursorline
hi CursorLine   cterm=bold ctermbg=DarkBlue guibg=darkred
hi CursorColumn cterm=bold ctermbg=DarkBlue guibg=darkred
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

"""" DISPLAY ALL OPEN BUFFERS
set laststatus=2
set ttimeoutlen=50
set t_Co=256
let g:airline_theme='dark'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_detect_spell=1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"""" KEYBINDS TO SWITCH BETWEEN TABS <'ctrl+{E,Q}'>
"nnoremap <C-E> :bn<CR>
"nnoremap <C-Q> :bp<CR>
