-- ============================================================
-- init.lua — Neovim equivalent of _vimrc
-- ============================================================
--
-- WHAT CHANGED FROM THE ORIGINAL VIMRC
--   • Plugin manager: vim-plug -> lazy.nvim (modern Neovim standard)
--   • catppuccin/vim -> catppuccin/nvim — the Neovim-native rewrite
--     of the SAME theme by the SAME project, not a different plugin
--   • scrooloose/nerdtree -> preservim/nerdtree — ownership moved to
--     this org years ago; old URL still redirects but this is the
--     current canonical location
--   • Added prabirshrestha/asyncomplete.vim as an explicit plugin —
--     asyncomplete-lsp.vim is a *source* for this completion engine
--     and cannot function without it. It wasn't in your original
--     Plug list, so either it was pulled in as a transitive dep some
--     other way, or this was a gap. Flagging rather than guessing.
--   • Everything else is the exact same plugin you already use:
--     NERDTree, airline, fugitive, pencil, vim-claude-code, vim-lsp,
--     vim-markdown, ctrlp, goyo/limelight, devicons, all of it.
--
-- WHAT WAS DROPPED (Windows-GUI-only, irrelevant on Fedora/terminal)
--   • The has("windows")/shell=powershell block — was already
--     commented out in your original, so nothing functional lost
--   • The Alt-Space "system menu" mapping (has("gui") simalt block)
--   • The win32 guard around vim-tmux-navigator — always loads now,
--     since you're never on win32
--
-- RECONSTRUCTED
--   CleanDosCode() originally read "%s///g". Your comment above it
--   says it strips trailing ^M (carriage return) characters — that
--   literal control character almost certainly got eaten when the
--   file was saved/uploaded as plain text. Rebuilt below as
--   %s/\r//g to match the documented intent.
--
-- NOT FOUND
--   catppuccin is installed in your original but I don't see an
--   explicit ":colorscheme" command anywhere in the file, so it may
--   never have been activated. Left as a commented-out line below —
--   uncomment if you want it live.
--
-- ONE DECISION TO MAKE BEFORE WE CONTAINERIZE FOR RUST
--   Your vim-lsp setup (kept as-is below) auto-formats *.rs and
--   *.go on save via LspDocumentFormatSync, and your pylsp block
--   wires Python through the same client. The rustaceanvim + mason
--   + native nvim LSP stack we discussed for Rust is a DIFFERENT
--   LSP client. Running both against the same .rs file would double
--   up diagnostics and formatting. We'll need to either exclude
--   *.rs from the vim-lsp autocmd when rustaceanvim lands, or skip
--   rustaceanvim and drive Rust through vim-lsp instead. Not a
--   problem today — just don't want it to surprise you later.
-- ============================================================

-- {{{ leader keys (must be set before plugins load)
vim.g.mapleader = ','
vim.g.maplocalleader = '\\'
-- }}}

-- {{{ lazy.nvim bootstrap
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- }}}

