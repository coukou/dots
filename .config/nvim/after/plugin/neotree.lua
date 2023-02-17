local neotree = require("neo-tree")

neotree.setup({
    close_if_last_window = false,
})


vim.cmd([[nnoremap \ :Neotree reveal<cr>]])

