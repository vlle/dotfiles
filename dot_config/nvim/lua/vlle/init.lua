require("vlle.options")
require("vlle.autocmds")
require("vlle.remap")
require("vlle.lsp")


--
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "yml",
-- 	callback = function()
-- 		-- Enable folding
-- 		vim.opt_local.foldenable = true
-- 		if vim.fn.exists("nvim_treesitter#foldexpr") == 1 then
-- 			vim.opt_local.foldmethod = "expr"
-- 			vim.cmd([[setlocal foldexpr=nvim_treesitter#foldexpr()]])
-- 		else
-- 			vim.opt_local.foldmethod = "indent"
-- 		end
-- 		-- Show spaces as specific symbols
-- 		vim.opt_local.list = true
-- 		vim.opt_local.listchars = { space = "⋅" }
-- 	end,
-- })
-- sss
