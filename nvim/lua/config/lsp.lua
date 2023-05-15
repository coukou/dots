local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local lspzero = require("lsp-zero")

lspzero.extend_lspconfig({
	on_attach = function(client, bufnr)
		local opts = { buffer = bufnr, noremap = true, silent = true }

		local maps = {
			["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
			["?"] = { "<cmd>lua vim.diagnostic.open_float({scope = 'line'})<CR>", "cursor diagnostics" },
			["<leader>l"] = {
				name = "Lsp",
				a = { "<cmd>lua require('code_action_menu').open_code_action_menu()<CR>", "Code Action" },
				d = { "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", "Definition" },
				D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
				i = { "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", "Implementation" },
				k = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
				h = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Help" },
				n = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
				r = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", "References" },
				l = { "<cmd>lua vim.diagnostic.open_float({scope = 'line'})<CR>", "Show Diagnostics" },
				["="] = { "<cmd>lua vim.lsp.buf.format({ bufnr = bufnr })<CR>", "Format" },
			},
			["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev Diagnostics" },
			["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostics" }
		}

		require("which-key").register(maps, opts)

		-- Enable auto format on save
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

local get_servers = require("mason-lspconfig").get_installed_servers
for _, server_name in ipairs(get_servers()) do
	require("lspconfig")[server_name].setup({})
end

---
-- Diagnostic config
---

lspzero.set_sign_icons()
vim.diagnostic.config(lspzero.defaults.diagnostics({
	virtual_text = true,
}))

---
-- Snippet config
---

require("luasnip").config.set_config({
	region_check_events = "InsertEnter",
	delete_check_events = "InsertLeave",
})

require("luasnip.loaders.from_vscode").lazy_load()
