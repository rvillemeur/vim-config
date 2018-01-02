" Ne pas assurer la compatibilité avec l'ancien Vi
set nocompatible
"vim sera toujours en anglais
set langmenu=en_US.UTF-8
"language US

" {{{ windows set-up 
"if has("windows")
"    set shell=powershell
"    set shellcmdflag=-command
"endif
" }}} end windows set-up
" {{{ VUNDLE set-up
filetype off                   " required!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin(~/.vim/bundle)

" let Vundle manage Vundle - required! 
Plugin 'VundleVim/Vundle.vim'

" My Bundles here:
" vim feature
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-fugitive'
Plugin 'gregsexton/gitv'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-abolish'
Plugin 'kien/ctrlp.vim'
Plugin 'kshenoy/vim-signature'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'christoomey/vim-tmux-navigator'
plugin 'vimplugin/project.vim'
"nodejs - web development
Plugin 'tpope/vim-surround'
Plugin 'digitaltoad/vim-jade'
Plugin 'sukima/xmledit'
Plugin 'ternjs/tern_for_vim'
Plugin 'othree/html5.vim'
Plugin 'vim-scripts/closetag.vim'
" Pillar file handling
Plugin 'cdlm/vim-pillar'


"automatic loading of plugin and indent rule, bases on file type
filetype plugin on
filetype indent on
" }}} end VUNDLE set-up
" {{{ definition des options de vim
" langue des documents
set spelllang=fr_FR

" controle mieux le copier/coller du systeme
set paste

" change window cwd par rapport au fichier
set autochdir

" ajout d'une ligne colorée pour surligner la ligne en cours
" set cursorline
" Met en évidence la colonne après  'textwidth'
set colorcolumn=+1

set showcmd
" Active la coloration syntaxique
syntax on
"see :help :syn-sync for this
syntax sync fromstart


"affiche par défaut les tabs de fenetre
"set showtabline=2

" ajout de la numérotation des lignes
set number

" garde la position du curseur entre buffer
set startofline

"automatic wrap de texte
set wrap
"set sidescroll=5
" Largeur maxi du texte inséré
"set textwidth=80
set wrapmargin=80
set lbr
set formatoptions=c "autowrap comment
set formatoptions+=t "autowrap text enable
set formatoptions+=q "allow formatting of comments
set formatoptions+=w 

" Affiche les commandes dans la barre de status
set showcmd
" Affiche la paire de parenthèses
set showmatch
" Pas de beep intempestif, visual bell
set vb

" visual autocomplete for command menu
set wildmenu
" redraw only when we need to.
set lazyredraw

" affiche les tabulation et les espaces de fin de ligne
set list
set listchars=tab:>-,trail:- ",eol:¬
set listchars+=precedes:<,extends:>

" pas de format de nombre pour ctrl-x ctrl-a
set nrformats=

"backspace permet de revenir en arriere tout le temps
set backspace=indent,eol,start

" Activation de la gestion des ouvertures/fermetures de folding
set foldenable
" Affichage d'une ligne de '=' sur les pliages
set fillchars=fold:=
" Le découpage des folders se base sur l'indentation
"set foldmethod=indent
" 4 niveaux d'indentation par défaut pour les folders
set foldlevel=4
set foldcolumn=3

" encodage par défaut
set encoding=utf-8
" traitement des espaces et des tabulations:
set tabstop=4
"set softtabstop=4
set expandtab
" indique le nombre d'espace utilisé lors de l'indentation automatique.
set shiftwidth=4

" pas de backup
set nobackup

set ignorecase  " ignore la casse de caractére
set smartcase   " Suit la casse du mot recherché
set gdefault    " Applique le flag de substitution g par defaut
set incsearch   " met en valeur le motif de recherche
set showmatch   " met en valeur le motif de recherche
set hlsearch    " met en valeur le motif de recherche

" airline configuration
let g:airline_powerline_fonts=1

" }}}
" {{{ Définition de la barre de status
" Affiche une barre de status en bas de l'écran
set laststatus=2
" Contenu de la barre de status
set statusline=%F                       "full path to the file to the buffer
set statusline+=%m                      "Mofified text flag
set statusline+=%r                      "Readonly text flag
set statusline+=%h                      "Help buffer flog
set statusline+=%w\                     "Preview window flag
"set statusline+=[WRAP=%{&formatoptions}]\ 
set statusline+=[FORMAT=%{&fileformat}] "file format
set statusline+=[ENCODING=%{&encoding}] "file encoding
set statusline+=[TYPE=%Y]\              "file type
set statusline+=[REG=%{v:register}]     "register used
"set statusline+=[ASCII=\%03.3b]\       "ascii code
"set statusline+=[HEX=\%02.2B]\         "hex code
set statusline+=%=[POS=%04l%*/%04L]     "Number of line in buffer
set statusline+=[%02p%%]                "percentage through the file
set statusline+=[COL=%03v]              "position in buffer

