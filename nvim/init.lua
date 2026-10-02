-- bootstrap lazy.nvim, LazyVim and your plugins
--
-- LazyVim loads lua/config/options.lua itself at startup, and
-- lua/config/keymaps.lua and lua/config/autocmds.lua on the VeryLazy event,
-- so they must not be required here: doing so would load them twice.
require("config.lazy")
