
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
let g:terminal_ansi_colors = [
    \ '#1C1C1C',
    \ '#AF5F5F',
    \ '#5F875F',
    \ '#87875F',
    \ '#5F87AF',
    \ '#5F5F87',
    \ '#5F8787',
    \ '#6C6C6C',
    \ '#444444',
    \ '#FF8700',
    \ '#87AF87',
    \ '#FFFFAF',
    \ '#8FAFD7',
    \ '#8787AF',
    \ '#5FAFAF',
    \ '#FFFFFF',
    \ ]

highlight Terminal guibg='#282828'
highlight Terminal guifg='#ebdbb2'

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
