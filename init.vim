set modeline
"Restrict what non-default .vimrc can do
set exrc
set secure

set nocompatible
filetype off

filetype plugin indent on
syntax enable

runtime my_init.lua

" sets {{{
set hidden
set grepprg=grep\ -nH\ $*
set expandtab
set tabstop=8
set autoindent
set shiftwidth=2
set nobackup
set noswapfile
set tw=0
set laststatus=2
"" incremental search
set incsearch
set nofixendofline

"" mouse
set mouse=a

"" Line numbers
set nu

"" wrapping
set nowrap
set linebreak

"" default system clipboard
set clipboard=unnamedplus
" }}}
" Colors {{{
set tgc
"" parens matching color
:hi MatchParen cterm=bold ctermbg=none ctermfg=none
:hi MatchParen term=bold gui=bold guifg=NONE guibg=NONE
colo koehler
" }}}


" Pylint settings {{{
let g:pymode_lint_ignore = "E225,E231,W901,W404,W402,E302,W501,W111,W0311,E111"
let g:pymode_lint_on_write = 0
let g:python_recommended_style=0
" }}}

"" vim-latex settings {{{
let g:tex_flavor='latex'
" }}}

" c/c++ indenting {{{
function! GnuIndent()
  " setlocal cinoptions=>2,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
  setlocal cinoptions=>2,n-2,{2,^0,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
  setlocal shiftwidth=2
  setlocal tabstop=8
endfunction

augroup c_cpp_filetype
  au FileType c,cpp call GnuIndent() 
augroup END
" }}}

" folding  {{{
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
autocmd BufReadPost,FileReadPost * normal zR

" let fortran_fold=1
let fortran_do_enddo=1
let fortran_more_precise=1
let fortran_have_tabs=1
let fortran_free_source=1
let fortran_indent_less=1
" }}}

"" ultisnips + ycm {{{
let g:UltiSnipsListSnippets="<c-e>"
let g:UltiSnipsExpandTrigger="<c-l>"
" }}}

"" ycm settings{{{
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_filetype_blacklist = {
      \ 'python' : 1
      \}
" }}}

"" Own keymaps.  {{{
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
" scandinavian kbd specific
noremap § ~
noremap ö g^
noremap ä g$

" k -> gk and j -> gj
noremap k gk
noremap j gj

"" mapleader
let mapleader=","

"" Nerdtree
nnoremap <F10> :NERDTreeToggle<CR>

"" silent write-make for <leader>-k
nnoremap <Leader>k :w<enter>:silent make<CR>\|:redraw!<CR>

"" Toggle VimRoom mode
nnoremap <Leader>vr :VimroomToggle<CR>

"" Vista  {{{
nnoremap <F7> :Vista!!<CR>
let g:vista_default_executive='nvim_lsp'
let g:vista_icon_indent = ["o ", "-> "]
"" }}}

"" Jump around in buffers and tabs
nnoremap <C-left> :bp<CR>
nnoremap <C-right> :bn<CR>
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

"" escape in insert mode
inoremap aö <ESC>

"" grep operator stuff 
nmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
vmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
nmap <leader><leader>g <Plug>GrepOperatorWithFilenamePrompt
vmap <leader><leader>g <Plug>GrepOperatorWithFilenamePrompt
"" own mappings learnt from learn vimscript the hard way {{{
nnoremap <space> za
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
onoremap p i(
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
" }}}

"" Terminal keymaps
tnoremap <Esc> <C-\><C-n>
" }}}

"" Load custom vimrc {{{
"if (getcwd() !~# $HOME."/.vim") 
"  if (getcwd() !~# $HOME."$")
"    if (filereadable("./.vimrc"))
"      source ./.vimrc
"    endif
"  endif
"endif
" }}}

"" nerd commenter stuff {{{
let g:NERDCustomDelimiters={ 'sif': {'left': '!', }, }
" call tcomment#DefineType('sif', '! %s')
" }}}

"" ctrl-space specific {{{
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1

" neovim ctrl-space workaround
let g:CtrlSpaceDefaultMappingKey = "<C-Space> "
" }}}

"" syntastic settings {{{
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "passive_filetypes": ["fortran, python"],}
nnoremap <F8> :SyntasticCheck<CR>
let g:syntastic_python_checkers = ['pylint']
" }}}

"" markdown settings {{{
let g:vim_markdown_math = 1
let maplocalleader=","
let g:tex_conceal=""
" }}}

"" airline settings {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_warning = ''
" }}}

"" Helper stuff for quickfix window {{{
" function to toggle quickfix window
function! QuickFixToggle()
  if g:quickfix_is_open
    cclose 
    let g:quickfix_is_open = 0
  else
    botright cwindow
    let g:quickfix_is_open = 1
  endif
endfunction
let g:quickfix_is_open = 0

" ...and keymap for it
nnoremap <F6> :call QuickFixToggle()<CR>
" }}}

"" Set grep function {{{
let g:gitroot=system('git rev-parse --show-cdup')
if !v:shell_error
set grepprg=git\ grep\ -n\ $*
endif
unlet g:gitroot
" }}}

" filetype vim group {{{ 
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" filetype matlab group {{{
augroup filetype_matlab
  autocmd!

  "Turn         '% p.addParameter('n_rounds', 30); % How many rounds' 
  "in to        '% n_rounds	- How many rounds (30)'
  autocmd FileType matlab vnoremap <leader>md :s/\v\%.+\('(.+)',\s*(.*)\); \% (.*)/% \1\t- \3 (\2)<cr>:noh<cr>
  autocmd FileType matlab compiler mlint
augroup END 
" }}}

" filetype sif group {{{ 
augroup filetype_sif
  autocmd!
  autocmd FileType sif setlocal foldmethod=syntax
augroup END
" }}}

" filetype fortran group {{{ 
augroup filetype_fortran
  autocmd!
  autocmd FileType fortran setlocal foldmethod=expr
  autocmd FileType fortran setlocal cc=132
augroup END
" }}}

" filetype yaml group {{{
augroup filetype_yaml
  autocmd!
  autocmd FileType yaml setlocal foldmethod=expr
augroup END
" }}}

" go indenting {{{
function! GoIndent()
  " setlocal cinoptions=>2,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
  " setlocal cinoptions=>2,n-2,{2,^0,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
  " setlocal shiftwidth=2
  setlocal tabstop=3
endfunction

augroup filetype_go
  au FileType go call GoIndent() 
augroup END
" }}}
"
" gonvim {{{
let g:gonim_draw_statusline = 0
let g:gonvim_draw_tabline = 0
let g:gonvim_draw_lint = 0
let g:gonvim_draw_split = 0
" GuiFont Inconsolate:h12
" GuiLinespace 8
" }}}

""" {{{ skim / fzf
" so ~/.vim/coc-defaults.vim
""" }}}

""" {{{ vim-slime
let g:slime_target = "tmux"
" let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.2"}
""" }}}

""" {{{ vimroom
let g:vimroom_width = 132
""" }}}

""" {{{ julia-vim options
" let g:latex_to_unicode_file_types = '$^'
" let g:latex_to_unicode_file_types_blacklist = '.*'
""" }}}

