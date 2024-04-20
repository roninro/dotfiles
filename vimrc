" vim: set foldmethod=marker foldlevel=0 nomodeline:
" ============================================================================
" .vimrc of Roninro {{{
" ============================================================================
if exists('+compatible') && &compatible
  set nocompatible
endif

let mapleader      = ' '
let maplocalleader = ' '

filetype plugin on
syntax on
" }}}

" ============================================================================
" VIM-PLUG {{{
" ============================================================================
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'

Plug 'tpope/vim-fugitive'
nmap     <Leader>g :Git<CR>gg<c-n>
nnoremap <Leader>d :Gdiff<CR>

Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'itchyny/lightline.vim'

Plug 'fatih/vim-go'

call plug#end()

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================

set nu
set autoindent
set smartindent
set lazyredraw
set laststatus=2
set showcmd
set visualbell
set backspace=indent,eol,start
set timeoutlen=500
set whichwrap=b,s
set shortmess=aIT
set hlsearch " CTRL-L / CTRL-R W
set incsearch
set hidden
set ignorecase smartcase
set wildmenu
set wildmode=full
set tabstop=2
set shiftwidth=2
set expandtab smarttab
set scrolloff=5
set encoding=utf-8
set list
set listchars=tab:\¦\ ,nbsp:+,trail:·,extends:→,precedes:←,
set virtualedit=block
set nojoinspaces
set diffopt=filler,vertical
set autoread
set clipboard=unnamed
set foldlevelstart=99
set grepformat=%f:%l:%c:%m,%f:%l:%m
set cursorline
set nrformats=hex
set completeopt=menuone,preview
silent! set cryptmethod=blowfish2

set updatetime=100

set signcolumn=yes

set formatoptions+=1
if has('patch-7.3.541')
  set formatoptions+=j
endif
if has('patch-7.4.338')
  let &showbreak = '↳ '
  set breakindent
  set breakindentopt=sbr
endif

if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set modelines=2
set synmaxcol=1000

" ctags
set tags=./tags;/

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.

" Semi-persistent undo
if has('persistent_undo')
  set undodir=/tmp,.
  set undofile
endif

" Shift-tab on GNU screen
" http://superuser.com/questions/195794/gnu-screen-shift-tab-issue
set t_kB=[Z

" set complete=.,w,b,u,t
set complete-=i

" mouse
silent! set ttymouse=xterm2
set mouse=a

" 80 chars/line
set textwidth=0

" Keep the cursor on the same column
set nostartofline

" FOOBAR=~/<CTRL-><CTRL-F>
set isfname-==

if !has('gui_running')
  set t_Co=256
endif

" 取消屏幕闪烁
set vb t_vb=

" }}}
" ============================================================================
" Colorscheme {{{
" ============================================================================
" colorscheme
set background=dark
let s:lightline_theme = 'wombat'
if has_key(g:plugs, 'catppuccin')
  colorscheme catppuccin_macchiato
  let s:lightline_theme = 'catppuccin_macchiato'
endif

" }}}

" ============================================================================
" Mapping {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Basic mappings
" ----------------------------------------------------------------------------
noremap <C-F> <C-D>
noremap <C-B> <C-U>

" Open new line below and above current line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Disable CTRL-A on tmux or on screen
if $TERM =~ 'screen'
  nnoremap <C-a> <nop>
  nnoremap <Leader><C-a> <C-a>
endif

" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
" nnoremap <Leader>q :q<cr>
" nnoremap <Leader>Q :qa!<cr>

" Delete buffers and close files in Vim without closing your windows
:nnoremap <Leader>q :Bdelete<CR>

" Tags
nnoremap <C-]> g<C-]>
nnoremap g[ :pop<cr>

" Jump list (to newer position)
nnoremap <C-p> <C-i>

" <leader>n | NERDTree
nnoremap <leader>n :NERDTreeToggle<cr>

" jk | Escaping!
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>

" Movement in insert mode
" inoremap <C-h> <C-o>h
" inoremap <C-l> <C-o>a
" inoremap <C-j> <C-o>j
" inoremap <C-k> <C-o>k


" Make Y behave like other capitals
nnoremap Y y$

" qq to record, Q to replay
nnoremap Q @q

" Zoom
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
        \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>

" Last inserted text
nnoremap g. :normal! `[v`]<cr><left>

