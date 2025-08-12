return {
  "nvim-telescope/telescope.nvim",
  enabled = not vim.g.is_vscode,
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  opts = {
    -- defaults = {
    --   layout_config = { preview_width = 80 },
    --   preview = { hide_on_startup = true },
    --   borderchars = {
    --     prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    --     results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    --     preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    --   },
    --   mappings = {
    --     -- i = { ["<C-h>"] = require("telescope.actions.layout").toggle_preview },
    --   },
    -- },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("fzf")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<Leader>ff", builtin.find_files)
    vim.keymap.set("n", "<Leader>fg", builtin.live_grep)
    vim.keymap.set("n", "<Leader>fs", builtin.grep_string)
    vim.keymap.set("n", "<Leader>fr", builtin.lsp_references)
    -- vim.keymap.set("n", "<space>fu", function() require("telescope.builtin").git_files({ show_untracked = true }) end)
  end,
}
