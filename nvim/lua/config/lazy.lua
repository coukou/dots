local lazy = require("lazy")

local plugins = {
	-- Lazy
	{ "folke/lazy.nvim" },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		config = function()
			require("config.nvim-treesitter")
		end
	},


	-- telescope
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.1',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('config.telescope')
		end
	},

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("config.nvim-surround")
		end
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.trouble")
		end
	},


	{
		'pwntester/octo.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			require("config.octo")
		end
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			{ 'L3MON4D3/LuaSnip' },
		},
		config = function()
			require('config.cmp')
		end
	},

	-- LSP
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		lazy = true,
		config = function()
			require('config.lsp-zero')
		end
	},
	{
		'neovim/nvim-lspconfig',
		cmd = 'LspInfo',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'williamboman/mason-lspconfig.nvim' },
			{ 'ray-x/lsp_signature.nvim' },
			{ 'weilbith/nvim-code-action-menu' },
			{
				'williamboman/mason.nvim',
				build = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
		},
		config = function()
			-- This is where all the LSP shenanigans will live
			require("config.lsp")
		end
	},

	-- Git Stuff
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
		config = function()
			require("config.gitsigns")
		end
	},

	-- Explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
			{ "MunifTanjim/nui.nvim" },
		},
		config = function()
			require('config.neo-tree')
		end
	},

	-- Notify
	{
		"rcarriga/nvim-notify",
		lazy = false,
		config = function()
			require('config.notify')
		end
	},

	-- Comments
	{
		'numToStr/Comment.nvim',
		config = function()
			require('config.comment')
		end
	},

	-- Statusbar
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('config.lualine')
		end
	},

	-- Whichkey
	{
		"folke/which-key.nvim",
		config = function()
			require("config.which-key")
		end
	},

	-- Themes
	{
		'projekt0n/github-nvim-theme',
		priority = 1000,
		lazy = Config.theme ~= "github",
		config = function()
			require("config.theme.github")
		end
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = Config.theme ~= "catppuccino",
		config = function()
			require("config.theme.catppuccino")
		end
	},
}

lazy.setup(plugins, opts)
