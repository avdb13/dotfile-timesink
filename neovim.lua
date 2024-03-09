local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local lspconfig = require("lspconfig")
local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.taplo.setup {}

require("autoclose").setup()
require("colorizer").setup(
    {
        filetypes = {"*"},
        user_default_options = {
            RRGGBBAA = true,
            AARRGGBB = true,
            css = true,
            mode = "background",
            tailwind = true,
            sass = {enable = true, parsers = {"css"}},
            always_update = false
        }
    }
)
require("transparent").setup(
    {
        groups = {
            "Normal",
            "NormalNC",
            "Comment",
            "Constant",
            "Special",
            "Identifier",
            "Statement",
            "PreProc",
            "Type",
            "Underlined",
            "Todo",
            "String",
            "Function",
            "Conditional",
            "Repeat",
            "Operator",
            "Structure",
            "LineNr",
            "NonText",
            "SignColumn",
            "CursorLine",
            "CursorLineNr",
            "StatusLine",
            "StatusLineNC",
            "EndOfBuffer"
        },
        extra_groups = {},
        exclude_groups = {}
    }
)

cmp.setup(
    {
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end
        },
        mapping = cmp.mapping.preset.insert(
            {
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({select = true}),
                ["<Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif vim.fn["vsnip#available"](1) == 1 then
                            feedkey("<Plug>(vsnip-expand-or-jump)", "")
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end,
                    {"i", "s"}
                ),
                ["<S-Tab>"] = cmp.mapping(
                    function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                            feedkey("<Plug>(vsnip-jump-prev)", "")
                        end
                    end,
                    {"i", "s"}
                )
            }
        ),
        sources = cmp.config.sources(
            {
                {name = "nvim_lsp"},
                {name = "vsnip"}
            },
            {
                {name = "buffer"}
            }
        )
    }
)

cmp.setup.filetype(
    "gitcommit",
    {
        sources = cmp.config.sources(
            {
                {name = "git"}
            },
            {
                {name = "buffer"}
            }
        )
    }
)

cmp.setup.cmdline(
    ":",
    {
        sources = cmp.config.sources(
            {
                {name = "path"}
            },
            {
                {name = "cmdline"}
            }
        )
    }
)

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd(
    "LspAttach",
    {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
            vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
            local opts = {buffer = ev.buf}
            vim.keymap.set("n", "<leader>d", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "<leader>D", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>I", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "<leader>T", vim.lsp.buf.type_definition, opts)
            vim.keymap.set(
                "n",
                "<leader>f",
                function()
                    vim.lsp.buf.format {async = true}
                end,
                opts
            )
        end
    }
)

vim.g.rustaceanvim = {
    server = {
        capabilities = capabilities
    },
    tools = {
        reload_workspace_from_cargo_toml = true,
        inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment"
        },
        hover_actions = {
            border = {
                {"╭", "FloatBorder"},
                {"─", "FloatBorder"},
                {"╮", "FloatBorder"},
                {"│", "FloatBorder"},
                {"╯", "FloatBorder"},
                {"─", "FloatBorder"},
                {"╰", "FloatBorder"},
                {"│", "FloatBorder"}
            },
            max_width = nil,
            max_height = nil,
            auto_focus = false
        },
        crate_graph = {
            backend = "x11",
            output = nil,
            full = true,
            enabled_graphviz_backends = {
                "x11"
            }
        }
    },
    server = {
        standalone = false,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = true,
                imports = {
                    granularity = {
                        enable = "true",
                        group = "crate"
                    }
                },
                cargo = {
                    buildScripts = {
                        enable = true
                    }
                },
                procMacro = {
                    enable = true
                },
                diagnostics = {
                    experimental = {
                        enable = true
                    }
                }
            }
        },
        autostart = true
    }
}