-- {{{ plugins (vim-plug -> lazy.nvim)
require('lazy').setup({
  -- colorscheme
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },

  -- writing
  { 'preservim/vim-pencil' },
  { 'chrisbra/unicode.vim' },          -- deal with unicode caracters
  { 'junegunn/vim-emoji' },            -- insert emoji

  -- statusline
  { 'vim-airline/vim-airline' },       -- powerline like style for status bar
  { 'vim-airline/vim-airline-themes' },

  -- git
  { 'tpope/vim-fugitive' },            -- git plugin for vim
  { 'mhinz/vim-signify' },             -- show difference in git

  -- file / buffer navigation
  { 'preservim/nerdtree' },            -- file system explorer
  { 'wuelnerdotexe/nerdterm' },        -- toggle terminal
  { 'ctrlpvim/ctrlp.vim' },            -- fuzzy file/buffer/mru/tag finder
  { 'jlanzarotta/bufexplorer' },       -- buffer explorer
  { 'mhinz/vim-startify' },            -- start screen
  { 'gcmt/taboo.vim' },                -- rename tabs
  { 'kshenoy/vim-signature' },         -- place/toggle/display marks
  { 'junegunn/vim-peekaboo' },         -- display content of register dynamically

  -- grammar / language tooling
  { 'dpelle/vim-languagetool' },       -- LanguageTool grammar checker
  { 'dpelle/vim-Grammalecte' },        -- French grammar checking

  -- text editing helpers
  { 'godlygeek/tabular' },             -- tabular alignment of data
  { 'preservim/vim-markdown' },        -- syntax highlighting, matching rules
  { 'elzr/vim-json' },                 -- JSON helper
  { 'dhruvasagar/vim-table-mode' },

  -- Claude Code integration
  { 'rishi-opensource/vim-claude-code' },

  -- LSP (legacy vim-lsp client — see note above re: Rust)
  { 'prabirshrestha/vim-lsp' },
  { 'mattn/vim-lsp-settings' },
  { 'prabirshrestha/asyncomplete.vim' },     -- required by asyncomplete-lsp.vim, see note above
  { 'prabirshrestha/asyncomplete-lsp.vim' },

  -- tmux integration
  { 'tmux-plugins/vim-tmux' },         -- syntax for .tmux.conf
  { 'christoomey/vim-tmux-navigator' },

  -- distraction-free writing
  { 'junegunn/goyo.vim' },
  { 'junegunn/limelight.vim' },        -- complement of goyo

  -- icons (load order matters less under lazy.nvim, but devicons
  -- still wants to come after things that render icons)
  { 'adelarsq/vim-emoji-icon-theme' },
  { 'lambdalisue/vim-glyph-palette' }, -- apply color on Nerd Fonts
  { 'ryanoasis/vim-devicons' },
})
-- }}}

-- {{{ colorscheme
-- No ":colorscheme" call found in your original vimrc — uncomment
-- to actually activate catppuccin:
-- vim.cmd.colorscheme('catppuccin')
-- }}}

-- {{{ plugin options
vim.g.airline_left_sep = ''  -- \uE0B0
vim.g.airline_right_sep = '' -- \uE0B2
vim.g.airline_theme = 'solarized'
vim.g.airline_solarized_bg = 'base_16'
-- NB: original was "let airline_solarized_enable_command_color = 1"
-- (missing the g: prefix, so it never reached airline). Kept the
-- typo's effective behavior (no-op) rather than silently changing
-- functionality — let me know if you actually want this enabled
-- and I'll wire it up properly as vim.g.airline_solarized_enable_command_color.

vim.opt.completefunc = 'emoji#complete'

-- vim-lsp server registration, Python via pylsp
if vim.fn.executable('pylsp') == 1 then
  -- pip install python-lsp-server
  vim.api.nvim_create_autocmd('User', {
    pattern = 'lsp_setup',
    callback = function()
      vim.fn['lsp#register_server']({
        name = 'pylsp',
        cmd = function(_) return { 'pylsp' } end,
        allowlist = { 'python' },
      })
    end,
  })
end

-- language tool configuration and document language
vim.g.languagetool_jar = vim.fn.expand('$HOME/devzone/vim-config/LanguageTool-5.9/languagetool-commandline.jar')
vim.g.grammalecte_cli_py = '/usr/bin/grammalecte-cli.py'

-- pencil options, like gutter color
vim.g.pencil_gutter_color = 1
vim.g['pencil#textwidth'] = 80
vim.g.airline_section_x = '%{PencilMode()}'
vim.g['pencil#wrapModelDefault'] = 'soft' -- default is 'hard'

vim.g.vim_markdown_fenced_languages = { 'smalltalk=st' }
vim.g.vim_markdown_folding_style_pythonic = 1
vim.g.vim_markdown_folding_level = 1
vim.g.vim_markdown_toc_autofit = 1
vim.g.vim_markdown_strikethrough = 1
vim.g.vim_markdown_edit_url_in = 'vsplit'

-- netrw browsing tweaks
vim.g.netrw_banner = 0       -- disable annoying banner
vim.g.netrw_browse_split = 4 -- open in prior window
vim.g.netrw_altv = 1         -- open splits on the right
vim.g.netrw_liststyle = 3    -- tree view
vim.g.netrw_list_hide = [[,\(^\|\s\s\)\zs\.\S\+]]
-- }}}

