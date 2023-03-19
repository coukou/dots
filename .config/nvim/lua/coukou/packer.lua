local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	vim.cmd([[packadd packer.nvim]])
end

return require("packer").startup(function(use)
	-- Self managed packer
	use("wbthomason/packer.nvim")

	-- file search
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- Explorer
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})

	-- colors
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" } })

	-- Comment
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- toggleterm
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})

	-- LSP
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "ray-x/lsp_signature.nvim" },
			{ "ray-x/cmp-treesitter" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	-- Format
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			{ "williamboman/mason.nvim" },
			{ "jay-babu/mason-null-ls.nvim" },
		},
	})

	-- code action
	use({
		"weilbith/nvim-code-action-menu",
	})

	-- Diagnostic
	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
	})

	-- editorconfig
	use({
		"gpanders/editorconfig.nvim",
	})

	-- whichkey
	use({
		"folke/which-key.nvim",
	})

	-- status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})
end)
