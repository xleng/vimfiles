" General "{{{
set nocompatible               " be iMproved


set history=256                " Number of things to remember in history.
set timeoutlen=500             " Time to wait after ESC (default causes an annoying delay)
"set clipboard+=unnamed         " Yanks go on clipboard instead.
set pastetoggle=<F10>          " toggle between paste and normal: for 'safer' pasting from keyboard
set shiftround                 " round indent to multiple of 'shiftwidth'

set modeline
set modelines=5                " default numbers of lines to read for modeline instructions

set autowrite                  " Writes on make/shell commands
set autoread

set nobackup
set nowritebackup
"set directory=/tmp//           " prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)
set noswapfile                 "

set hidden                     " The current buffer can be put to the background without writing to disk

set hlsearch                   " highlight search
set ignorecase                 " be case insensitive when searching
set smartcase                  " be case sensitive when input has a capital letter
set incsearch                  " show matches while typing

"let g:is_posix = 1             " vim's default is archaic bourne shell, bring it up to the 90s
let mapleader = ';'

if  has('win32')
   let os_name='nt'
else
   let os_name='posix'
endif
" "}}}

" Formatting "{{{
set fo+=o                      " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r                      " Do not automatically insert a comment leader after an enter
set fo-=t                      " Do no auto-wrap text using textwidth (does not apply to comments)

"set nowrap
set textwidth=0                " Don't wrap lines by default

set tabstop=4                  " tab size eql 4 spaces
set softtabstop=4
set shiftwidth=4               " default shift width for indents
set expandtab                  " replace tabs with ${tabstop} spaces
set smarttab                   "

set backspace=indent
set backspace+=eol
set backspace+=start

set autoindent
set cindent
set indentkeys-=0#            " do not break indent on #
set cinkeys-=0#
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do
set cinwords+=for,switch,case
" "}}}

" Visual "{{{
set t_Co=256
syntax enable                      " enable syntax

set cursorline
"set cursorcolumn
" set synmaxcol=250              " limit syntax highlighting to 128 columns

set mouse=a "enable mouse in GUI mode
set mousehide                 " Hide mouse after chars typed

set number                  " line numbers Off
set showmatch                 " Show matching brackets.
set matchtime=2               " Bracket blinking.

set wildmode=longest,list     " At command line, complete longest common string, then list alternatives.

set completeopt+=preview

set novisualbell              " No blinking
set noerrorbells              " No noise.
set vb t_vb=                  " disable any beeps or flashes on error

set laststatus=2              " always show status line.
set shortmess=atI             " shortens messages
set showcmd                   " display an incomplete command in statusline

"set statusline=%<%f\          " custom statusline
"set stl+=[%{&ff}]             " show fileformat
"set stl+=%y%m%r%=
"set stl+=%-14.(%l,%c%V%)\ %P


set statusline=[%n]\ \|\ FileName:\ %t%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=0x%B%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue guifg=black guibg=SeaGreen gui=bold


set foldenable                " Turn on folding
set foldmethod=marker         " Fold on the marker
set foldlevel=100             " Don't autofold anything (but I can still fold manually)

set foldopen=block,hor,tag    " what movements open folds
set foldopen+=percent,mark
set foldopen+=quickfix

set virtualedit=block

set splitbelow
set splitright

"set list                      " display unprintable characters f12 - switches
"set listchars=tab:\ ·,eol:¬
"set listchars+=trail:·
"set listchars+=extends:»,precedes:«
"map <silent> <F12> :set invlist<CR>

if has('gui_running')
  set guioptions=cMg " console dialogs, do not show menu and toolbar

  " Fonts
  "set guifont=Inconsolata\ 12
endif

if (has("win32") || has("win64") || has("win32unix"))
   let g:isWin=1
else
   let g:isWin=0
endif

" "}}}

