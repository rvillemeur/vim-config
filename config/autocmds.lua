-- {{{ autocmd groups

-- Couleurs pour fenêtres active/inactive
-- valeur reprise de https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_moon.lua
vim.api.nvim_set_hl(0, "ActiveWindow", { bg = "#222436" })
vim.api.nvim_set_hl(0, "InactiveWindow", { bg = "#545c7e" })

-- Highlight de la fenêtre active/inactive
local win_group = vim.api.nvim_create_augroup("WindowManagement", { clear = true })
vim.api.nvim_create_autocmd("WinEnter", {
  group = win_group,
  callback = function()
    vim.wo.winhighlight = "Normal:ActiveWindow,NormalNC:InactiveWindow"
  end,
})

-- always open help vertically in the far right window
local vimrc_help = vim.api.nvim_create_augroup("vimrc_help", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = vimrc_help,
  pattern = "*.txt",
  callback = function()
    if vim.bo.buftype == "help" then
      vim.cmd("wincmd L")
      vim.cmd("vertical resize 90")
    end
  end,
})

-- git syntax highlight
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  { pattern = "COMMIT_EDITMSG", command = "set filetype=gitcommit" }
)

-- {{{ groff utilities (relevant to Tephra / Groff documentation work)
local groff_compile = vim.api.nvim_create_augroup("groff_compile", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost", "BufFilePost" }, {
  group = groff_compile,
  pattern = "*.ms",
  command = [[!groff -ms % -Tpdf > %:r.pdf]],
})
vim.api.nvim_create_autocmd({ "BufWritePost", "BufFilePost" }, {
  group = groff_compile,
  pattern = "*.me",
  command = [[!tbl % | groff -me -Tpdf > %:r.pdf]],
})
vim.api.nvim_create_autocmd({ "BufWritePost", "BufFilePost" }, {
  group = groff_compile,
  pattern = "*.pic",
  command = [[!groff -p % -Tpdf > %:r.pdf]],
})
-- }}}
-- }}}
