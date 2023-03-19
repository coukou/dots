local lsp = require("lsp-zero")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("lsp-zero").extend_lspconfig({
	on_attach = function(client, bufnr)
		function create_opts(desc)
			return { buffer = bufnr, remap = false, desc = desc }
		end

		vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ bufnr = bufnr })' ]])

		vim.keymap.set("n", "<leader>k", function()
			vim.lsp.buf.hover()
		end, create_opts("lsp hover"))

		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, create_opts("diagnostic next"))

		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, create_opts("diagnostic prev"))

		vim.keymap.set("n", "<leader>r", function()
			vim.lsp.buf.rename()
		end, create_opts("lsp rename"))

		vim.keymap.set("n", "<leader>h", function()
			vim.lsp.buf.signature_help()
		end, create_opts("lsp signature help"))

		vim.keymap.set("n", "<leader>=", function()
			vim.lsp.buf.format({ bufnr = bufnr })
		end, create_opts("lsp format"))

		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"rust_analyzer",
		"tsserver",
		"eslint",
	},
})

require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({})
	end,
})

require("lsp_signature").setup({})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = false,
	float = true,
})
---
-- Configure LSP servers
---

require("lsp-zero").extend_lspconfig()

require("mason").setup()
require("mason-lspconfig").setup()

local get_servers = require("mason-lspconfig").get_installed_servers
for _, server_name in ipairs(get_servers()) do
	require("lspconfig")[server_name].setup({})
end

---
-- Diagnostic config
---

require("lsp-zero").set_sign_icons()
vim.diagnostic.config(require("lsp-zero").defaults.diagnostics({
	virtual_text = false,
}))

require("lsp_lines").setup()

---
-- Snippet config
---

require("luasnip").config.set_config({
	region_check_events = "InsertEnter",
	delete_check_events = "InsertLeave",
})

require("luasnip.loaders.from_vscode").lazy_load()

---
-- Autocompletion
---

vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require("cmp")
local cmp_config = require("lsp-zero").defaults.cmp_config({
	sources = {
		{ name = "path" },
		{ name = "treesitter" },
		{ name = "nvim_lsp", keyword_length = 1 },
		-- { name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},
})

cmp.setup(cmp_config)
