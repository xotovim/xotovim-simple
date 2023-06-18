return { 
{
    "neovim/nvim-lspconfig",
    event = {"BufReadPre", "BufNewFile"},
    lazy = true,
    dependencies = { 
    {"williamboman/mason.nvim"}, {"williamboman/mason-lspconfig.nvim"}, 
    {
        "hrsh7th/nvim-cmp",
        dependencies = {"L3MON4D3/LuaSnip", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path", "hrsh7th/cmp-buffer", "saadparwaiz1/cmp_luasnip"}
    }},
    opts = {
        autoformat = true,
        format = { formatting_options = nil, timeout_ms = nil },
        servers = { jsonls = {}, dockerls = {}, bashls = {}, gopls = {}, pyright = {}, vimls = {}, yamlls = {} },
        setup = {}
    },
    
    config = function(_, opts)
        local servers = opts.servers
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        local function setup(server) local server_opts = vim.tbl_deep_extend("force", { capabilities = vim.deepcopy(capabilities) }, servers[server] or {})
            if opts.setup[server] then
                if opts.setup[server](server, server_opts) then return end
            elseif opts.setup["*"] then
                if opts.setup["*"](server, server_opts) then return end
            end
            require("lspconfig")[server].setup(server_opts)
        end
        local mappings = require("mason-lspconfig.mappings.server")
        if not mappings.lspconfig_to_package.lua_ls then
            mappings.lspconfig_to_package.lua_ls = "lua-language-server"
            mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
        end
        local mlsp = require("mason-lspconfig")
        local available = mlsp.get_available_servers()
        local ensure_installed = {} 
        for server, server_opts in pairs(servers) do
            if server_opts then
                server_opts = server_opts == true and {} or server_opts
                if server_opts.mason == false or not vim.tbl_contains(available, server) then setup(server) else ensure_installed[#ensure_installed + 1] = server end
            end
        end
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = ensure_installed,
            automatic_installation = true
        })
        require("mason-lspconfig").setup_handlers({setup})
        local luasnip = require "luasnip"
        local cmp = require "cmp"
        cmp.setup {
            snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
            mapping = cmp.mapping.preset.insert({
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true
                },
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, {"i", "s"}),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {"i", "s"})
            }),
            sources = {
                { name = "nvim_lsp" }, 
                { name = "luasnip" }, 
                { name = "path" }, 
                { 
                name = "buffer", 
                option = {
                    get_bufnrs = function()
                        local buf = vim.api.nvim_get_current_buf()
                        local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                        if byte_size > 1024 * 1024 then return {} end
                        return {buf}
                    end
                }
            }}
        }
    end
}, 
{
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {"williamboman/mason.nvim", "nvim-lua/plenary.nvim"},
    lazy = false,
    config = function()
        local null_ls = require("null-ls")
        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics
        null_ls.setup({
            debug = false,
            sources = {formatting.prettier.with { extra_filetypes = {"toml"}, extra_args = {"--no-semi", "--single-quote", "--jsx-single-quote"} }, formatting.black.with { extra_args = {"--fast"} }, formatting.stylua, formatting.google_java_format, diagnostics.flake8}
        })
    end
}}
