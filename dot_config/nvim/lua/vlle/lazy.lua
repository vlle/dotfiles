return  {
  -- Packer can manage itself
  "folke/neodev.nvim",
  "navarasu/onedark.nvim", -- new theme for light color
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-ui", 
  "iamcco/markdown-preview.nvim",
  "m4xshen/autoclose.nvim",
	-- {'akinsho/git-conflict.nvim', version = "*", config = true},
  {
	"tversteeg/registers.nvim",
	name = "registers",
	keys = {
		{ "\"",    mode = { "n", "v" } },
		{ "<C-R>", mode = "i" }
	},
	cmd = "Registers",
  },

  "github/copilot.vim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
  end,
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  'wbthomason/packer.nvim',
  {
    'nvim-telescope/telescope.nvim', version = '0.1.0',
    dependencies= { {'nvim-lua/plenary.nvim'} }
  },
  -- {'Mofiqul/dracula.nvim', 
  -- name = 'dracula',
  -- lazy = false,
  -- priority = 1000,
  -- config = function()
  --   vim.cmd('colorscheme dracula')
  -- end,
  --},
{'nvim-treesitter/nvim-treesitter',
  build= ':TSUpdate',
},

{
  'nvim-neo-tree/neo-tree.nvim',
    branch = "v2.x",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
    end,
  },
  "nvim-treesitter/playground",
  "ThePrimeagen/harpoon",
  "mbbill/undotree",
  "tpope/vim-fugitive",
  "lewis6991/gitsigns.nvim",
  "voldikss/vim-floaterm",
  {
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},

    --- Uncomment these if you want to manage LSP servers from neovim
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    -- LSP Support
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        {'hrsh7th/cmp-nvim-lsp'},
      },
    },

    -- Autocompletion
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        {'L3MON4D3/LuaSnip'},
      }
    }
  },
  'ethanholz/nvim-lastplace',
  'akinsho/toggleterm.nvim',
  -- 'vold'
  "nvim-lualine/lualine.nvim",
  dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
}
