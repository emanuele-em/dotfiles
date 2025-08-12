return {
  "nvim-treesitter/nvim-treesitter",
  enabled = not vim.g.is_vscode,
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
  opts = {
    ensure_installed = {
      "javascript",
      "typescript",
      "rust",
      "c",
      "lua",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "markdown_inline",
    },
    auto_install = true,
    highlight = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
