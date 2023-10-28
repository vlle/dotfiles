vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Neotree)
vim.keymap.set("n", "<leader>w", ':write!<CR>')
vim.keymap.set("n", "<leader>q", ':quit!<CR>')


vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
-- vim.g.copilot_filetypes.markdown = true

-- convert to lua
-- let g:copilot_filetypes = {
--     \ 'gitcommit': v:true,
--     \ 'markdown': v:true,
--     \ 'yaml': v:true
--     \ }
vim.g.copilot_filetypes = {
    gitcommit = true,
    markdown = true,
    yaml = true
}
