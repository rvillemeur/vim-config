-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- {{{ core options
vim.opt.langmenu = "en_US.UTF-8" -- vim sera toujours en anglais
vim.opt.encoding = "utf-8" -- encodage par défaut
vim.opt.spelllang = "fr" -- langue par défaut pour correction orthographique
vim.opt.autowrite = true -- autowrite when switching to another buffer
vim.opt.sessionoptions = "blank,buffers,tabpages"
vim.opt.fileformats = "unix,dos,mac" -- use Unix as the standard file type

-- leader remapping - must be done before Lazy is loaded
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- disable netrw at the very start of your init.lua (required by nvim-tree.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour for nvim-tree
vim.opt.termguicolors = true
-- background colors for active vs inactive windows (see WindowManagement augroup below)
-- vim.cmd('highlight NormalNC ctermbg=237')
-- vim.cmd('highlight User1 guifg=#eea040')
-- Background colors for active vs inactive window - in conjunction with augroup
--highlight ActiveWindow guibg=#17252C
--highlight InactiveWindow guibg=#0D1B22

vim.opt.autochdir = true -- change window cwd par rapport au fichier

vim.opt.colorcolumn = "+1" -- met en évidence la colonne après 'textwidth'
vim.cmd("highlight ColorColumn ctermbg=red guibg=#600000")

--vim.opt.markdown_folding = 1 -- markdown folding

vim.opt.mouse = "c" -- disable mouse
vim.opt.showcmd = true -- show (partial) command in the last line of the screen

vim.cmd("syntax on")
vim.cmd("syntax sync fromstart") -- see :help :syn-sync

vim.opt.number = true -- ajout de la numérotation des lignes
vim.opt.startofline = true -- garde la position du curseur entre buffer

-- automatic wrap de texte
vim.opt.wrap = true
vim.opt.sidescroll = 5
vim.opt.textwidth = 80 -- largeur maxi du texte inséré
vim.opt.formatoptions:append("n") -- recognize numbered list

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.visualbell = true -- pas de beep intempestif, visual bell

--vim.opt.lazyredraw = true -- redraw only when we need to

-- affiche les tabulations et les espaces de fin de ligne
vim.opt.list = true
vim.opt.listchars = { tab = ">-", trail = "-", precedes = "<", extends = ">" }

vim.opt.nrformats = "" -- pas de format de nombre pour ctrl-x ctrl-a

-- backspace permet de revenir en arriere tout le temps
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.whichwrap:append("<,>,[,]")

vim.opt.foldenable = true
vim.opt.fillchars:append({ fold = "=", foldopen = "▼", foldclose = "▶", foldsep = "┃" })
vim.opt.foldlevel = 4
vim.opt.foldcolumn = "5"
--vim.opt.foldmethod=expr
--vim.opt.foldexpr=v:lua.vim.treesitter.foldexpr()

-- change character for split window
vim.cmd("highlight VertSplit cterm=NONE")
vim.opt.fillchars:append({ vert = "┃" })

-- traitement des espaces et des tabulations
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = true -- be smart when using tabs

vim.opt.writebackup = false -- pas de fichier de swap
vim.opt.swapfile = false
vim.opt.backup = false -- pas de backup

vim.opt.history = 500 -- how many lines of history Vim remembers
vim.opt.clipboard = "unnamedplus"

-- search down into subfolders, tab-completion for all file-related tasks
vim.opt.path:append("**")

vim.opt.autoread = true -- auto read when a file is changed from outside
vim.opt.wildmenu = true -- display all matching files when we tab complete
vim.opt.ruler = true -- always show ruler
vim.opt.cmdheight = 1 -- height of the command bar

vim.opt.ignorecase = true -- ignore la casse de caractère
vim.opt.smartcase = true -- suit la casse du mot recherché
vim.opt.gdefault = true -- applique le flag de substitution g par défaut
vim.opt.incsearch = true -- met en valeur le motif de recherche
vim.opt.showmatch = true
vim.opt.hlsearch = true

vim.opt.magic = true -- for regular expressions, turn magic on
vim.opt.regexpengine = 0 -- set regular expression engine automatically
vim.opt.matchtime = 2 -- how many tenths of a second to blink when matching bracket

-- }}}
-- vim: set foldmethod=marker foldmarker={{{,}}} foldlevel=0 :
