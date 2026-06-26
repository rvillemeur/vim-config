-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- {{{ mappings
vim.keymap.set("n", "Q", "<nop>") -- évite d'invoquer Ex

-- navigation dans l'aide Vim
vim.keymap.set("n", "<CR>", "<C-]>") -- activer un lien en appuyant sur Return
vim.keymap.set("n", "<BS>", "<C-T>") -- revenir à la page précédente avec backspace

-- recharger / éditer init.lua ($MYVIMRC points here under Neovim)
vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<CR>")
vim.keymap.set("", "<leader>ev", ":vsplit $MYVIMRC<CR>")

-- déplacement dans le fichier (disable arrow keys)
vim.keymap.set("n", "<up>", "<nop>")
vim.keymap.set("n", "<down>", "<nop>")
vim.keymap.set("n", "<left>", "<nop>")
vim.keymap.set("n", "<right>", "<nop>")
vim.keymap.set("i", "<up>", "<nop>")
vim.keymap.set("i", "<down>", "<nop>")
vim.keymap.set("i", "<left>", "<nop>")
vim.keymap.set("i", "<right>", "<nop>")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "gk", "k")
vim.keymap.set("n", "gj", "j")
vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-n>", "<Down>")
vim.keymap.set("c", "%%", function()
  return vim.fn.getcmdtype() == ":" and (vim.fn.expand("%:h") .. "/") or "%%"
end, { expr = true })

-- mapping pour faciliter la recherche
vim.keymap.set("n", "/", [[/\v]])
vim.keymap.set("v", "/", [[/\v]])
vim.keymap.set("n", "&", ":&&<CR>")
vim.keymap.set("x", "&", ":&&<CR>")

-- supprime la mise en valeur de la recherche
vim.keymap.set("n", "<leader><space>", ":nohlsearch<CR>")
-- remappe la recherche de parenthèse par % vers tab
vim.keymap.set("n", "<tab>", "%")
vim.keymap.set("v", "<tab>", "%")

-- associe F1 à ESC, évite les erreurs
--vim.keymap.set({ 'i', 'n', 'v' }, '<F1>', '<ESC>')

-- terminal escape
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "<M-[>", "<Esc>")
vim.keymap.set("t", "<C-v><Esc>", "<Esc>")

-- formatage de texte: retire les blancs en bout de ligne
vim.keymap.set("n", "<leader>W", [[:%s/\s\+$//<CR>:let @/=''<CR>]])

-- backspace in Visual mode deletes selection
vim.keymap.set("v", "<BS>", "d")

-- CTRL-Y is Redo
vim.keymap.set({ "n", "v", "o" }, "<C-Y>", "<C-R>")
vim.keymap.set("i", "<C-Y>", "<C-O><C-R>")

-- CTRL-A is Select all
vim.keymap.set({ "n", "v", "o" }, "<C-A>", "gggH<C-O>G")
vim.keymap.set("i", "<C-A>", "<C-O>gg<C-O>gH<C-O>G")
vim.keymap.set("c", "<C-A>", "<C-C>gggH<C-O>G")
vim.keymap.set("s", "<C-A>", "<C-C>gggH<C-O>G")
vim.keymap.set("x", "<C-A>", "<C-C>ggVG")

-- CTRL-Tab is Next window
vim.keymap.set({ "n", "v", "o" }, "<C-Tab>", "<C-W>w")
vim.keymap.set("i", "<C-Tab>", "<C-O><C-W>w")
vim.keymap.set("c", "<C-Tab>", "<C-C><C-W>w")

-- CTRL-F4 is Close window
vim.keymap.set({ "n", "v", "o" }, "<C-F4>", "<C-W>c")
vim.keymap.set("i", "<C-F4>", "<C-O><C-W>c")
vim.keymap.set("c", "<C-F4>", "<C-C><C-W>c")
-- }}}
-- vim: set foldmethod=marker foldmarker={{{,}}} foldlevel=0 :
