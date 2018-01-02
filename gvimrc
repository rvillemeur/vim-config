
" démarre en plein écran
" set lines=999
" set columns=9999

" mode de couleur
"colorscheme desert
let g:solarized_menu=0
set background=light
colorscheme solarized

"arrière plan
"hi Normal guibg=LightYellow
"hi Normal guibg=#FFFF7E


" Police de caractère pour Gvim qui supporte le symbole euro
" if &term == "builtin_gui"
    "set guifont=courier_new:h10:cANSI
"else 
"    set guifont=bitstream\ vera\ sans\ mono\ 9 
"    set guifont=courier\ new\ 10 
    set guifont=DejaVu\ Sans\ Mono\ 12
"endif

"on n'affiche pas la toolbar - faire :help guioptions pour plus de détails
set guioptions=
set guioptions+=e   "add tab page
set guioptions-=L
set guioptions+=m   "no menu bar
set guioptions-=l   "no left scrollbar
set guioptions-=L   "no left scrollbar
set guioptions-=r   "no right scrollbar
set guioptions-=R   "no right scrollbar

"activation par défaut au démarrage de la gestion de la souris
set mouse+=v
set nopaste
