local augroup = vim.api.nvim_create_augroup 
local autocmd = vim.api.nvim_create_autocmd 

autocmd("TextYankPost", { callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = "1000" }) end })
autocmd("BufWritePre", { pattern = "", command = ":%s/\\s\\+$//e" })
autocmd("BufWritePre", { pattern = "", command = ":silent lua vim.lsp.buf.format()" })
autocmd("BufEnter", { pattern = "", command = "set fo-=c fo-=r fo-=o" })
autocmd("Filetype", { pattern = {"xml", "html", "xhtml", "css", "scss", "javascript", "typescript", "yaml", "lua"}, command = "setlocal shiftwidth=2 tabstop=2" })
autocmd("Filetype", { pattern = {"python", "rst", "c", "cpp"}, command = "set colorcolumn=80" })
autocmd("Filetype", { pattern = {"gitcommit", "markdown", "text"}, callback = function() vim.opt_local.wrap = true vim.opt_local.spell = true end })
