"""" @filename:		.vimrc 
"""" @date:		2015-8-30
"""" @author:		Hanlin Shi
"""" @version:		v1.0

"""" USE VUNDLE TO MANAGE PLUGINS
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
"" plugin on GitHub repo
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
"" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'ZoomWin'
Plugin 'vim-airline/vim-airline'
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
		set number
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

