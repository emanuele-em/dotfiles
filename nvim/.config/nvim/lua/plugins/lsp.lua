return {
  {
    "williamboman/mason.nvim",
    enabled = not vim.g.is_vscode,
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "single",
        backdrop = 100,
      },
    },
    config = function(_, opts)
      local mason = require("mason")
      local mason_registry = require("mason-registry")

      mason.setup(opts)
      if mason_registry.refresh then
        mason_registry.refresh()
      end
    end,
  },
  {
    "folke/lazydev.nvim",
    enabled = not vim.g.is_vscode,
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
