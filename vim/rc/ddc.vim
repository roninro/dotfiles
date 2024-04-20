" hook_add {{{
nnoremap :       <Cmd>call CommandlinePre(':')<CR>:
nnoremap ?       <Cmd>call CommandlinePre('/')<CR>?
xnoremap :       <Cmd>call CommandlinePre(':')<CR>:

function! CommandlinePre(mode) abort
  " Overwrite sources
  let b:prev_buffer_config = ddc#custom#get_buffer()

  if a:mode ==# ':'
    call ddc#custom#patch_buffer('sourceOptions', #{
          \   _: #{
          \     keywordPattern: '[0-9a-zA-Z_:#-]*',
          \   },
          \ })
  endif

  autocmd User DDCCmdlineLeave ++once call CommandlinePost()

  call ddc#enable_cmdline_completion()
endfunction
function! CommandlinePost() abort
  " Restore config
  if 'b:prev_buffer_config'->exists()
    call ddc#custom#set_buffer(b:prev_buffer_config)
    unlet b:prev_buffer_config
  endif
endfunction

" }}}

" hook_source {{{
call ddc#custom#patch_global(#{
      \   ui: 'pum',
      \   sources: [ 'around', 'file', 'vsnip', 'lsp' ],
      \   autoCompleteEvents: [
      \       'InsertEnter','TextChangedI','TextChangedP','CmdlineEnter','CmdlineChanged','TextChangedT'
      \   ],
      \   cmdlineSources: {
      \     ':': ['cmdline', 'cmdline-history', 'around'],
      \     '@': ['input', 'cmdline-history', 'file', 'around'],
      \     '>': ['input', 'cmdline-history', 'file', 'around'],
      \     '/': ['around', 'line'],
      \     '?': ['around', 'line'],
      \     '-': ['around', 'line'],
      \     '=': ['input'],
      \   },
      \   sourceOptions: #{
      \     _: #{
      \       keywordPattern: '[a-zA-Z_]\w*',
      \       ignoreCase: v:true,
      \       matchers: ['matcher_head', 'matcher_length'],
      \       sorters: ['sorter_rank'],
      \       converters: ["converter_remove_overlap"],
      \       timeout: 1000,
      \     },
      \     around: #{
      \       mark: 'A',
      \     },
      \     buffer: #{
      \       mark: 'B',
      \     },
      \     cmdline: #{
      \       mark: 'cmdline',
      \       forceCompletionPattern: '\S/\S*|\.\w*',
      \     },
      \     input: #{
      \       mark: 'input',
      \       forceCompletionPattern: '\S/\S*',
      \       isVolatile: v:true,
      \     },
      \     line: #{
      \       mark: 'line',
      \     },
      \     lsp: #{
      \       mark: 'LSP',
      \       dup: 'force',
      \       forceCompletionPattern: '\.\w*|:\w*|->\w*',
      \       minAutoCompleteLength: 1,
      \       sorters: ['sorter_lsp-kind'],
      \     },
      \     file: #{
      \       mark: 'F',
      \       isVolatile: v:true,
      \       minAutoCompleteLength: 1000,
      \       forceCompletionPattern: '\S/\S*',
      \     },
      \     vsnip: #{
      \       mark: 'vsnip',
      \       minAutoCompleteLength: 1,
      \     },
      \     cmdline-history: #{
      \       mark: 'history',
      \       sorters: [],
      \	  },
      \   },
      \   sourceParams: #{
      \     buffer: #{
      \       requireSameFiletype: v:false,
      \       limitBytes: 50000,
      \       fromAltBuf: v:true,
      \       forceCollect: v:true,
      \     },
      \     file: #{
      \       filenameChars: '[:keyword:].',
      \     },
      \     lsp: #{
      \       enableDisplayDetail: v:true,
      \     },
      \   }
      \})

call ddc#custom#patch_global('sourceParams', #{
      \   lsp: #{
      \       snippetEngine: denops#callback#register({
      \           body -> vsnip#anonymous(body)
      \       }),
      \       lspEngine: 'vim-lsp',
      \       enableResolveItem: v:true,
      \       enableAdditionalTextEdit: v:true,
      \       confirmBehavior: 'replace',
      \   }
      \})
" call ddc#custom#patch_filetype(
" 	\ ['c', 'cpp', 'dockerfile', 'go', 'python', 'yaml', 'typescript', 'javascript', 'html', 'lua'], 'sources',
" 	\ ['vsnip', 'lsp', 'around', 'buffer']
" 	\ )

" For insert mode completion
inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1, 'empty')<CR>
inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-o>   <Cmd>call pum#map#confirm_word()<CR>
inoremap <Home>  <Cmd>call pum#map#insert_relative(-9999, 'ignore')<CR>
inoremap <End>   <Cmd>call pum#map#insert_relative(+9999, 'ignore')<CR>
inoremap <C-g>   <Cmd>call pum#set_option(#{
      \   preview: !pum#_options().preview,
      \ })<CR>
inoremap <expr> <C-e> pum#visible()
      \ ? '<Cmd>call pum#map#cancel()<CR>'
      \ : '<End>'
" inoremap <expr> <C-l>  ddc#map#manual_complete()

" For command line mode completion
cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
cnoremap <C-o>   <Cmd>call pum#map#confirm()<CR>
cnoremap <C-q>   <Cmd>call pum#map#select_relative(+1)<CR>
cnoremap <C-z>   <Cmd>call pum#map#select_relative(-1)<CR>
cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>

cnoremap <expr> <Tab>
      \ wildmenumode() ? &wildcharm->nr2char() :
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ ddc#map#manual_complete()
cnoremap <expr> <C-t>       ddc#map#insert_item(0)
cnoremap <expr> <C-e> pum#visible()
      \ ? '<Cmd>call pum#map#cancel()<CR>'
      \ : '<End>'

" Enable terminal completion
call ddc#enable_terminal_completion()

call ddc#enable()
" }}}


" hook_post_update {{{
call ddc#set_static_import_path()
" }}}
