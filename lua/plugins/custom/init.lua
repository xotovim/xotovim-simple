return {
	{
		"folke/lsp-colors.nvim",
		config = function()
			require("lsp-colors").setup({
				Error = "#db4b4b",
				Warning = "#e0af68",
				Information = "#0db9d7",
				Hint = "#10B981"
			})
		end
	},
	
	{
		"mrjones2014/nvim-ts-rainbow",
		config = function()
			require("nvim-treesitter.configs").setup(

				{
					ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "typescript", "javascript" },
					highlight = {
						enable = true,
					},
					additional_vim_regex_highlighting = true,

					-- ...
					rainbow = {
						enable = true,
						-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
						extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
						max_file_lines = nil, -- Do not enable for files with more than n lines, int
						-- colors = {}, -- table of hex strings
						-- termcolors = {} -- table of colour name strings
					}
				}
			)
		end
	},
}
