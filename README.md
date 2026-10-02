# vim-config

Personal Neovim and Vim configuration.

Neovim is the current setup, built on [LazyVim](https://www.lazyvim.org/).
The Vim configuration is kept for the plain `vim` binary and is no longer
actively developed.

## Layout

```
nvim/                       # Neovim, symlinked to ~/.config/nvim
├── init.lua                # bootstraps lua/config/lazy.lua, nothing else
├── lazy-lock.json          # plugin commit pins, commit after :Lazy update
├── lazyvim.json            # selected LazyVim extras
├── lua/config/             # lazy, options, keymaps, autocmds
└── lua/plugins/            # plugin specs and overrides
vim/                        # legacy Vim
├── vimrc                   # symlinked to ~/.vimrc
├── gvimrc                  # symlinked to ~/.gvimrc
├── markdown-rich.lua
└── template_markdeep.md.html
```

`nvim/` is linked as a whole directory rather than file by file, so any new
file dropped into the Neovim configuration is versioned by default.

## Installation

Clone the repository, then link the three entry points:

```
git clone <this repo> ~/devzone/vim-config
ln -s ~/devzone/vim-config/nvim  ~/.config/nvim
ln -s ~/devzone/vim-config/vim/vimrc  ~/.vimrc
ln -s ~/devzone/vim-config/vim/gvimrc ~/.gvimrc
```

Start `nvim`: LazyVim bootstraps lazy.nvim and installs every plugin at the
commits pinned in `nvim/lazy-lock.json`. Plugin code is installed under
`~/.local/share/nvim/lazy/` and is deliberately not part of this repository.

For Vim, install [vim-plug](https://github.com/junegunn/vim-plug) and run
`:PlugInstall`.

### LanguageTool

The grammar checker is a vendored binary tree of roughly 600 MB, so it is not
versioned here. Both `vim/vimrc` and `nvim/lua/plugins/writing.lua` expect the
jar at:

```
$HOME/devzone/vim-config/LanguageTool-5.9/languagetool-commandline.jar
```

Download the archive from <https://languagetool.org/download/> and unzip it at
the repository root, or point those two files at the version you install.

## Notes

Pane and window backgrounds follow the tokyonight-moon palette and are kept in
sync with tmux, so a focused pane looks the same whether it runs a shell or
Neovim. `nvim/lua/config/autocmds.lua` mirrors the `window-style` and
`window-active-style` values from `tmux.conf` in the `bash_config` repository;
change one and change the other. The Neovim side is driven by `FocusGained` and
`FocusLost`, which require `focus-events on` in tmux.
