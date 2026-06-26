-- essential plugin I consider should be install by default

return {
  -- {{{ colorscheme
  -- add gruvbox
  -- { "ellisonleao/gruvbox.nvim" },
  -- Configure LazyVim to load gruvbox
  --{
  --  "LazyVim/LazyVim",
  --  opts = {
  --    colorscheme = "gruvbox",
  --    --colorscheme = "default",
  --  },
  --},
  -- }}}
  -- {{{ status-line
  --{
  --  "nvim-lualine/lualine.nvim",
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  --  config = function()
  --   require("lualine").setup()
  --  end,
  --},
  -- }}}
  -- {{{ toggle terminal
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<F3>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
    },
    config = function()
      require("toggleterm").setup()
    end,
  },
  -- }}}
  -- {{{ file tree navigation
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<F2>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },
  -- }}}
  -- {{{ buffer explorer
  {
    "jlanzarotta/bufexplorer",

    keys = {
      { "<F1>", "<cmd>ToggleBufExplorer<CR>", desc = "Toggle buffer explorer" },
    },
  },
  -- }}}
  -- {{{ start screen
  --  { 'mhinz/vim-startify' },
  -- }}}
  -- {{{ rename tabs
  { "gcmt/taboo.vim" },
  -- }}}
  -- {{{ place/toggle/display marks
  { "kshenoy/vim-signature" },
  -- }}}
  -- {{{ display content of register dynamically
  { "junegunn/vim-peekaboo" },
  --  }}}
  --  { 'adelarsq/vim-emoji-icon-theme' },
  --  { 'lambdalisue/vim-glyph-palette' }, -- apply color on Nerd Fonts
  --  { 'ryanoasis/vim-devicons' },
}

-- vim: set foldmethod=marker foldmarker={{{,}}} foldlevel=0 :
