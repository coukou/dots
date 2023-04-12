require("null-ls").setup()
require("mason-null-ls").setup({
	ensure_installed = { "stylua", "prettierd", "eslint", "yamlfmt" },
	automatic_setup = true,
	handlers = {},
})
