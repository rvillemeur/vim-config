""note pour windows
"ajouter la variable d'environnement MYVIMRC dans le profil utilisateur pour
"choisir le fichier de démarrage spécifique.
"MYVIMRC=%USERPROFILE%\Documents\perso\vim\_vimrc

" Ne pas assurer la compatibilité avec l'ancien Vi
set nocompatible

"vim sera toujours en anglais
set langmenu=en_US.UTF-8
"language US
" encodage par défaut
set encoding=utf-8


" {{{ windows set-up 
"if has("windows")
"    set shell=powershell
"    set shellcmdflag=-command
"endif
" }}} end windows set-up
" {{{ vim-plug set-up
" source: https://github.com/junegunn/vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
" My Bundles here:
" vim feature
Plug 'altercation/vim-colors-solarized'
Plug 'chrisbra/unicode.vim'     "deal with unicode caracters
Plug 'vim-airline/vim-airline'  "powerline like style form vim status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'       "git plugin for vim
Plug 'scrooloose/nerdtree'      "file system explorer
Plug 'wuelnerdotexe/nerdterm'   "toggle terminal
Plug 'ctrlpvim/ctrlp.vim'       "Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plug 'kshenoy/vim-signature'    "place, toggle and display marks.
Plug 'dpelle/vim-languagetool'  "integrates the LanguageTool grammar checker
Plug 'godlygeek/tabular'       "improve tabular alignement of data
Plug 'preservim/vim-markdown'   "Syntax highlighting, matching rules and mappings
Plug 'tmux-plugins/vim-tmux'    "Vim plugin for editing .tmux.conf
Plug 'mhinz/vim-startify'       "start screen for Vim
"Plug 'gcmt/taboo.vim'          "help renaming vim tabs
Plug 'jlanzarotta/bufexplorer'  "buffer explorer
"if !has('win32') 
	Plug 'christoomey/vim-tmux-navigator'
"endif
Plug 'ryanoasis/vim-devicons'
" All of your Plugins must be added before the following line
call plug#end()            " required

"automatic loading of plugin and indent rule, bases on file type
filetype plugin on
filetype indent on

" }}} end VUNDLE set-up
" {{{ definition des options de vim
let g:airline_left_sep="\uE0B0"
let g:airline_right_sep="\uE0B2"
let g:airline_theme='solarized'
let g:airline_solarized_bg='base_16'
let airline_solarized_enable_command_color = 1

" language tool configuration and document language
let g:languagetool_lang='en-US'
"set spelllang=fr_FR

" controle mieux le copier/coller du systeme
set paste

"change window cwd par rapport au fichier
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
set showtabline=2

" ajout de la numérotation des lignes
set number

" garde la position du curseur entre buffer
set startofline

"automatic wrap de texte
set wrap
"set sidescroll=5
" Largeur maxi du texte inséré
set textwidth=80
"set wrapmargin=80
"set lbr
set formatoptions=c "autowrap comment
set formatoptions+=t "autowrap text enable
set formatoptions+=q "allow formatting of comments
set formatoptions+=a "autoformatting of paragraph"
set formatoptions+=n "recognize numbered list"

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

" conceal level - this allow for example, markdown to appear formatted without displaying formating markup (e.g. **bold** will be bold)
set conceallevel=2

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  "open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

"clipboard option
set clipboard=unnamedplus

" pas de backup
set nobackup

" search down into subfolders
" provide tab-completion for all file-related tasks
set path+=**

" display all matching files when we tab complete
set wildmenu

set ignorecase  " ignore la casse de caractére
set smartcase   " Suit la casse du mot recherché
set gdefault    " Applique le flag de substitution g par defaut
set incsearch   " met en valeur le motif de recherche
set showmatch   " met en valeur le motif de recherche
set hlsearch    " met en valeur le motif de recherche

" configure the 'make' command to run rspec
" set makeprg=bundle\ exec\ rspec\ -f\ QuickFixFormatter

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

function! SaveSession()
    if has('win32')
        execute 'mksession! c:\devzone\vim\session.vim'
    else
        execute 'call mkdir(%:p:h/.vim)'
        execute 'mksession! %:p:h/.vim/session.vim'
    endif
endfunction

function! RestoreSession()
    if has('win32')
        execute 'source c:\devzone\vim\session.vim'
    else
        execute 'so %:p:h/.vim/session.vim'
    endif
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'sbuffer ' . l
            endif
        endfor
    endif
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

" Active NerdTerm
nmap <leader>tt <Plug>(NERDTermToggle)
tmap <leader>tt <Plug>(NERDTermToggle)

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
" terminal mode
"tnoremap <C-h> <c-\><c-n><c-w>h
tnoremap <C-h> <c-w><c-w>h
tnoremap <C-j> <c-w><c-w>j
tnoremap <C-k> <c-w><c-w>k
tnoremap <C-l> <c-w><c-w>l
" Insert mode:
inoremap <C-h> <Esc><c-w>h
inoremap <C-j> <Esc><c-w>j
inoremap <C-k> <Esc><c-w>k
inoremap <C-l> <Esc><c-w>l
" Visual mode:
vnoremap <C-h> <Esc><c-w>h
vnoremap <C-j> <Esc><c-w>j
vnoremap <C-k> <Esc><c-w>k
vnoremap <C-l> <Esc><c-w>l
" Normal mode:
nnoremap <C-h> <c-w>h
nnoremap <C-j> <c-w>j
nnoremap <C-k> <c-w>k
nnoremap <C-l> <c-w>l
nnoremap <leader>w <C-w>v<C-w>l

