"démarre en plein écran
set lines=999
set columns=9999

" mode de couleur
set rop=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1
"solarized set up
let g:solarized_contrast="high"
"let g:solarized_termcolors= 16 | 256
"let g:solarized_termtrans = 0 | 1
"let g:solarized_degrade = 0 | 1
"let g:solarized_bold = 1 | 0
"let g:solarized_underline = 1 | 0
"let g:solarized_italic = 1 | 0
"let g:solarized_contrast = "normal"| "high" or "low"
"let g:solarized_visibility= "normal"| "high" or "low"
"set background=light
let g:solarized_visibility="high"
let g:solarized_menu=0
colorscheme solarized

set termguicolors
" source: https://en.wikipedia.org/wiki/Solarized#Colors
" and https://github.com/sgerrand/xfce4-terminal-colors-solarized/blob/master/light/terminalrc
" color defined in this order: base2, red, green, yellow, blue, magenta,
" cyan, base02, base3, orange, base1, base0, base00, violet, base01, base03
let g:terminal_ansi_colors = [ '#eee8d5', '#dc322f', '#859900', '#b58900', '#268bd2', '#d33682', '#2aa198', '#073642', '#fdf6e3', '#cb4b16', '#93a1a1', '#839496', '#657b83', '#6c71c4', '#586e75', '#002b36' ]

highlight Terminal guibg='#FDF6E3'
highlight Terminal guifg='#657B83'

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
