vim.opt.langmenu = "en_US.UTF-8" -- vim sera toujours en anglais
vim.opt.encoding = "utf-8" -- encodage par défaut
vim.opt.spelllang = "fr" -- langue par défaut pour correction orthographique
vim.opt.autowrite = true -- autowrite when switching to another buffer
vim.opt.sessionoptions = "blank,buffers,tabpages"
vim.opt.fileformats = "unix,dos,mac" -- use Unix as the standard file type

vim.opt.colorcolumn = "+1" -- met en évidence la colonne après 'textwidth'
vim.cmd("highlight ColorColumn ctermbg=red guibg=#600000")
-- automatic wrap de texte
vim.opt.wrap = true
vim.opt.sidescroll = 5
vim.opt.textwidth = 80 -- largeur maxi du texte inséré
vim.opt.formatoptions:append("n") -- recognize numbered list
-- change character for split window
vim.cmd("highlight VertSplit cterm=NONE")
vim.opt.fillchars:append({ vert = "┃" })
