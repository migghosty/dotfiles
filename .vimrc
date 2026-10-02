"  __     _____ __  __ ____   ____
"  \ \   / /_ _|  \/  |  _ \ / ___|
"   \ \ / / | || |\/| | |_) | |
"    \ V /  | || |  | |  _ <| |___
"     \_/  |___|_|  |_|_| \_\\____|
"
" Author: Miguel Meza-Ponce

"""""""""""""""""""""""""""
" START - GENERAL
"""""""""""""""""""""""""""

" Vim not compatible with Vi
set nocompatible

" Set color
set t_Co=256
set background=dark
colorscheme desert

" let's not override background (for the transparency)
hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE

" Numbering
set number relativenumber

" Show cursor position
set ruler

" Fix autocomplete to match bash when pressing TAB
set wildmenu
set wildmode=longest,list,full
set path+=**

" Tabs
set expandtab " Tabs converted to spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set cindent

" autocomplete comments
set formatoptions+=crolq

" Show tabs and spaces
set list
set listchars=tab:→\ ,trail:·

" Screen
set scrolloff=10
set colorcolumn=100
set nowrap

" Searching
set incsearch
set ignorecase
set smartcase
set hlsearch

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
   \ if line("'\"") > 0 && line("'\"") <= line("$") |
   \   exe "normal! g`\"" |
   \ endif

"""""""""""""""""""""""""""
" END - GENERAL
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" START - SHORTCUTS
"""""""""""""""""""""""""""

" Change mapleader
nnoremap <SPACE> <Nop>
let mapleader=" "

" Remove Highlight
nnoremap <leader>h :noh<CR>

" Move forward in tag stack
nnoremap <leader>f :tag<CR>zz

" Move backward in tag stack
nnoremap <leader>b :pop<CR>zz

" Go to definition of tag
nnoremap <leader>d <C-]>zz

" Search and Replace
nnoremap R :%s//gc<Left><Left><Left>

" Search for current word
nnoremap S yw:grep!<space>-rw<space><C-r>"<space>*<CR>:copen<CR>

" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" fix this for netrw ; they override <c-l>, so override it back!
augroup netrw_fix
   autocmd!
   autocmd FileType netrw nnoremap <buffer> <c-l> <c-w>l
augroup END

" Make it easier to grow/shrink window size
nnoremap <c-up> <c-w>+
nnoremap <c-down> <c-w>-
nnoremap <c-left> <c-w><
nnoremap <c-right> <c-w>>

" Center cursor when jumping to next word in search
nnoremap n nzz
nnoremap N Nzz

" Escape when in insert mode
inoremap jj <esc>

" amazing remmap that doesn't need a comment
xnoremap p "_dP

" Jump to previous file - not working :(
" nnoremap <leader>p <c-6>

nnoremap <leader>n :set number! relativenumber! list!<CR>

"""""""""""""""""""""""""""
" END - SHORTCUTS
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" START - STATUS LINE
"""""""""""""""""""""""""""

" Always enable
set laststatus=2

" Color of statusline
" highlight Status ctermbg=250 ctermfg=21

" Clear status line when vimrc is reloaded.
set statusline=
" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R
" Use a divider to separate the left side from the right side.
set statusline+=%=
" Status line right side.
set statusline+=\ ascii:\ %b\ row:\ %l/%L\ col:\ %c\ percent:\ %p%%

"""""""""""""""""""""""""""
" END - STATUS LINE
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" START - PROGRAMMING
"""""""""""""""""""""""""""

" Look for tags upwards
set tags=tags;

" Need those man pages
" Usage:
"  :Man <manpage>
"  or
"  Hover over word
"     K --> open new page
"     <leader>K --> Horizontal split
runtime! ftplugin/man.vim

" Makefile tabs should be tabs not spaces
autocmd FileType make setlocal noexpandtab

" Trim whitespace for specific files
autocmd BufWritePre *.py,*.c,*.cpp,*.h :%s/\s\+$//e

"""""""""""""""""""""""""""
" END - PROGRAMMING
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" START - PLUGINS
"""""""""""""""""""""""""""
" install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" do the same as above but for nvim
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'ap/vim-buftabline'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'christoomey/vim-tmux-navigator'
Plug 'rust-lang/rust.vim'

call plug#end()

" BUFTABLINE
let g:buftabline_numbers = 1
let g:buftabline_indicators = 1
let g:buftabline_separators = 1

" NERDTREE
nnoremap <Leader>e :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" TAGBAR
let g:tagbar_use_cache = 0
nnoremap <Leader>o :TagbarOpenAutoClose<CR>

"""""""""""""""""""""""""""
" END - PLUGINS
"""""""""""""""""""""""""""

" syntax (plugins don't do this automatically so let's add it after)
syntax on
filetype plugin indent on

"""""""""""""""""""""""""""
" START - NEOVIM
"""""""""""""""""""""""""""
if has("nvim")
   set termguicolors    " enable 24-bit color support
   set mouse=           " disable mouse
endif

"""""""""""""""""""""""""""
" END - NEOVIM
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" START - THE END
"""""""""""""""""""""""""""

" source local vimrc
set exrc    " vim checks for current working directory .vimrc
set secure  " prevent risky commands (like shell exec) unless file is owned by ME

" Ideally we want the following in the project root directory
"
" Auto-generate ctags on save when inside a project
function! s:UpdateProjectTags() abort
   " Search upward from the current file for the project marker
   let l:marker = findfile('.proj_root', expand('%:p:h') . ';')
   if empty(l:marker)
      return
   endif
   " Directory holding the marker = project root
   let l:root = fnamemodify(l:marker, ':p:h')
   " Regenerate tags in the background, written to <root>/tags
   call system('ctags -R -f ' . shellescape(l:root . '/tags')
            \ . ' ' . shellescape(l:root) . ' &')
endfunction

augroup project_tags
   autocmd!
   autocmd BufWritePost * call s:UpdateProjectTags()
augroup END

" When in snapshot, run buildit
" TODO improve it instead of just hardcoding this stuff
"nnoremap <F5> :make<CR>:!./a.out<CR>
"nnoremap <F6> :!$SNAPSHOT/htr/target/litespeed/buildit apps.bin<CR>
" Auto create tags file (GIT)
"autocmd BufWritePost *.c,*.h
"   \ if !empty($SNAPSHOT) |
"   \  let source_path = $SNAPSHOT . "/htr/source/" |
"   \  let tags_path = source_path . "tags" |
"   \  silent! exe "!ctags -R -f" tags_path source_path "&" |
"   \ endif

" Auto create tags file (CLEARCASE)
"autocmd BufWritePost *.c,*.h
"   \ if !empty($CLEARCASE_ROOT) |
"   \  let source_path = "/cm_data/lte/ubb_lte/apps/source/" |
"   \  let tags_path = source_path . "tags" |
"   \  silent! exe "!ctags -R -f" tags_path source_path "&" |
"   \ endif

"""""""""""""""""""""""""""
" END - THE END
"""""""""""""""""""""""""""

