"""" @filename: .vimrc 
"""" @date: 2022-01-08
"""" @author: hanlins
"""" @version: v1.2.0

"""" USE VUNDLE TO MANAGE PLUGINS
"" First time user should install vundle before using, please clone vundle repo
"" to appropriate location:
"" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"" then get into vim, and typein ':PluginInstall' to install required plugins.
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
Plugin 'fatih/vim-go'
Plugin 'morhetz/gruvbox'
"" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'ZoomWin'
Plugin 'rust-lang/rust.vim'
Plugin 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install() } }
" Install coc: cd ~/.vim/bundle/coc.nvim/ && yarn install
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'kien/ctrlp.vim'
Plugin 'ctrlpvim/ctrlp.vim'
"" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
"" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
Plugin 'github/copilot.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on  				" Indentation on
syntax on 						" Syntax highlighted
set number 						" Line number labeled
set mouse=a 						" Mouse enabled
if !has('nvim')
	set ttymouse=xterm2
endif
set noswapfile						" Disable backup file
nmap <F8> :TagbarToggle<CR>				" Use F8 to use tagbar
2mat ErrorMsg '\%80v.'					" Highlight after 80 chars
set rtp+=$GOROOT/misc/vim				" Syntax Highlight for Go

"""" For the Java Course, use 4 space to replace TAB
au FileType java set tabstop=4 shiftwidth=4 expandtab
au FileType c set tabstop=2 shiftwidth=2 expandtab

"""" For Rust, use gd to go to definition
call coc#add_extension(
  \ 'coc-rust-analyzer',
\ )
autocmd FileType rust nmap <silent> gd <Plug>(coc-definition)
autocmd FileType rust nmap <silent> gy <Plug>(coc-type-definition)
autocmd FileType rust nmap <silent> gi <Plug>(coc-implementation)
autocmd FileType rust nmap <silent> gr <Plug>(coc-references)
let g:rustfmt_autosave = 1
let g:rust_cargo_use_clippy = 1

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
hi CursorLine   cterm=bold ctermbg=DarkGrey guibg=darkred
hi CursorColumn cterm=bold ctermbg=DarkRed guibg=darkred
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

"""" DISPLAY ALL OPEN BUFFERS
let g:go_version_warning = 0
set laststatus=2
set ttimeoutlen=25
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

"""" KEYBINDS TO SWITCH BETWEEN TABS <'ctrl+{A,D}'>
nmap <C-A> :tabprevious<CR>
nmap <C-D> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

"""" SYNTAX HIGHLIGHT FOR GOLANG (syntax file 'go.vim' stored on ~/.vim/syntax/)
"" golang syntax file can be find at:
"" http://www.vim.org/scripts/script.php?script_id=2854
filetype on
au BufRead,BufNewFile *.go set filetype=go
"" au VimEnter *.go GoAutoTypeInfoToggle

"""" COLOR THEME
" colorscheme gruvbox
" set background=dark    " Setting dark mode, alternative one is "light"
"let g:gruvbox_contrast="hard"

"""" BUFFER OPERATIONS
" :bn				" next buffer
" :bp				" previous buffer
" :b#				" buffer number '#'

"""" USE 'ctrl+c' TO COPY TO SYSTEM CLIPBOARD
map <silent> <C-C> :<CR>:let @a=@" \| execute "normal! vgvy" \| let res=system("pbcopy", @") \| let @"=@a<CR>
map <C-P> :r !pbpaste<CR>

"""" CtrlP SETUP
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" USE THE NEAREST .git DIRECTORY AS THE CWD
let g:ctrlp_working_path_mode = 'r'

" USE A LEADER INSTEAD OF THE ACTUAL NAMED BINDING
let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = 'CtrlP'

" EASY BINDINGS FOR ITS VARIOUS MODES
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

" vim-go config
let g:go_auto_sameids = 1
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10000,results:0'
let g:go_auto_type_info = 1
