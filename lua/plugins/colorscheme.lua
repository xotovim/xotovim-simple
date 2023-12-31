return {
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup({
        options = {
          compile_path = vim.fn.stdpath('cache') .. '/github-theme',
          compile_file_suffix = '_compiled', 
          hide_end_of_buffer = true, 
          hide_nc_statusline = true, 
          transparent = false,       
          terminal_colors = true,    
          dim_inactive = false,      
          module_default = true,     
          styles = {                 
          comments = 'italic',
          keywords = 'bold',
          types = 'italic,bold',
            functions = 'NONE',
            variables = 'NONE',
            conditionals = 'NONE',
            constants = 'NONE',
            numbers = 'NONE',
            operators = 'NONE',
            strings = 'NONE',
          },
          inverse = {                
            match_paren = false,
            visual = false,
            search = false,
          },
          darken = {                 
            floats = false,
            sidebars = {
              enable = true,
              list = {},             
            },
          },
          modules = {                
          },
        },
        palettes = {},
        specs = {},
        groups = {},
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
        buftype_exclude = { "terminal", "telescope", "nofile" },
        filetype_exclude = { "help", "dashboard", "packer", "NvimTree", "Trouble", "TelescopePrompt", "Float" },
        show_current_context = true,
        show_current_context_start = false,
        show_end_of_line = false,
        show_trailing_blankline_indent = false,
        space_char_blankline = " ",
        use_treesitter = true,
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = { comments = "NONE", keywords = "italic", functions = "NONE", variables = "NONE", sidebars = "dark", floats = "dark", },
      sidebars = { "qf", "help" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,
      on_colors = function(colors)
        colors.border = "#1A1B26"
      end,
      on_highlights = function(hl, _color)
        local prompt = "#FFA630"
        local text = "#488dff"
        local none = "NONE"
        hl.TelescopeTitle = { fg = prompt, }
        hl.TelescopeNormal = { bg = none, fg = none, }
        hl.TelescopeBorder = { bg = none, fg = text, }
        hl.TelescopeMatching = { fg = prompt, }
      end,
    }
  } }
