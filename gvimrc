
"démarre en plein écran
set lines=999
set columns=9999

" mode de couleur
set rop=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1
"solarized set up
let g:solarized_contrast="high"
set background=light
let g:solarized_visibility="high"
let g:solarized_menu=0
colorscheme solarized

"define font
set guifont=Consolas:h12:cANSI

" Make command line two lines high
set ch=2		

"faire :help guioptions pour plus de détails
set guioptions=		"on réinitialise le menu
set guioptions+=e   "add tab page
set guioptions+=m   "show menu bar
set guioptions-=l   "no left scrollbar
set guioptions-=L   "no left scrollbar
set guioptions-=r   "no right scrollbar
set guioptions-=R   "no right scrollbar

"activation par défaut au démarrage de la gestion de la souris
set mouse+=v
set nopaste

" Switch on syntax highlighting if it wasn't on yet.
if !exists("syntax_on")
	syntax on
endif