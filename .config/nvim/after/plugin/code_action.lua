local builtin = require("code_action_menu")
vim.keymap.set('n', '<C-.>', builtin.open_code_action_menu, {})
