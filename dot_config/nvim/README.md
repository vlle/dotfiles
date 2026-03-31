# Neovim Config (NVIM v0.11.4)

This config is tuned for fast startup and a smooth day-to-day Go workflow on Neovim **v0.11.4**.

## Layout

- `init.lua`: bootstraps `lazy.nvim`, enables `vim.loader` cache, then loads `lua/vlle/*`.
- `lua/vlle/options.lua`: editor options.
- `lua/vlle/autocmds.lua`: small UX autocommands (yank highlight, YAML whitespace, transparent background in dark mode only).
- `lua/vlle/remap.lua`: core keymaps (plugin keymaps live in `lua/vlle/lazy.lua` so they can lazy-load).
- `lua/vlle/lsp.lua`: built-in LSP attach behavior + Go format-on-save.
- `lua/vlle/lazy.lua`: `lazy.nvim` plugin spec (everything is lazy by default).
- `after/lsp/*.lua`: built-in LSP server configs (Neovim 0.11 feature).

## Keymaps

Leader is `<Space>`.

Core:

- `<leader>w`: write
- `<leader>q`: quit (force)
- `<leader>h`: clear search highlight

Navigation / UI:

- `<leader>pv`: Neo-tree toggle
- `<leader>e`: Neo-tree in current directory
- `\\`: Neo-tree reveal
- `<leader>r`: reveal current file in Neo-tree

Search:

- `<leader>pf`: Telescope find files
- `<C-p>`: Telescope git files
- `<leader>ps`: Telescope grep prompt
- `<leader>vh`: Telescope help tags
- `<leader>co`: Telescope commands

Git / tools:

- `<leader>gs`: `:Git` (fugitive)
- `<leader>g`: LazyGit (toggleterm)
- `<leader>gb`: toggle gitsigns current line blame
- `<leader>u`: undo tree

LSP:

- `gd`: definition
- `gr`: references
- `K`: hover
- `<leader>rn`: rename
- `<leader>ca`: code action
- `<leader>sa`: apply first code action
- `gl`: diagnostics float

Themes:

- `:Huez`: open theme picker (from `huez.nvim`)
- Auto theme pair is enabled:
  dark = `catppuccin-mocha`, light = `catppuccin-latte`

## Go Setup

This setup uses Neovim 0.11’s built-in LSP configs in `after/lsp/*.lua`.

Install the binaries (examples):

```sh
go install golang.org/x/tools/gopls@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

Behavior:

- `gopls` formats on save and runs “organize imports” on save (see `lua/vlle/lsp.lua`).
- Inlay hints are enabled by default for Go (if supported).

## Performance Notes

- Plugins are lazy-loaded by default (`lazy.nvim` + `defaults.lazy = true`).
- `after/plugin/*` was removed so Neovim doesn’t eagerly `require()` plugins on startup.
- `vim.loader.enable()` is enabled (bytecode cache for Lua modules).

To profile:

```sh
nvim --startuptime /tmp/nvim_startup.log
```

Inside Neovim:

- `:Lazy profile`
- `:checkhealth`
