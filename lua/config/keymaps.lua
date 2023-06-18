
vim.keymap.set("n", "<leader>q", ":qa!<CR>", {})
vim.keymap.set("n", "<leader>s", ":w<CR>", {})
vim.keymap.set("n", "<leader>wh", "<C-w>h", {})
vim.keymap.set("n", "<leader>wj", "<C-w>j", {})
vim.keymap.set("n", "<leader>wk", "<C-w>k", {})
vim.keymap.set("n", "<leader>wl", "<C-w>l", {})
vim.keymap.set("n", "<leader>r", ":so %<CR>", {})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", {}) 
vim.keymap.set("n", "<leader>nr", ":NvimTreeRefresh<CR>", {}) 
vim.keymap.set("n", "<leader>nf", ":NvimTreeFindFile<CR>", {}) 
vim.keymap.set("n", "<leader>tt", ":NeotermToggle<CR>", {})