" terminal escape
tnoremap <Esc> <C-\><C-n>
tnoremap <M-[> <Esc>
tnoremap <C-v><Esc> <Esc>

" formatage de texte
" retire les blancs en bout de ligne
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" bind function to the tab key
"inoremap <C-Tab>=SuperCleverTab()

" set the 'cpoptions' to its Vim default
if 1	" only do this when compiled with expression evaluation
  let s:save_cpo = &cpoptions
endif
set cpo&vim

" Set options and add mapping such that Vim behaves a lot like MS-Windows
" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" backspace in Visual mode deletes selection
vnoremap <BS> d

if has("clipboard")
    " CTRL-X and SHIFT-Del are Cut
    vnoremap <C-X> "+x
    vnoremap <S-Del> "+x

    " CTRL-C and CTRL-Insert are Copy
    vnoremap <C-C> "+y
    vnoremap <C-Insert> "+y

    " CTRL-V and SHIFT-Insert are Paste
    map <C-V>		"+gP
    map <S-Insert>		"+gP

    cmap <C-V>		<C-R>+
    cmap <S-Insert>		<C-R>+
endif

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.
" Use CTRL-G u to have CTRL-Z only undo the paste.

if 1
    exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
    exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']
endif

imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>		<C-V>

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

" CTRL-Z is Undo; not in cmdline though
" noremap <C-Z> u
" inoremap <C-Z> <C-O>u

" CTRL-Y is Redo (although not repeat); not in cmdline though
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>

" Alt-Space is System menu
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" CTRL-Tab is Next window
noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
onoremap <C-Tab> <C-C><C-W>w

" CTRL-F4 is Close window
noremap <C-F4> <C-W>c
inoremap <C-F4> <C-O><C-W>c
cnoremap <C-F4> <C-C><C-W>c
onoremap <C-F4> <C-C><C-W>c

"if has("gui")
"  " CTRL-F is the search dialog
"  noremap  <expr> <C-F> has("gui_running") ? ":promptfind\<CR>" : "/"
"  inoremap <expr> <C-F> has("gui_running") ? "\<C-\>\<C-O>:promptfind\<CR>" : "\<C-\>\<C-O>/"
"  cnoremap <expr> <C-F> has("gui_running") ? "\<C-\>\<C-C>:promptfind\<CR>" : "\<C-\>\<C-O>/"
"
"  " CTRL-H is the replace dialog,
"  " but in console, it might be backspace, so don't map it there
"  nnoremap <expr> <C-H> has("gui_running") ? ":promptrepl\<CR>" : "\<C-H>"
"  inoremap <expr> <C-H> has("gui_running") ? "\<C-\>\<C-O>:promptrepl\<CR>" : "\<C-H>"
"  cnoremap <expr> <C-H> has("gui_running") ? "\<C-\>\<C-C>:promptrepl\<CR>" : "\<C-H>"
"endif

" read an empty HTML template and move cursor to title
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a

" restore 'cpoptions'
set cpo&
if 1
  let &cpoptions = s:save_cpo
  unlet s:save_cpo
endif

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

"augroup filetype_css
"autocmd!
" trie les tags css
"autocmd FileType css nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"augroup END

"augroup filetype_python
"autocmd!
" active l'auto-complétion pour certain fichiers, à lancer avec CTRL-X O
"python command - should be in another file.
"$ ctags -R -f ~/.vim/tags/python.ctags /usr/lib/python2.5/
" :autocmd BufWritePost * call system("ctags -R")
"set tags+=$HOME/.vim/tags/python.ctags
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
"autocmd FileType python match Excess /\%80v.%/
"augroup END

"augroup filetype_php
" permet de rechercher un fichier tags en remontant du repertoire courant a la 
" racine, jusqu'a ce qu'il soit trouve.
"set tags=tags;/
"augroup END

"augroup filetype_javascript
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"set suffixesadd+=.js
"augroup END

"git syntax highlight
autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit

"glsl syntax highlight
augroup filetype_glsl
autocmd BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl 
augroup END
"autosave session
"autocmd VimLeave * call SaveSession()
"autocmd VimEnter * call RestoreSession()
" }}}
"{{{ groff utilities
au BufWritePost,BufFilePost *.ms !groff -ms % -Tpdf > %:r.pdf
au BufWritePost,BufFilePost *.me !tbl % | groff -me -Tpdf > %:r.pdf
au BufWritePost,BufFilePost *.pic !groff -p % -Tpdf > %:r.pdf

"}}}
" see help modeline for explanation on the line below
" vim: set foldmethod=marker foldmarker={{{,}}} foldlevel=0 :
