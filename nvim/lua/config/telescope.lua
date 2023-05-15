local opts = { noremap = true, silent = true }

local maps = {
	["<leader>f"] = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "find files" },
	["<leader>D"] = { "<cmd>lua require('telescope.builtin').diagnostics()<CR>", "diagnostics" },
}

require("which-key").register(maps, opts)