-- {{{ core options
vim.opt.langmenu = 'en_US.UTF-8'   -- vim sera toujours en anglais
vim.opt.encoding = 'utf-8'         -- encodage par défaut
vim.opt.spelllang = 'fr'           -- langue par défaut pour correction orthographique
vim.opt.autowrite = true           -- autowrite when switching to another buffer
vim.opt.sessionoptions = 'blank,buffers,tabpages'
vim.opt.fileformats = 'unix,dos,mac' -- use Unix as the standard file type

-- background colors for active vs inactive windows (see WindowManagement augroup below)
vim.cmd('highlight NormalNC ctermbg=237')

vim.g.limelight_conceal_ctermfg = 'gray' -- needed on terminal

vim.opt.autochdir = true -- change window cwd par rapport au fichier

-- set cursorline (commented out in original, kept disabled)

vim.opt.colorcolumn = '+1' -- met en évidence la colonne après 'textwidth'
vim.cmd('highlight ColorColumn ctermbg=red guibg=#600000')

vim.opt.mouse = 'c' -- disable mouse

vim.opt.showcmd = true -- show (partial) command in the last line of the screen

vim.cmd('syntax on')
vim.cmd('syntax sync fromstart') -- see :help :syn-sync

vim.opt.number = true      -- ajout de la numérotation des lignes
vim.opt.startofline = true -- garde la position du curseur entre buffer

-- automatic wrap de texte
vim.opt.wrap = true
vim.opt.sidescroll = 5
vim.opt.textwidth = 80 -- largeur maxi du texte inséré
vim.opt.formatoptions:append('n') -- recognize numbered list

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.visualbell = true -- pas de beep intempestif, visual bell

vim.opt.lazyredraw = true -- redraw only when we need to

-- affiche les tabulations et les espaces de fin de ligne
vim.opt.list = true
vim.opt.listchars = { tab = '>-', trail = '-', precedes = '<', extends = '>' }

vim.opt.nrformats = '' -- pas de format de nombre pour ctrl-x ctrl-a

-- backspace permet de revenir en arriere tout le temps
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.whichwrap:append('<,>,[,]')

vim.opt.foldenable = true
vim.opt.fillchars:append({ fold = '=', foldopen = '▼', foldclose = '▶', foldsep = '┃' })
vim.opt.foldlevel = 4
vim.opt.foldcolumn = '5'

-- change character for split window
vim.cmd('highlight VertSplit cterm=NONE')
vim.opt.fillchars:append({ vert = '┃' })

-- traitement des espaces et des tabulations
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = true -- be smart when using tabs

vim.opt.concealcursor = 'nc' -- allow markdown without formatting markup

vim.opt.writebackup = false -- pas de fichier de swap
vim.opt.swapfile = false
vim.opt.backup = false      -- pas de backup

vim.opt.history = 500 -- how many lines of history Vim remembers

vim.opt.clipboard = 'unnamedplus'

-- search down into subfolders, tab-completion for all file-related tasks
vim.opt.path:append('**')

vim.opt.autoread = true -- auto read when a file is changed from outside
vim.opt.wildmenu = true -- display all matching files when we tab complete
vim.opt.ruler = true    -- always show ruler
vim.opt.cmdheight = 1   -- height of the command bar

vim.opt.ignorecase = true -- ignore la casse de caractère
vim.opt.smartcase = true  -- suit la casse du mot recherché
vim.opt.gdefault = true   -- applique le flag de substitution g par défaut
vim.opt.incsearch = true  -- met en valeur le motif de recherche
vim.opt.showmatch = true
vim.opt.hlsearch = true

vim.opt.magic = true        -- for regular expressions, turn magic on
vim.opt.regexpengine = 0    -- set regular expression engine automatically
vim.opt.matchtime = 2       -- how many tenths of a second to blink when matching bracket

vim.cmd('highlight User1 guifg=#eea040')
-- }}}

