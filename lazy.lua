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
-- {{{ plugins 
require('lazy').setup({
    { import = "plugins" }, -- charge tous les fichiers de ~/.config/nvim/lua/plugins/
  -- colorscheme
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },

  -- writing
--  { 'preservim/vim-pencil' },
--  { 'chrisbra/unicode.vim' },          -- deal with unicode caracters
--  { 'junegunn/vim-emoji' },            -- insert emoji

  -- statusline
  { 'nvim-lualine/lualine.nvim' },          -- vim airline replacement
   dependencies = { 'nvim-tree/nvim-web-devicons' },
--  { 'vim-airline/vim-airline' },       -- powerline like style for status bar
--  { 'vim-airline/vim-airline-themes' },

  -- git
  { 'tpope/vim-fugitive' },            -- git plugin for vim
  { 'mhinz/vim-signify' },             -- show difference in git

  -- file / buffer navigation
--  { 'preservim/nerdtree' },            -- file system explorer
  { 'nvim-tree/nvim-tree.lua'},        -- nerdtree equivalent for neovim
--  { 'wuelnerdotexe/nerdterm' },        -- toggle terminal
  { 'akinsho/toggleterm.nvim' },       -- toggle terminal (nvim version)
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
--  { 'preservim/vim-markdown' },        -- syntax highlighting, matching rules
--  {
--    'MeanderingProgrammer/render-markdown.nvim', -- markdown module for neovim
--    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
--    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
--    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
--    ---@module 'render-markdown'
--    ---@type render.md.UserConfig
--    opts = {},
--  },
  { 'elzr/vim-json' },                 -- JSON helper
  { 'dhruvasagar/vim-table-mode' },

  -- Claude Code integration
--  { 'rishi-opensource/vim-claude-code' },

  -- LSP (legacy vim-lsp client — see note above re: Rust)
--  { 'prabirshrestha/vim-lsp' },
--  { 'mattn/vim-lsp-settings' },
--  { 'prabirshrestha/asyncomplete.vim' },     -- required by asyncomplete-lsp.vim, see note above
--  { 'prabirshrestha/asyncomplete-lsp.vim' },

  -- tmux integration
  { 'tmux-plugins/vim-tmux' },         -- syntax for .tmux.conf
  { 'christoomey/vim-tmux-navigator' },

  -- distraction-free writing
  { 'pocco81/true-zen.nvim' },          -- goyo replacement for neovim
 -- { 'junegunn/goyo.vim' },
--  { 'junegunn/limelight.vim' },        -- complement of goyo

  -- icons (load order matters less under lazy.nvim, but devicons
  -- still wants to come after things that render icons)
  { 'adelarsq/vim-emoji-icon-theme' },
  { 'lambdalisue/vim-glyph-palette' }, -- apply color on Nerd Fonts
  { 'ryanoasis/vim-devicons' },
})
-- }}}
