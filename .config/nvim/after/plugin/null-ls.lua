local null_ls = require("null-ls")

require("mason-null-ls").setup({})

require("mason-null-ls").setup_handlers({
	function(source_name, methods)
		require("mason-null-ls.automatic_setup")(source_name, methods)
	end,
})

null_ls.setup()
