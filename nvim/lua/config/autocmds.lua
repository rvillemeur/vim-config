-- {{{ autocmd groups

-- Couleurs pour fenêtres active/inactive.
-- Palette tokyonight-moon, identique à window-style / window-active-style dans
-- tmux.conf (bg = #222436, bg_highlight = #2f334d) :
-- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_moon.lua
local win_colors = {
  active = "#222436", -- bg
  inactive = "#2f334d", -- bg_highlight
}

local win_group = vim.api.nvim_create_augroup("WindowManagement", { clear = true })

-- Les groupes doivent être redéfinis après chaque chargement de colorscheme
local function define_win_hl()
  vim.api.nvim_set_hl(0, "ActiveWindow", { bg = win_colors.active })
  vim.api.nvim_set_hl(0, "InactiveWindow", { bg = win_colors.inactive })
end
define_win_hl()
vim.api.nvim_create_autocmd("ColorScheme", { group = win_group, callback = define_win_hl })

-- Vrai quand le pane tmux (ou le terminal) qui contient neovim a le focus.
-- Mis à jour par FocusGained / FocusLost, qui nécessitent 'focus-events on'
-- côté tmux.
local has_focus = true

local function repaint_windows()
  local current = vim.api.nvim_get_current_win()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    -- on laisse les fenêtres flottantes (Lazy, Telescope, LSP hover) tranquilles
    if vim.api.nvim_win_get_config(win).relative == "" then
      local active = has_focus and win == current
      local value = active and "Normal:ActiveWindow,NormalNC:ActiveWindow"
        or "Normal:InactiveWindow,NormalNC:InactiveWindow"
      vim.api.nvim_set_option_value("winhighlight", value, { win = win, scope = "local" })
    end
  end
end

vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "WinNew", "BufWinEnter" }, {
  group = win_group,
  callback = repaint_windows,
})
vim.api.nvim_create_autocmd("WinClosed", {
  group = win_group,
  callback = function()
    vim.schedule(repaint_windows)
  end,
})
vim.api.nvim_create_autocmd("FocusGained", {
  group = win_group,
  callback = function()
    has_focus = true
    repaint_windows()
  end,
})
vim.api.nvim_create_autocmd("FocusLost", {
  group = win_group,
  callback = function()
    has_focus = false
    repaint_windows()
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