"use to highlight the statusline, you can define from User1 to User9 color
"for example, to use User 1, you include %1* in front of the value
"like set statusline +=%1*%4v\ %*
"hi User1 guifg=#eea040 "guibg=#222222
" }}}
" {{{ custom functions
"fonction de nettoyage d'un fichier issu du monde dos:
" - remplacement des tabulations par des espaces
" - suppression des caractères ^M en fin de ligne
" le ^M est obtenu par la combinaison de touche Ctrl-V + return
function! CleanDosCode()
  set fileformat=unix
  %retab
  %s///g
  call s:DisplayStatus('fichier dos nettoyé')
endfunction

"fonction d'affichage d'un message en inverse video
function! s:DisplayStatus(msg)
  echohl Todo
  echo a:msg
  echohl None
endfunction

" Comparaison des modifications en cours par rapport à la dernière version enregistrée
function! DiffWithFileFromDisk()
  let filename = expand('%')
  let diffname = filename . '.fileFromBuffer'
  exec 'saveas! ' . diffname
  diffthis
  vsplit
  exec 'edit ' .filename
  diffthis
endfunction

function! SuperCleverTab()
  "check if at beginning of line or after a space
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
  else
      " do we have omni completion available
      if &omnifunc != ''
          "use omni-completion 1. priority
          return "\<C-X>\<C-O>"
      elseif &dictionary != ''
          " no omni completion, try dictionary completion
          return "\<C-x>\<C-K>"
     else
          "use omni completion or dictionary completion 
          "use known-word completion
           return "\<C-x>\<C-n>"
     endif
  endif
endfunction
" }}}
" {{{ Définition des mappings
" type de Mapping
" i[nsert]nore[cursion]map
" n[ormal]nore[cursion]map
" v[isual]nore[cursion]map
" map
let mapleader = ","
let maplocalleader = "\\"

" évite d'invoquer Ex 
nnoremap Q <nop>

" Active NerdTree
map <F2> :NERDTreeToggle<CR>

"définition des touches de navigation dans l'aide VIM
" activer un lien en appuyant sur Return
nnoremap <Return> <C-]>
" Revenir à la page précédente avec backspace
nnoremap <BS> <C-T>

" recharger le fichier $HOME/.vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" édite le fichier $HOME/.vimrc
noremap <leader>ev :vsplit $MYVIMRC<cr>

" Déplacement dans le fichier
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk
nnoremap gk k
nnoremap gj j
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" mapping pour faciliter la recherche
nnoremap / /\v
vnoremap / /\v
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" supprime la mise en valeur de la recherche
nnoremap <leader><space> :nohlsearch<cr>
" remappe la recherche de parenthèse par % vers tab
" nnoremap <tab> %
" vnoremap <tab> %

" associe F1 à ESC, évite les erreurs
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" se déplacer plus facilement dans les fenêtres
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>w <C-w>v<C-w>l

" formatage de texte
" retire les blancs en bout de ligne
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" bind function to the tab key
"inoremap <C-Tab>=SuperCleverTab()

" }}}
" {{{ Autocmd format
augroup filetype_html
autocmd!
autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
"fold tag in html
autocmd FileType html nnoremap <leader>ft Vatzf
"Mapping pour tapper du texte français sur un clavier EN-US
autocmd FileType html inoremap `a à
autocmd FileType html inoremap `A À
autocmd FileType html inoremap ^a â
autocmd FileType html inoremap ^A Â
autocmd FileType html inoremap 'e é
autocmd FileType html inoremap 'E É
autocmd FileType html inoremap ^e ê
autocmd FileType html inoremap ^E Ê
autocmd FileType html inoremap `e è
autocmd FileType html inoremap `E È
autocmd FileType html inoremap ^i î
autocmd FileType html inoremap "o ö
autocmd FileType html inoremap `u ù
autocmd FileType html inoremap `U Ù
autocmd FileType html inoremap 'c ç
autocmd FileType html inoremap 'C Ç
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
augroup END

augroup filetype_css
autocmd!
" trie les tags css
autocmd FileType css nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
augroup END

augroup filetype_python
autocmd!
" active l'auto-complétion pour certain fichiers, à lancer avec CTRL-X O
"python command - should be in another file.
"$ ctags -R -f ~/.vim/tags/python.ctags /usr/lib/python2.5/
" :autocmd BufWritePost * call system("ctags -R")
"set tags+=$HOME/.vim/tags/python.ctags
"autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
autocmd FileType python match Excess /\%80v.%/
augroup END

augroup filetype_php
" permet de rechercher un fichier tags en remontant du repertoire courant a la 
" racine, jusqu'a ce qu'il soit trouve.
set tags=tags;/
augroup END

augroup filetype_javascript
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
set suffixesadd+=.js
augroup END

"git syntax highlight
autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit

"glsl syntax highlight
augroup filetype_glsl
autocmd BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl 
augroup END
" }}}
" {{{ python mode configuration
" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)

" evite l'utilisation de rope, utilisont plutot python-jedi pour la completion
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0


" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" }}}

" see help modeline for explanation on the line below
" vim: set foldmethod=marker foldmarker={{{,}}} foldlevel=0 :
