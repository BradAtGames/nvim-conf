return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "dcampos/nvim-snippy",
        "dcampos/cmp-snippy",
        "jay-babu/mason-null-ls.nvim",
        "nvimtools/none-ls.nvim",
    },

    config = function()
        local c = require("cmp")
        local cnl = require("cmp_nvim_lsp")
        local caps =
            vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cnl.default_capabilities())
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "ansiblels",
                "clangd",
                "cmake",
                "docker_compose_language_service",
                "dockerls",
                "golangci_lint_ls",
                "gopls",
                "lua_ls",
                "rust_analyzer",
                "tsserver",
                "eslint",
            },

            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = caps,
                    })
                end,

                ["lua_ls"] = function()
                    local lsp = require("lspconfig")
                    lsp.lua_ls.setup({
                        capabilities = caps,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                },
                            },
                        },
                    })
                end,
            },
        })
        -- For mason supported stuff, that isn"t supported by mason-lspconfig.
        require("mason-null-ls").setup({
            ensure_installed = {
                "black",
                "golines",
                "gofumpt",
                "goimports",
                "goimports-reviser",
                "gomodifytags",
                "prettier",
                "prettierd",
            },
            handlers = {},
        })

        local selector = { behavior = c.SelectBehavior.Select }
        c.setup({
            snippet = {
                expand = function(args)
                    require("snippy").expand_snippet(args.body)
                end,
            },
            mapping = c.mapping.preset.insert({
                ["<Enter>"] = c.mapping({
                    i = function(fallback)
                        if c.visible() and c.get_active_entry() then
                            c.confirm({ behavior = c.ConfirmBehavior.Replace, select = false })
                        elseif require("copilot.suggestion").is_visible() then
                            require("copilot.suggestion").accept()
                        else
                            fallback()
                        end
                    end,
                    s = c.mapping.confirm({ select = true }),
                    c = c.mapping.confirm({ behavior = c.ConfirmBehavior.Replace, select = true }),
                }),
                ["<C-n>"] = c.mapping(function(fallback)
                    if c.visible() then
                        c.select_next_item({ behavior = selector })
                    elseif require("copilot.suggestion").is_visible() then
                        require("copilot.suggestion").next()
                    else
                        fallback()
                    end
                end, { "i", "s", "c" }),
                ["<C-p>"] = c.mapping(function(fallback)
                    if c.visible() then
                        c.select_prev_item({ behavior = selector })
                    elseif require("copilot.suggestion").is_visible() then
                        require("copilot.suggestion").prev()
                    else
                        fallback()
                    end
                end, { "i", "s", "c" }),
            }),
            sources = c.config.sources({
                { name = "nvim_lsp" },
                { name = "snippy" },
            }),
        })
    end,
}
