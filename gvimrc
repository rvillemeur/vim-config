
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

set termguicolors
" source: https://en.wikipedia.org/wiki/Solarized#Colors
let g:terminal_ansi_colors = [
     \ '#1C1C1C',
     \ '#262626',
     \ '#4E4E4E',
     \ '#585858',
     \ '#808080',
     \ '#8A8A8A',
     \ '#D7D7D7',
     \ '#ffffD7',
     \ '#AF8700',
     \ '#D75F00',
     \ '#D70000',
     \ '#AF005F',
     \ '#5F5FAF',
     \ '#0087FF',
     \ '#00AFAF',
     \ '#5F8700']

"highlight Terminal guibg='#282828'
"highlight Terminal guifg='#ebdbb2'

"define font
"set guifont=Consolas:h12:cANSI
set guifont=CaskaydiaMono\ Nerd\ Font\ Mono\ 16

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