-- {{{ custom functions

-- fonction de nettoyage d'un fichier issu du monde dos:
-- - remplacement des tabulations par des espaces
-- - suppression des caractères ^M en fin de ligne
-- (see "RECONSTRUCTED" note at the top of this file)
local function display_status(msg)
  vim.api.nvim_echo({ { msg, 'Todo' } }, false, {})
end

local function clean_dos_code()
  vim.bo.fileformat = 'unix'
  vim.cmd('%retab')
  vim.cmd([[%s/\r//g]])
  display_status('fichier dos nettoyé')
end
vim.api.nvim_create_user_command('CleanDosCode', clean_dos_code, {})

-- showing highlight group under cursor
-- (Neovim 0.9+ also has the built-in :Inspect command, which uses
-- Treesitter rather than the legacy syntax engine, as a more modern
-- alternative to this)
local function syn_stack()
  if vim.fn.exists('*synstack') == 0 then return end
  local names = vim.fn.map(
    vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.')),
    'synIDattr(v:val, "name")'
  )
  display_status(vim.inspect(names))
end
vim.keymap.set('n', '<leader>sp', syn_stack)

-- goyo / limelight integration
local function goyo_enter()
  if vim.fn.executable('tmux') == 1 and vim.env.TMUX ~= nil and vim.env.TMUX ~= '' then
    vim.fn.system('tmux set status off')
    vim.fn.system([[tmux list-panes -F '#F' | grep -q Z || tmux resize-pane -Z]])
  end
  vim.opt.showmode = false
  vim.opt.showcmd = false
  vim.opt.scrolloff = 999
  vim.cmd('Limelight')
end

local function goyo_leave()
  if vim.fn.executable('tmux') == 1 and vim.env.TMUX ~= nil and vim.env.TMUX ~= '' then
    vim.fn.system('tmux set status on')
    vim.fn.system([[tmux list-panes -F '#F' | grep -q Z && tmux resize-pane -Z]])
  end
  vim.opt.showmode = true
  vim.opt.showcmd = true
  vim.opt.scrolloff = 5
  vim.cmd('Limelight!')
end

vim.api.nvim_create_autocmd('User', { pattern = 'GoyoEnter', nested = true, callback = goyo_enter })
vim.api.nvim_create_autocmd('User', { pattern = 'GoyoLeave', nested = true, callback = goyo_leave })

-- vim-lsp buffer setup (see decision-point note at top of file re: Rust)
local function on_lsp_buffer_enabled()
  vim.bo.omnifunc = 'lsp#complete'
  vim.wo.signcolumn = 'yes'
  if vim.fn.exists('+tagfunc') == 1 then
    vim.bo.tagfunc = 'lsp#tagfunc'
  end

  local opts = { buffer = true, remap = true } -- <plug> mappings need remap = true
  vim.keymap.set('n', 'gd', '<plug>(lsp-definition)', opts)
  vim.keymap.set('n', 'gs', '<plug>(lsp-document-symbol-search)', opts)
  vim.keymap.set('n', 'gS', '<plug>(lsp-workspace-symbol-search)', opts)
  vim.keymap.set('n', 'gr', '<plug>(lsp-references)', opts)
  vim.keymap.set('n', 'gi', '<plug>(lsp-implementation)', opts)
  vim.keymap.set('n', 'gt', '<plug>(lsp-type-definition)', opts)
  vim.keymap.set('n', '<leader>rn', '<plug>(lsp-rename)', opts)
  vim.keymap.set('n', '[g', '<plug>(lsp-previous-diagnostic)', opts)
  vim.keymap.set('n', ']g', '<plug>(lsp-next-diagnostic)', opts)
  vim.keymap.set('n', 'K', '<plug>(lsp-hover)', opts)

  local expr_opts = { buffer = true, expr = true }
  vim.keymap.set('n', '<c-f>', function() return vim.fn['lsp#scroll'](4) end, expr_opts)
  vim.keymap.set('n', '<c-d>', function() return vim.fn['lsp#scroll'](-4) end, expr_opts)

  vim.g.lsp_format_sync_timeout = 1000
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*.rs', '*.go' },
    callback = function() vim.cmd('LspDocumentFormatSync') end,
  })
end
vim.api.nvim_create_autocmd('User', { pattern = 'lsp_buffer_enabled', callback = on_lsp_buffer_enabled })
-- }}}

-- {{{ mappings
-- évite d'invoquer Ex
vim.keymap.set('n', 'Q', '<nop>')

-- active NERDTree
vim.keymap.set('', '<F2>', ':NERDTreeToggle<CR>')

-- active NERDTerm (<Plug> mapping needs remap = true)
vim.keymap.set('n', '<leader>tt', '<Plug>(NERDTermToggle)', { remap = true })
vim.keymap.set('t', '<leader>tt', '<Plug>(NERDTermToggle)', { remap = true })

-- navigation dans l'aide Vim
vim.keymap.set('n', '<CR>', '<C-]>')  -- activer un lien en appuyant sur Return
vim.keymap.set('n', '<BS>', '<C-T>')  -- revenir à la page précédente avec backspace

-- recharger / éditer init.lua ($MYVIMRC points here under Neovim)
vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<CR>')
vim.keymap.set('', '<leader>ev', ':vsplit $MYVIMRC<CR>')

-- mapping pour emoji
vim.keymap.set({ 'n', 'c', 'v' }, '<c-e>', '<nop>')
vim.keymap.set('i', '<ScrollWheelUp>', '<Nop>')
vim.keymap.set('i', '<c-x><c-e>', '<nop>')
vim.keymap.set('i', '<ScrollWheelDown>', '<Nop>')

-- emoji complete configuration (<Plug> mapping needs remap = true)
vim.g.emoji_complete_overwrite_standard_keymaps = 0
vim.keymap.set('i', '<c-x><c-E>', '<Plug>(emoji-start-complete)', { remap = true })

-- déplacement dans le fichier (disable arrow keys)
vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')
vim.keymap.set('n', '<left>', '<nop>')
vim.keymap.set('n', '<right>', '<nop>')
vim.keymap.set('i', '<up>', '<nop>')
vim.keymap.set('i', '<down>', '<nop>')
vim.keymap.set('i', '<left>', '<nop>')
vim.keymap.set('i', '<right>', '<nop>')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'gk', 'k')
vim.keymap.set('n', 'gj', 'j')
vim.keymap.set('c', '<C-p>', '<Up>')
vim.keymap.set('c', '<C-n>', '<Down>')
vim.keymap.set('c', '%%', function()
  return vim.fn.getcmdtype() == ':' and (vim.fn.expand('%:h') .. '/') or '%%'
end, { expr = true })

-- mapping pour faciliter la recherche
vim.keymap.set('n', '/', [[/\v]])
vim.keymap.set('v', '/', [[/\v]])
vim.keymap.set('n', '&', ':&&<CR>')
vim.keymap.set('x', '&', ':&&<CR>')

-- supprime la mise en valeur de la recherche
vim.keymap.set('n', '<leader><space>', ':nohlsearch<CR>')
-- remappe la recherche de parenthèse par % vers tab
vim.keymap.set('n', '<tab>', '%')
vim.keymap.set('v', '<tab>', '%')

-- associe F1 à ESC, évite les erreurs
vim.keymap.set({ 'i', 'n', 'v' }, '<F1>', '<ESC>')

-- se déplacer plus facilement dans les fenêtres
-- terminal mode
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]])
vim.keymap.set('t', '<C-j>', '<C-w><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-w><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-w><C-w>l')
-- visual mode
vim.keymap.set('v', '<C-h>', '<Esc><C-w>h')
vim.keymap.set('v', '<C-j>', '<Esc><C-w>j')
vim.keymap.set('v', '<C-k>', '<Esc><C-w>k')
vim.keymap.set('v', '<C-l>', '<Esc><C-w>l')
-- normal mode
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<leader>w', '<C-w>v<C-w>l')

