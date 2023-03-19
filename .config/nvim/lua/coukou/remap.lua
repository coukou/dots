vim.g.mapleader = " "
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.keymap.set("n", "?", function()
    vim.diagnostic.open_float()
end, { desc = "show diagnostic in float" })
