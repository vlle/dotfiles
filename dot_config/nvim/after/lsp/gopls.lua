-- ~/.config/nvim/lsp/gopls.lua

return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod", ".git" },
	single_file_support = true,
	settings = {
		gopls = {
			gofumpt = true,
			staticcheck = true,
			analyses = {
				unusedparams = true,
				unusedvariable = true,
				simplifyslice = true,
				slog = true,
			},
			hints = {
				functionTypeParameters = true,
				parameterNames = true,
				constantValues = true,
				rangeVariableTypes = true,
			},
		},
	},
}
