return {
  "saghen/blink.cmp",
  version = "*",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "fang2hou/blink-copilot",
  },
  opts = {
    cmdline = {
      completion = {
        menu = {
          auto_show = true
        }
      }
    },
    keymap = {
      preset = "default",
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-h>"] = { "hide", "fallback" },
      ["<C-s>"] = { "show", "fallback" },
      ["<C-n>"] = {
        function(cmp)
          cmp.select_next({ auto_insert = false })
        end,
        "fallback_to_mappings",
      },
      ["<C-p>"] = {
        function(cmp)
          cmp.select_prev({ auto_insert = false })
        end,
        "fallback_to_mappings",
      },
    },
    snippets = { preset = "luasnip" },
    completion = {
      menu = {
        border = "single",
        draw = {
          columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' }
          },
        }
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        window = { border = "single" },
      },
    },
    signature = {
      enabled = true,
      window = {
        border = "single",
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    sources = {
      default = { "lazydev", "copilot", "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        sql = { "snippets", "dadbod", "buffer" },
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
        dadbod = {
          name = "Dadbod",
          module = "vim_dadbod_completion.blink",
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