" Key mappings " {{{
" Save file
nnoremap <leader>w :w<cr>


" map space to ':' in normal mode
nnoremap <space> :

" 快速在行尾添加; 
inoremap <leader>ae <esc>A;<esc>

" Duplication
"nnoremap <leader>c mz"dyy"dp`z
"vnoremap <leader>c "dymz"dP`z

"nnoremap <C-F> <C-U> " swap ^u
"nnoremap <C-U> <C-F> " with ^f : convenience!
nnoremap <leader>re :e $MYVIMRC<CR>
nnoremap <leader>rs :source $MYVIMRC<CR>
"nnoremap <leader>rt :tabnew ~/.vim/vimrc<CR>
"nnoremap <leader>re :e ~/.vim/vimrc<CR>
"nnoremap <leader>rd :e ~/.vim/ <CR>

" Tabs   
" alt + t   open current file in a new tab
nnoremap <M-t> :tabnew %<CR>    
nnoremap <M-h> :tabprev<CR>
nnoremap <M-l> :tabnext<CR>

" visual search with following binding: */#
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'b'
	execute "normal ?" . l:pattern . "<cr>"
    else
	execute "normal /" . l:pattern . "<cr>"
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>


" Esc
inoremap <leader>e <Esc>
"noremap <localleader><space> <Esc>
"noremap <Esc> <NOP>

" 自动完成括号和引号
inoremap <leader>1 ()<esc>:let leavechar=")"<cr>i
inoremap <leader>2 []<esc>:let leavechar="]"<cr>i
inoremap <leader>3 {}<esc>:let leavechar="}"<cr>i
inoremap <leader>4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap <leader>q ''<esc>:let leavechar="'"<cr>i
inoremap <leader>w ""<esc>:let leavechar='"'<cr>i
" add ' or " sround the select words in visual mode
" d will delete the selected words, it will be stored in " register in default
" then insert ' and paste the deleted words then add '.
vnoremap <leader>q di'<C-r>"'<esc>
vnoremap <leader>w di"<C-r>""<esc>

" copy filename 
"map <silent> <leader>. :let @+=expand('%:p').':'.line('.')<CR>
" copy path
"map <silent> <leader>/ :let @+=expand('%:p:h')<CR>

" Make Control-direction switch between windows (like C-W h, etc)
nmap <silent> <C-k> <C-W><C-k>
nmap <silent> <C-j> <C-W><C-j>
nmap <silent> <C-h> <C-W><C-h>
nmap <silent> <C-l> <C-W><C-l>

" vertical split with CommandT
nnoremap <leader>v :exec ':vnew \| CommandT'<CR>
" and without
nnoremap <leader>V :vnew<CR>
" " }}}

" AutoCommands " {{{
"au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru}     set ft=ruby tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
"au BufRead,BufNewFile {*.md,*.mkd,*.markdown}                         setf markdown
"au BufRead,BufNewFile {*.scala}                                       setf scala
"au! BufReadPost       {COMMIT_EDITMSG,*/COMMIT_EDITMSG}               set ft=gitcommit noml list| norm 1G
au! BufWritePost      *.snippet                                       call ReloadAllSnippets()
" open help in vertical split
"au BufWinEnter *.txt if &ft == 'help' | wincmd H | endif
" " }}}