-- terminal escape
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('t', '<M-[>', '<Esc>')
vim.keymap.set('t', '<C-v><Esc>', '<Esc>')

-- formatage de texte: retire les blancs en bout de ligne
vim.keymap.set('n', '<leader>W', [[:%s/\s\+$//<CR>:let @/=''<CR>]])

-- backspace in Visual mode deletes selection
vim.keymap.set('v', '<BS>', 'd')

-- CTRL-Y is Redo
vim.keymap.set({ 'n', 'v', 'o' }, '<C-Y>', '<C-R>')
vim.keymap.set('i', '<C-Y>', '<C-O><C-R>')

-- CTRL-A is Select all
vim.keymap.set({ 'n', 'v', 'o' }, '<C-A>', 'gggH<C-O>G')
vim.keymap.set('i', '<C-A>', '<C-O>gg<C-O>gH<C-O>G')
vim.keymap.set('c', '<C-A>', '<C-C>gggH<C-O>G')
vim.keymap.set('s', '<C-A>', '<C-C>gggH<C-O>G')
vim.keymap.set('x', '<C-A>', '<C-C>ggVG')

-- CTRL-Tab is Next window
vim.keymap.set({ 'n', 'v', 'o' }, '<C-Tab>', '<C-W>w')
vim.keymap.set('i', '<C-Tab>', '<C-O><C-W>w')
vim.keymap.set('c', '<C-Tab>', '<C-C><C-W>w')

-- CTRL-F4 is Close window
vim.keymap.set({ 'n', 'v', 'o' }, '<C-F4>', '<C-W>c')
vim.keymap.set('i', '<C-F4>', '<C-O><C-W>c')
vim.keymap.set('c', '<C-F4>', '<C-C><C-W>c')
-- }}}

