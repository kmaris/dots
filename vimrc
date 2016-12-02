set nocompatible
filetype off

if isdirectory("/Library/TeX/texbin")
  let $PATH=$PATH.":/Library/TeX/texbin"
endif

source ~/.vim/bundles/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('bundles/{}')

syntax on
syntax enable
filetype plugin indent on
set modeline
set expandtab
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
set relativenumber
set nofoldenable
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
set nowrap
set autoread
set textwidth=79
set formatoptions=qrn1
set pastetoggle=<F2>
set list
set listchars=tab:→\ ,trail:·
set backup
set backupdir=$HOME/.vim/backup,/tmp/backups,/var/tmp/backups,.
set dir=~/.vim/swap,~/local/tmp,/var/tmp,.
set tags=./tags;./TAGS;$HOME
if exists('+colorcolumn')
  set colorcolumn=80
endif
if exists('+undofile')
  set undofile
  set undodir=$HOME/.vim/undo,/tmp/undos,/var/tmp/undos,.
endif

let mapleader = ","
nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :noh<cr>
nnoremap ; :
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>
nnoremap <leader>q gqip
nnoremap <leader>v V`]
nnoremap <leader>R :RainbowParenthesesToggle<cr>
nnoremap <leader>B :buffers<cr>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" COLORS@@#@!!!!
set t_Co=256
set background=dark
colorscheme molokai

" Tabbing defaults
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
" Custom tabbing for filetypes
autocmd FileType make,Makefile,mk setlocal tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
autocmd FileType python,py,wsgi setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType yaml,yml setlocal nosmartindent noautoindent
autocmd FileType yaml,yml set ft=ansible
autocmd BufNewFile,BufRead SCons* set filetype=python
" Open NERDTree on startup if no files specified
"autocmd vimenter * if !argc() | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let NERDTreeIgnore=['__pycache__[[dir]]','\.pyc$[[file]]','\.class$[[file]]','\.[oa]$[[file]]','\.orig$']
let g:vim_markdown_folding_disabled=1
let g:solarized_termcolors=256
let g:airline_powerline_fonts=1
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_winsize=28
let g:go_fmt_command = "goimports"
"let g:go_fmt_autosave = 0 " Disable formats on save
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_autoclose_preview_window_after_insertion = 1
let g:neocomplete#enable_at_startup = 1
let g:SexyScroller_DetectPendingKeys = 1
let g:SexyScroller_EasingStyle = 2
let g:SexyScroller_CursorTime = 5
let g:vimtex_latexmk_options = "-pdf -verbose -file-line-error -synctex=1 -interaction=nonstopmode -latex=xelatex"
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
" This adds a callback hook that updates Skim after compilation
let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
function! UpdateSkim(status)
  if !a:status | return | endif

  let l:out = b:vimtex.out()
  let l:tex = expand('%:p')
  let l:cmd = [g:vimtex_view_general_viewer, '-r']
  if !empty(system('pgrep Skim'))
    call extend(l:cmd, ['-g'])
  endif
  if has('nvim')
    call jobstart(l:cmd + [line('.'), l:out, l:tex])
  elseif has('job')
    call job_start(l:cmd + [line('.'), l:out, l:tex])
  else
    call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
  endif
endfunction

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|a|o)$',
  \ }
