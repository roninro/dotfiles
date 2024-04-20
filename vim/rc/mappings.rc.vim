"---------------------------------------------------------------------------
" Key-mappings:
"

" Use ',' instead of '\'.
" Use <Leader> in global plugin.
let g:mapleader = ','
" Use <LocalLeader> in filetype plugin.
let g:maplocalleader = 'm'

" Use <C-Space>.
nmap <C-Space>  <C-@>
cmap <C-Space>  <C-@>

" [Space]: Other useful commands
" Smart space mapping.
nmap  <Space>   [Space]
nnoremap  [Space]   <Nop>

" Useful save mappings.
nnoremap <Leader><Leader> <Cmd>silent update<CR>


" s: Windows and buffers(High priority)
" The prefix key.
" nnoremap s    <Nop>
" nnoremap sp  <Cmd>vsplit<CR><Cmd>wincmd w<CR>
" nnoremap so  <Cmd>only<CR>
" nnoremap <Tab>      <cmd>wincmd w<CR>
" nnoremap <expr> q
"       \ &l:filetype ==# 'qf' ? '<Cmd>cclose<CR><Cmd>lclose<CR>' :
"       \ ('#'->winnr()->winbufnr()->getbufvar('&filetype') !=# 'qf'
"       \  && '$'->winnr() > 1) ? '<Cmd>close<CR>' : ''

" Original search
nnoremap s/    /
nnoremap s?    ?

" Useless command.
nnoremap M  m


" Smart <C-f>, <C-b>.
noremap <expr> <C-f> max([winheight(0) - 2, 1])
      \ .. '<C-d>' .. (line('w$') >= line('$') ? 'L' : 'M')
noremap <expr> <C-b> max([winheight(0) - 2, 1])
      \ .. '<C-u>' .. (line('w0') <= 1 ? 'H' : 'M')

" Select rectangle.
xnoremap r <C-v>

" Redraw.
nnoremap <C-l>    <Cmd>redraw!<CR>

" Easy escape.
inoremap jj           <ESC>
cnoremap <expr> j
      \ getcmdline()[getcmdpos()-2] ==# 'j' ? '<BS><C-c>' : 'j'

inoremap j<Space>     j

" NOTE: Does not overwrite <ESC> behavior
if has('nvim')
  tnoremap jj          <C-\><C-n>
else
  tnoremap <ESC><ESC>  <C-l>N
  tnoremap jj          <C-l>N
endif
tnoremap j<Space>   j
tnoremap <expr> ;  vimrc#sticky_func()
tnoremap <C-y>      <C-r>+

" Tag jump
nnoremap tt  g<C-]>
nnoremap tp  <Cmd>pop<CR>

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

