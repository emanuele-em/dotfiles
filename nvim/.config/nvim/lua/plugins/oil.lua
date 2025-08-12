return {
  "stevearc/oil.nvim",
  enabled = not vim.g.is_vscode,
  opts = {
    view_options = { show_hidden = true },
    confirmation = { border = "single" },
  },
  config = function(_, opts)
    require("oil").setup(opts)

    vim.keymap.set("n", "-", "<CMD>Oil<CR>")
  end,
}