" Scripts and Bundles " {{{
" set the runtime path to include Vundle and initialize
filetype off
if (g:isWin) 
   set rtp+=$HOME/vimfiles/bundle/Vundle.vim
   call vundle#begin("$HOME/vimfiles/bundle/")
else
   set rtp+=~/.vim/bundle/Vundle.vim
   call vundle#begin()
endif

" Some other plugins: http://vimawesome.com/
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'easymotion'

Plugin 'raimondi/delimitmate'

" 插件窗口的宽度，如TagList,NERD_tree等，自己设置
let s:PlugWinSize = 30

"colorscheme
" desert 256
Plugin 'rainux/vim-desert-warm-256'

" solarized
"Plugin 'Solarized'
"let g:solarized_termtrans = 1
"let g:solarized_termcolors = 256
"let g:solarized_contrast = "high"
"let g:solarized_visibility = "high"
"colorscheme solarized

Plugin 'scrooloose/nerdtree'
nmap <leader>nn :NERDTreeToggle<cr>
nmap <leader>nf :NERDTreeFind<cr>
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowLineNumbers=1

Plugin 'scrooloose/nerdcommenter'

" cpp syntax
Plugin 'octol/vim-cpp-enhanced-highlight'

" CtrlP  others: Unite, fzf
Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_files = 0
let g:ctrlp_working_path_mode = 'wr'
let g:ctrlp_mruf_relative = 1  "just list the current directory
set wildignore+=*.so,*.swp,*.zip,*.o     " Linux/MacOSX
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = {
   \ 'dir': '\v[\/](buildprocess|deliveries|packages|tools|build)$'
   \ }

Plugin 'DoxygenToolkit.vim'
nmap <leader>df :Dox<cr>
nmap <leader>dh :DoxAuthor<cr>

Plugin 'Valloric/YouCompleteMe'
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_extra_conf_globlist = ['./*']
nnoremap <leader>jd :YcmCompleter GoTo<CR>

" Ultisnips
"Plugin 'UltiSnips'
" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'xleng/vim-snippets'

let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"


" TagList set
" Plugin 'taglist.vim'
" nmap <silent> <leader>t :TlistToggle<cr>
" let Tlist_Show_One_File = 1
" let Tlist_Exit_OnlyWindow = 1 
" let Tlist_Use_Right_Window = 1
" let Tlist_File_Fold_Auto_Close = 1
" let Tlist_GainFocus_On_ToggleOpen = 0
" let Tlist_WinWidth = s:PlugWinSize
" let Tlist_Auto_Open = 0
" let Tlist_Display_Prototype = 0

" Tagbar
Plugin 'majutsushi/tagbar'
nmap <silent> <leader>t :TagbarToggle<cr>

" markdown
" https://github.com/plasticboy/vim-markdown/
Plugin 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled=1

" clang-format
" https://github.com/rhysd/vim-clang-format
Plugin 'rhysd/vim-clang-format'
" map to <Leader>cf in C++ code
autocmd FileType c,cpp nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp vnoremap <buffer><Leader>cf :ClangFormat<CR>


"Ack
Plugin 'mileszs/ack.vim'
if (g:isWin) 
   let g:ackprg='d:\Tools\bin\ag.exe --column --nogroup --noheading'
else
   let g:ackprg = 'ag --vimgrep'
endif

function! VisualAgGrep()
    let l:str = GetVisualTextStr()
    execute ":Ack ".l:str
endfunction

" Grep
Plugin 'vim-scripts/grep.vim'
let Grep_Default_Filelist = '*.c *.cpp *.h *.hpp *.py'
if (g:isWin)
    let Grep_Find_Path  = 'd:\Tools\bin\find.exe'
    let Grep_Xargs_Path = 'd:\Tools\bin\xargs.exe'
    let Grep_Path       = 'd:\Tools\bin\grep.exe'
    let Fgrep_Path      = 'd:\Tools\bin\fgrep.exe'
    let Egrep_Path      = 'd:\Tools\bin\egrep.exe'
    let Grep_Cygwin_Find = 1
    let Grep_Skip_Dirs = '_vimcfg buildprocess doc testapps tools packages target host config'
    let Grep_Skip_Files = ''
    let Grep_Xargs_Options = '-0'
    let Grep_Shell_Quote_Char = "'"
endif

function! GetVisualTextStr() 
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\ ')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    execute "normal! v"
    let @" = l:saved_reg
    return l:pattern
endfunction

function! VisualRgrep()
    let l:str = GetVisualTextStr()
    execute ":Rgrep ".l:str
endfunction

vnoremap <silent> <F5> :call VisualAgGrep() <CR><CR>
nnoremap <silent> <F5> :Ack <C-R><C-W> <CR><CR>

"command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
"function! QuickfixFilenames()
"  " Building a hash ensures we get each buffer only once
"  let buffer_numbers = {}
"  for quickfix_item in getqflist()
"    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
"  endfor
"  return join(values(buffer_numbers))
"endfunction

Plugin 'vim-airline/vim-airline'
"let g:airline#extensions#tabline#enabled = 1


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on      " Automatically detect file types.

 " }}}
 
" set colorscheme
set background=dark
try
   colorscheme  desert-warm-256
catch
endtry
