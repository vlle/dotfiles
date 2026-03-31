-- Built-in LSP (Neovim 0.11+) using runtime `lsp/*.lua` configs in this repo.

-- Enable servers (their configs live in `after/lsp/*.lua`).
vim.lsp.enable("luals")
vim.lsp.enable("gopls")
vim.lsp.enable("golangci")

vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded" },
})

local function organize_imports(bufnr)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" }, diagnostics = {} }

	local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
	if not results then
		return
	end

	for client_id, res in pairs(results) do
		for _, action in ipairs(res.result or {}) do
			if action.edit then
				local client = vim.lsp.get_client_by_id(client_id)
				local enc = client and client.offset_encoding or "utf-16"
				vim.lsp.util.apply_workspace_edit(action.edit, enc)
			end
			if action.command then
				vim.lsp.buf.execute_command(action.command)
			end
		end
	end
end

local group = vim.api.nvim_create_augroup("vlle_lsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf
		local opts = { buffer = bufnr, silent = true }

		-- Keymaps
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)

		-- One-shot "apply first code action" helper (kept from your old config).
		vim.keymap.set("n", "<leader>sa", function()
			vim.lsp.buf.code_action({ apply = true })
		end, vim.tbl_extend("force", opts, { desc = "LSP apply first code action" }))

		-- Inlay hints (only when supported).
		if client and client:supports_method("textDocument/inlayHint") and vim.lsp.inlay_hint then
			-- Enable by default for Go; keep other filetypes unchanged.
			if client.name == "gopls" then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end

		-- Go: organize imports + format on save (gopls only).
		if client and client.name == "gopls" then
			local fmt_group = vim.api.nvim_create_augroup("vlle_lsp_fmt_" .. bufnr, { clear = true })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = fmt_group,
				buffer = bufnr,
				callback = function()
					organize_imports(bufnr)
					vim.lsp.buf.format({
						bufnr = bufnr,
						timeout_ms = 1000,
						filter = function(c)
							return c.name == "gopls"
						end,
					})
				end,
			})
		end
	end,
})