" ----------------------------------------------------------------------------
" nvim
" ----------------------------------------------------------------------------
if has('nvim')
  tnoremap <a-a> <esc>a
  tnoremap <a-b> <esc>b
  tnoremap <a-d> <esc>d
  tnoremap <a-f> <esc>f
endif

" ----------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" ----------------------------------------------------------------------------
" <Leader>c Close quickfix/location window
" ----------------------------------------------------------------------------
nnoremap <leader>c :cclose<bar>lclose<cr>

" ----------------------------------------------------------------------------
" Markdown headings
" ----------------------------------------------------------------------------
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 m`^i### <esc>``4l
nnoremap <leader>4 m`^i#### <esc>``5l
nnoremap <leader>5 m`^i##### <esc>``6l

" ----------------------------------------------------------------------------
" Moving lines
" ----------------------------------------------------------------------------
nnoremap <silent> <C-k> :move-2<cr>
nnoremap <silent> <C-j> :move+<cr>
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
xnoremap <silent> <C-h> <gv
xnoremap <silent> <C-l> >gv
xnoremap < <gv
xnoremap > >gv

" }}}
" ============================================================================
" FUNCTIONS & COMMANDS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" :Root | Change directory to the root of the Git repository
" ----------------------------------------------------------------------------
function! s:root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echo 'Not in git repo'
  else
    execute 'lcd' root
    echo 'Changed directory to: '.root
  endif
endfunction
command! Root call s:root()

" ----------------------------------------------------------------------------
" AutoSave
" ----------------------------------------------------------------------------
function! s:autosave(enable)
  augroup autosave
    autocmd!
    if a:enable
      autocmd TextChanged,InsertLeave <buffer>
            \  if empty(&buftype) && !empty(bufname(''))
            \|   silent! update
            \| endif
    endif
  augroup END
endfunction

command! -bang AutoSave call s:autosave(<bang>1)

" }}}
" ============================================================================
" PLUGINS {{{
" ============================================================================
if has_key(g:plugs, 'lightline.vim')
  let g:lightline = {
        \ 'colorscheme': s:lightline_theme,
        \ 'separator': { 'left': '', 'right': '' },
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'filename' ], [ 'fugitive' ] ],
        \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'component_function': {
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename'
        \ }
        \ }
  function! LightlineModified()
    return &ft =~# 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction
  function! LightlineReadonly()
    return &ft !~? 'help\|vimfiler' && &readonly ? 'RO' : ''
  endfunction
  function! LightlineFilename()
    let fname = expand('%:t')
    return fname ==# 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
          \ fname =~# '^__Tagbar__\|__Gundo\|NERD_tree|__vista__' ? '' :
          \ &ft ==# 'vimfiler' ? vimfiler#get_status_string() :
          \ &ft ==# 'unite' ? unite#get_status_string() :
          \ &ft ==# 'vimshell' ? vimshell#get_status_string() :
          \ (LightlineReadonly() !=# '' ? LightlineReadonly() . ' ' : '') .
          \ (fname !=# '' ? fname : '[No Name]') .
          \ (LightlineModified() !=# '' ? ' ' . LightlineModified() : '')
  endfunction
  function! LightlineFugitive()
    if exists('*FugitiveHead')
      let l:branch = FugitiveHead()
      return strchars(l:branch) ? ' ' . l:branch : ''
    endif
  endif
  return ''
endfunction
endif


" }}}
" ============================================================================
