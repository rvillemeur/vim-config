return {

-- {{{ grammar / language tooling
  { 'dpelle/vim-languagetool',       -- LanguageTool grammar checker
                                    -- alternative: https://github.com/vigoux/LanguageTool.nvim
      config = function ()
         vim.g.languagetool_jar = vim.fn.expand('$HOME/devzone/vim-config/LanguageTool-5.9/languagetool-commandline.jar')
      end,
  },
  { 'dpelle/vim-Grammalecte' ,         -- French grammar checking
     config = function ()
        vim.g.grammalecte_cli_py = '/usr/bin/grammalecte-cli.py'
    end,
  },
-- }}}
-- {{{ text editing helpers
  { 'godlygeek/tabular' },             -- tabular alignment of data
  { 'elzr/vim-json' },                 -- JSON helper
  { 'dhruvasagar/vim-table-mode' },
-- }}}
-- {{{ distraction-free writing
  { 'pocco81/true-zen.nvim',
--    keys = { 
--        { "<F2>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer"},
--        { "<leader>zn", "<cmd>TZNarrow<CR>", desc = "true zen narrow"},
--       { "<leader>zn", "<cmd>'<,'>TZNarrow<CR>", desc = "true zen narrow on a region"},
--       { "<leader>zf", "<cmd>TZFocus<CR>", desc = "true zen focus"},
--       { "<leader>zm", "<cmd>TZMinimalist<CR>",desc = "true zen minimalist"}, 
 --      { "<leader>za", "<cmd>TZAtaraxis<CR>", desc = "true zen ataraxis"} 
 --  },
    config = function ()
        require('true-zen').setup()
    end,
  },
-- }}}
--  { 'preservim/vim-pencil' },
--  { 'chrisbra/unicode.vim' },          -- deal with unicode caracters
--  { 'junegunn/vim-emoji' },            -- insert emoji

}
-- vim: set foldmethod=marker foldmarker={{{,}}} foldlevel=0 :
