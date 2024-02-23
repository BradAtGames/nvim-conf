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
        "zbirenbaum/copilot-cmp"
    },

    config = function()
        local c = require("cmp")
        local cc = require("copilot_cmp")
        local cnl = require("cmp_nvim_lsp")
        local caps =
            vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cnl.default_capabilities())
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "ansiblels",
                "bufls",
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

                ["clangd"] = function()
                    local lsp = require("lspconfig")
                    lsp.clangd.setup({
                        capabilities = caps,
                        filetypes = { "c", "cc", "cpp", "objc", "objcpp" },
                        cmd = {
                            "clangd",
                            "--background-index",
                            "--clang-tidy",
                            "--completion-style=detailed",
                            "--header-insertion=iwyu",
                            "--header-insertion-decorators",
                            "--suggest-missing-includes",
                            "--cross-file-rename",
                            "--clang-tidy",
                            "--clang-tidy-checks=-*,modernize-*",
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
        cc.setup()
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
                { name = "copilot" },
                { name = "snippy" },
            }),
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('LspKeymaps', {}),
            callback = function(ev)
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
            end,
        })
    end,
}
