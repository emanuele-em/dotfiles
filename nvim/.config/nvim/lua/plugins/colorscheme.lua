return {
  {
    "ellisonleao/gruvbox.nvim",
    enabled = not vim.g.is_vscode,
    priority = 1000,
    lazy = false,
    opts = {
      contrast = 'hard'
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      vim.cmd([[
  autocmd FileType * set formatoptions-=cro
  colorscheme gruvbox
  set cursorline
  highlight Normal guibg=None
  highlight SignColumn guibg=None
  highlight illuminatedWordText guibg=#3c3836
  highlight CursorLine guibg=#101010 guifg=NONE
  autocmd FileType vue setlocal commentstring=<!--\ %s\ -->
]])
    end,
  },
  { 
    "nvim-tree/nvim-web-devicons", 
    enabled = not vim.g.is_vscode,
    opts = {} 
  },
}
