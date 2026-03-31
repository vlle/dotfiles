local lazygit_term = nil
local lazygit_dark = nil

local theme_pair = {
	dark = "catppuccin-mocha",
	light = "catppuccin-latte",
}

local function apply_background_theme(bg)
	local target = (bg or vim.o.background) == "light" and theme_pair.light or theme_pair.dark
	if vim.g.colors_name ~= target then
		vim.cmd.colorscheme(target)
	end
end

local function create_lazygit_term()
	local Terminal = require("toggleterm.terminal").Terminal
	local dark = vim.o.background == "dark"

	if lazygit_term ~= nil then
		lazygit_term:shutdown()
	end

	local home = vim.fn.expand("$HOME")
	local lg_cfg = home .. "/Library/Application Support/lazygit/config.yml"
	local lg_latte = home .. "/Library/Application Support/lazygit/catppuccin_latte.yml"
	local lg_mocha = home .. "/Library/Application Support/lazygit/catppuccin_mocha.yml"

	lazygit_term = Terminal:new({
		cmd = "lazygit",
		env = {
			BAT_THEME = dark and "Catppuccin Mocha" or "Catppuccin Latte",
			DELTA_FEATURES = dark and "catppuccin-mocha" or "catppuccin-latte",
			LG_CONFIG_FILE = table.concat({ lg_cfg, dark and lg_mocha or lg_latte }, ","),
		},
		hidden = true,
		direction = "float",
		float_opts = { border = "shadow" },
	})
	lazygit_dark = dark
end

local function toggle_lazygit()
	local dark = vim.o.background == "dark"
	if lazygit_term == nil or lazygit_dark ~= dark then
		create_lazygit_term()
	end
	lazygit_term:toggle()
end

