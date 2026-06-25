-- =============================================================
-- plugins/markdown-rich.lua
-- Rendu riche : Markdown, LaTeX/math, images
-- =============================================================
--
-- INSTALLATION
--   Placer ce fichier dans ~/.config/nvim/lua/plugins/
--   lazy.nvim le détecte automatiquement si tu utilises le
--   pattern de chargement par répertoire (import = "plugins").
--
--   Si ton init.lua charge lazy.nvim avec un seul fichier de
--   spec, ajouter à la table specs :
--     require("plugins.markdown-rich")
--
-- PRÉREQUIS SYSTÈME (Fedora)
--   sudo dnf install -y ImageMagick luarocks      # image.nvim
--   pip install --user pynvim                     # certains backends
--
-- TERMINAL COMPATIBLE IMAGES
--   image.nvim nécessite un terminal avec protocole graphique :
--   • Kitty  → kitty.conf : graphics_protocol kitty   [recommandé]
--   • WezTerm → supporté nativement
--   • Foot, Ghostty → supportés
--   KDE Konsole ne supporte PAS les protocoles graphiques (2026).
--   Alternative : utiliser WezTerm ou Kitty comme terminal principal.
--
-- =============================================================

return {

  -- ----------------------------------------------------------
  -- 1. render-markdown.nvim
  --    Rendu Markdown inline dans le buffer (headers stylisés,
  --    listes, tableaux, blocs de code, checkboxes…)
  --    Dépend de nvim-treesitter pour le parsing.
  -- ----------------------------------------------------------
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "md", "rmd", "quarto" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons", -- icônes optionnelles mais recommandées
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      -- Activer par défaut sur les fichiers markdown
      enabled = true,
      -- Rendu des blocs de code avec fond coloré
      code = {
        enabled = true,
        style = "full",           -- "full" | "normal" | "language" | "none"
        border = "thin",
      },
      -- Rendu des headers (H1–H6) avec icônes et couleurs
      heading = {
        enabled = true,
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      -- Checkboxes interactifs
      checkbox = {
        enabled = true,
        unchecked  = { icon = "󰄱 " },
        checked    = { icon = "󰱒 " },
        custom = {
          todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
        },
      },
      -- Tableaux avec bordures Unicode
      pipe_table = { enabled = true, style = "full" },
      -- Blocs de citation
      quote = { enabled = true, icon = "▋" },
      -- Listes à puces stylisées
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
      },
      -- Rendu des liens
      link = { enabled = true },
    },
    -- Toggle avec <leader>rm
    keys = {
      { "<leader>rm", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle Markdown render" },
    },
  },

  -- ----------------------------------------------------------
  -- 2. nabla.nvim
  --    Rendu LaTeX/math INLINE dans le buffer via virtualtext
  --    Unicode. Pas de dépendance externe (pas de LaTeX requis).
  --    Supporte $...$ et $$...$$ et les environnements \begin.
  -- ----------------------------------------------------------
  {
    "jbyuki/nabla.nvim",
    ft = { "markdown", "tex", "latex", "plaintex", "rmd", "quarto" },
    keys = {
      {
        "<leader>mp",
        function() require("nabla").popup() end,
        desc = "Math : popup LaTeX",
      },
      {
        "<leader>mt",
        function() require("nabla").toggle_virt() end,
        desc = "Math : toggle virtualtext",
      },
    },
    -- Activation automatique du rendu virtualtext sur les fichiers markdown
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "rmd", "quarto" },
        callback = function()
          -- Rendu virtualtext automatique (désactivable avec <leader>mt)
          require("nabla").enable_virt({
            autogen = true,  -- recalcule à chaque changement
            silent  = true,
          })
        end,
      })
    end,
  },

  -- ----------------------------------------------------------
  -- 3. markdown-preview.nvim
  --    Preview complète dans le navigateur : Markdown + math
  --    (KaTeX) + diagrammes Mermaid + images.
  --    Serveur local auto-démarré, sync scroll avec le buffer.
  -- ----------------------------------------------------------
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown", "md" },
    build = function()
      -- Build via yarn embarqué dans le plugin
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      { "<leader>mb", "<cmd>MarkdownPreviewToggle<CR>", desc = "Markdown : browser preview" },
    },
    config = function()
      -- Ouvre automatiquement dans le navigateur par défaut du système
      vim.g.mkdp_auto_open    = 0   -- ne s'ouvre pas sans commande explicite
      vim.g.mkdp_auto_close   = 1   -- ferme quand on quitte le buffer
      vim.g.mkdp_refresh_slow = 0   -- sync temps réel
      vim.g.mkdp_theme        = "dark"
      -- Rendu math via KaTeX (plus rapide que MathJax)
      vim.g.mkdp_preview_options = {
        mkit              = {},
        katex             = {},
        uml               = {},
        maid              = {},
        disable_sync_scroll = 0,
        sync_scroll_type  = "middle",
        hide_yaml_meta    = 1,
      }
    end,
  },

  -- ----------------------------------------------------------
  -- 4. image.nvim
  --    Rendu d'images INLINE dans le buffer Neovim.
  --    Nécessite un terminal compatible (Kitty, WezTerm).
  --    Supporte PNG, JPEG, GIF, WebP via ImageMagick.
  --    Intégration avec render-markdown.nvim pour les images
  --    embarquées dans les fichiers Markdown.
  -- ----------------------------------------------------------
  {
    "3rd/image.nvim",
    -- Chargement différé : seulement si le terminal supporte les images
    -- (évite les erreurs sur Konsole/xterm)
    cond = function()
      -- Kitty : TERM contient "kitty"
      -- WezTerm : variable d'env TERM_PROGRAM
      local term = os.getenv("TERM") or ""
      local term_prog = os.getenv("TERM_PROGRAM") or ""
      return term:find("kitty") ~= nil
          or term_prog:find("WezTerm") ~= nil
          or term_prog:find("ghostty") ~= nil
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      -- luarocks : magick (binding ImageMagick)
      -- Installation : luarocks install magick
      -- ou : sudo dnf install lua-magick
    },
    opts = {
      backend = "kitty",            -- "kitty" | "ueberzug" | "sixel"
      integrations = {
        markdown = {
          enabled          = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes        = { "markdown", "rmd", "quarto" },
        },
        neorg = { enabled = false },
        typst = { enabled = false },
      },
      max_width  = 80,              -- largeur max en colonnes
      max_height = 30,              -- hauteur max en lignes
      max_width_window_percentage  = 50,
      max_height_window_percentage = 40,
      window_overlap_clear_enabled = true,
      editor_only_render_when_focused = false,
      tmux_show_only_in_active_window  = true,
      -- Hijack la commande :image pour afficher sous le curseur
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
    },
  },

  -- ----------------------------------------------------------
  -- 5. nvim-treesitter (parsers requis)
  --    Si tu as déjà treesitter dans ton init.lua, ajouter
  --    uniquement les parsers manquants à ensure_installed.
  --    Ce bloc est idempotent (lazy.nvim merge les specs).
  -- ----------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Fusion avec la config treesitter existante
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "markdown",
        "markdown_inline", -- requis pour render-markdown.nvim
        "latex",
      })
    end,
  },

}

-- =============================================================
-- RACCOURCIS CLAVIER (récapitulatif)
-- =============================================================
--
--  <leader>rm   Toggle rendu Markdown inline (render-markdown)
--  <leader>mp   Popup math LaTeX sous le curseur (nabla)
--  <leader>mt   Toggle rendu math virtualtext (nabla)
--  <leader>mb   Ouvrir/fermer preview navigateur (markdown-preview)
--
-- =============================================================
-- NOTES D'INTÉGRATION
-- =============================================================
--
-- render-markdown.nvim et image.nvim se coordonnent automatiquement
-- quand les deux sont actifs : render-markdown délègue le rendu
-- des images à image.nvim si celui-ci est chargé.
--
-- nabla.nvim opère sur les formules dans le buffer texte ;
-- markdown-preview les renvoie à KaTeX dans le navigateur.
-- Les deux sont complémentaires : nabla pour l'aperçu rapide
-- sans quitter Neovim, preview pour le rendu typographique final.
--
-- =============================================================