-- {{{ autocmd groups

-- highlight active vs inactive window (uses NormalNC defined above)
local window_management = vim.api.nvim_create_augroup('WindowManagement', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', { group = window_management, pattern = '*', command = 'setl wincolor=Normal' })
vim.api.nvim_create_autocmd('WinLeave', { group = window_management, pattern = '*', command = 'setl wincolor=NormalNC' })

-- always open help vertically in the far right window
local vimrc_help = vim.api.nvim_create_augroup('vimrc_help', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = vimrc_help,
  pattern = '*.txt',
  callback = function()
    if vim.bo.buftype == 'help' then
      vim.cmd('wincmd L')
      vim.cmd('vertical resize 90')
    end
  end,
})

-- git syntax highlight
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, { pattern = 'COMMIT_EDITMSG', command = 'set filetype=gitcommit' })

-- {{{ groff utilities (relevant to Tephra / Groff documentation work)
local groff_compile = vim.api.nvim_create_augroup('groff_compile', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufFilePost' }, {
  group = groff_compile, pattern = '*.ms', command = [[!groff -ms % -Tpdf > %:r.pdf]],
})
vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufFilePost' }, {
  group = groff_compile, pattern = '*.me', command = [[!tbl % | groff -me -Tpdf > %:r.pdf]],
})
vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufFilePost' }, {
  group = groff_compile, pattern = '*.pic', command = [[!groff -p % -Tpdf > %:r.pdf]],
})
-- }}}
-- }}}

-- vim: set foldmethod=marker foldmarker={{{,}}} foldlevel=0 :
