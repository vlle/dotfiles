local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local group = augroup("vlle_autocmds", { clear = true })

local function apply_transparent_highlights()
	-- Transparent background in dark mode only.
	-- In light mode we keep colorscheme-provided backgrounds to avoid washed-out UI.
	if vim.o.background == "dark" then
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end
end

-- Keep transparent background behavior consistent across colorscheme changes.
autocmd("ColorScheme", {
	group = group,
	callback = apply_transparent_highlights,
})

-- Also apply once right now (the initial colorscheme is usually set before this module is loaded).
apply_transparent_highlights()

-- Nice feedback when yanking.
autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.hl.on_yank({ timeout = 150 })
	end,
})

-- Make whitespace visible in YAML.
autocmd("FileType", {
	group = group,
	pattern = { "yaml", "yml" },
	callback = function()
		vim.opt_local.list = true
		vim.opt_local.listchars = { space = "⋅" }
	end,
})
