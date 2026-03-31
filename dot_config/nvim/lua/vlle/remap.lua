-- Keymap helper
local map = vim.keymap.set
local opts = { silent = true }

-- Core Mappings
map("n", "<leader>w", "<cmd>write<cr>", opts) -- Save buffer
map("n", "<leader>q", "<cmd>quit!<cr>", opts) -- Force quit
map("n", "<leader>h", "<cmd>nohlsearch<cr>", opts) -- Clear search highlight
