local builtin = require("code_action_menu")
vim.keymap.set("n", "<leader>a", builtin.open_code_action_menu, { desc = "code action menu" })
