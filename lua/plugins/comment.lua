return {{
    "numToStr/Comment.nvim",
    opts = {
        active = true,
        on_config_done = nil,
        padding = true,
        sticky = true,
        ignore = "^$",
        mappings = { basic = true, extra = true },
        toggler = { line = "mm", block = "mbm" },
        opleader = { line = "m", block = "mb" },
        extra = { above = "mO", below = "mo", eol = "mA" },
        pre_hook = pre_hook,
        post_hook = nil
    },
    config = function(_, opts)
        require("Comment").setup(opts)
    end
}}
