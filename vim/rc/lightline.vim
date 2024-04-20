set showtabline=2

let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'

let g:lightline = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

let g:lightline.colorscheme = g:fong#lightline_theme
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.active = {
  \   'left': [ [ 'mode', 'paste' ], [ 'filename' ], [ 'fugitive' ] ],
  \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ }
let g:lightline.component_function = {
  \   'fugitive': 'LightlineFugitive',
  \   'filename': 'LightlineFilename'
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
  return ''
endfunction
