set number
set ignorecase
set t_ut=

syntax enable

if has('gui_running')
  set background=light
else
  set background=dark
endif

if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

let g:solarized_termcolors=256
let g:NERDTreeWinPos = "left"

colorscheme solarized
"colorscheme railscasts

" CtrlP mapping
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_map = '<c-o>'
let g:ctrlp_cmd = 'CtrlPMixed'

set shiftwidth=2
let g:gist_use_password_in_gitconfig = 1
autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
if has("autocmd")
  autocmd FileType ruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby let g:rubycomplete_buffer_loading=1
  autocmd FileType ruby let g:rubycomplete_classes_in_global=1
endif

"highlight ExtraWhitespace ctermbg=red guibg=red
"match ExtraWhitespace /\s\+$/

" Display extra whitespace
set list listchars=tab:»·,trail:·

" open NERDTree when there's no argument
function! StartUp()
  if 0 == argc()
    NERDTree
  end
endfunction

autocmd VimEnter * call StartUp() 
autocmd VimEnter * wincmd p

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimdiff quick commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <D-1> :diffget LOCAL<CR>
map <D-2> :diffget REMOTE<CR>
map <D-3> :diffget BASE<CR>

au BufRead,BufNewFile *.hamlc set ft=haml

let g:ackprg = 'ag --vimgrep'

let g:jsx_ext_required = 0

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap \ :Ag<SPACE>

" Cross-hair
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

augroup CursorColumn
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
  au WinLeave * setlocal nocursorcolumn
augroup END

let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

" vim-rspec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
