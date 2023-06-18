local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",  lazypath})
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.opt.termguicolors = true 

require("lazy").setup({
    root = vim.fn.stdpath("data") .. "/lazy", 
    spec = {{{ import = "plugins" }, { import = "plugins.custom" }}},
    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", 
    defaults = { lazy = false,  version = nil },
    install = { missing = true, colorscheme = {"tokyonight"} },
    checker = { enabled = true, notify = false, frequency = 86400 },
    change_detection = { enabled = true, notify = false },
    performance = { cache = { enabled = true } },
    state = vim.fn.stdpath("state") .. "/lazy/state.json" 
})

local modules = {"config.autocmds", "config.options", "config.keymaps", "config.custom"}
for _, mod in ipairs(modules) do
    local ok, err = pcall(require, mod)
    if not ok then
        error(("Error loading %s...\n\n%s"):format(mod, err))
    end
end
