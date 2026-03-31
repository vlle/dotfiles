local opt = vim.opt

-- General
opt.clipboard = "unnamedplus" -- sync with system clipboard (macOS pbcopy/pbpaste)
opt.swapfile = false

-- Indentation (kept as-is from your previous init.lua)
opt.expandtab = false
opt.tabstop = 2
opt.shiftwidth = 4
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true

-- UI
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.showmode = true
opt.showcmd = true
opt.ruler = true
opt.visualbell = true
opt.wildmenu = true

-- Search
opt.hlsearch = true

-- Small UX defaults
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 4
opt.sidescrolloff = 8