return {
	-- Colorscheme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
			flavour = "mocha",
			integrations = {
				treesitter = true,
				barbar = true,
				gitsigns = true,
				lualine = true,
				neo_tree = true,
				telescope = true,
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			apply_background_theme(vim.o.background)
		end,
	},
	{
		"f-person/auto-dark-mode.nvim",
		event = "VeryLazy",
		opts = {
			update_interval = 1000,
			set_dark_mode = function()
				vim.o.background = "dark"
				apply_background_theme("dark")
			end,
			set_light_mode = function()
				vim.o.background = "light"
				apply_background_theme("light")
			end,
		},
	},

	-- Neovim config Lua tooling
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"vague2k/huez.nvim",
		branch = "stable",
		event = "UIEnter",
		import = "huez-manager.import",
		config = function()
			require("huez").setup({})
		end,
	},
	{ "Bilal2453/luvit-meta", lazy = true },

	-- Completion (loads early enough for LSP capabilities)
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			keymap = { preset = "default" },
			appearance = { nerd_font_variant = "mono" },
			completion = { documentation = { auto_show = false } },
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	-- Subtle animations (mini.nvim is already in your lockfile)
	{
		"echasnovski/mini.nvim",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.animate").setup({
				cursor = { enable = false },
				scroll = { enable = false },
				resize = { enable = false },
				open = { enable = true },
				close = { enable = true },
			})
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local max_filesize = 200 * 1024 -- 200KB
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"go",
					"gomod",
					"gosum",
					"gowork",
					"lua",
					"vim",
					"vimdoc",
					"markdown",
					"markdown_inline",
					"json",
					"yaml",
				},
				sync_install = false,
				auto_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
					disable = function(_, buf)
						local ok, stat = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
						return ok and stat and stat.size > max_filesize or false
					end,
				},
				indent = { enable = true },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({})
		end,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>pf", function() require("telescope.builtin").find_files() end, desc = "Find files" },
			{ "<C-p>", function() require("telescope.builtin").git_files() end, desc = "Find git files" },
			{
				"<leader>ps",
				function()
					require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
				end,
				desc = "Grep string",
			},
			{ "<leader>vh", function() require("telescope.builtin").help_tags() end, desc = "Help tags" },
			{ "<leader>co", function() require("telescope.builtin").commands() end, desc = "Commands" },
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					mappings = {
						n = {
							["<esc>"] = require("telescope.actions").close,
						},
					},
				},
			})
		end,
	},

	-- File tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = { "Neotree" },
		keys = {
			{ "<leader>pv", "<cmd>Neotree toggle<cr>", desc = "Neo-tree toggle" },
			{ "<leader>e", "<cmd>Neotree position=current<cr>", desc = "Neo-tree (current dir)" },
			{ "\\", "<cmd>Neotree reveal<cr>", desc = "Neo-tree reveal" },
			{
				"<leader>r",
				function()
					local file_path = vim.fn.expand("%:p")
					if file_path == "" then
						vim.notify("No file to reveal", vim.log.levels.INFO)
						return
					end
					vim.cmd("Neotree reveal_file=" .. vim.fn.fnameescape(file_path))
				end,
				desc = "Reveal file in Neo-tree",
			},
		},
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			use_libuv_file_watcher = true,
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
			},
		},
	},

	-- Git UX
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged_enable = true,
			signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,
			watch_gitdir = { follow_files = true },
			auto_attach = true,
			attach_to_untracked = false,
			current_line_blame = false,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 1000,
				use_focus = true,
			},
			current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
			update_debounce = 100,
			max_file_length = 40000,
			preview_config = {
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		},
		keys = {
			{
				"<leader>Gb",
				function()
					require("gitsigns").toggle_current_line_blame()
				end,
				desc = "Toggle git blame line",
			},
		},
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_c = { "filename" },
				lualine_x = { "location" },
			},
		},
	},

	-- Terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VeryLazy",
		keys = {
			{ [[<c-\>]], "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
			{ "<leader>g", toggle_lazygit, desc = "LazyGit" },
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
			-- pre-spawn lazygit so first <leader>g is instant
			create_lazygit_term()
			lazygit_term:spawn()
		end,
		opts = {
			size = 20,
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = "-30",
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_mode = true,
			direction = "horizontal",
			close_on_exit = true,
			shell = vim.o.shell,
			auto_scroll = true,
			float_opts = { border = "shadow" },
		},
	},

	-- Small utilities
	{
		"tversteeg/registers.nvim",
		name = "registers",
		cmd = "Registers",
		keys = {
			{ '"', mode = { "n", "v" } },
			{ "<C-R>", mode = "i" },
		},
		opts = {},
	},

	{
		"ethanholz/nvim-lastplace",
		event = { "BufReadPost" },
		config = function()
			require("nvim-lastplace").setup({})
		end,
	},

	{
		"m4xshen/autoclose.nvim",
		event = "InsertEnter",
		opts = {},
	},

	-- Git tools
	{
		"tpope/vim-fugitive",
		cmd = { "Git" },
		keys = {
			{ "<leader>Gs", "<cmd>Git<cr>", desc = "Git status (fugitive)" },
		},
	},

	{
		"mbbill/undotree",
		cmd = { "UndotreeToggle" },
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo tree" },
		},
	},

	-- Tabs
	{
		"romgrk/barbar.nvim",
		version = "^1.0.0",
		event = "BufAdd",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {},
	},

	-- DB
	{
		"tpope/vim-dadbod",
		cmd = { "DB" },
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		dependencies = { "tpope/vim-dadbod" },
	},

	-- Markdown
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"OXY2DEV/markview.nvim",
		ft = "markdown",
	},

	-- Misc
	{
		"fabridamicelli/cronex.nvim",
		event = "VeryLazy",
		opts = {},
	},

	{
		"akinsho/git-conflict.nvim",
		version = "*",
		event = { "BufReadPost", "BufNewFile" },
		config = true,
	},

	{
		"SmiteshP/nvim-navbuddy",
		cmd = { "Navbuddy" },
		dependencies = {
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},
		config = true,
	},

	{ "folke/neoconf.nvim", cmd = "Neoconf" },

	-- Optional / rarely used
	{ "voldikss/vim-floaterm", cmd = { "FloatermToggle", "FloatermNew" } },
}
