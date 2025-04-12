local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.local/share/nvim/plugged')

------------------------------------------------------------------------------------------ Foundational
if not vim.g.vscode then
  Plug 'nvim-lua/plenary.nvim'
end

------------------------------------------------------------------------------------------ Language Features
if not vim.g.vscode then
  Plug 'nvim-treesitter/nvim-treesitter'
end

------------------------------------------------------------------------------------------ LSP
if not vim.g.vscode then
  Plug 'williamboman/mason.nvim'
  Plug 'zbirenbaum/copilot.lua'
end

------------------------------------------------------------------------------------------ Autocompletion

if not vim.g.vscode then
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
  Plug 'zbirenbaum/copilot-cmp'
  Plug 'hrsh7th/cmp-cmdline'
end

------------------------------------------------------------------------------------------ Formatter

-- Plug ('prettier/vim-prettier', { ['do'] = 'yarn install --frozen-lockfile --production' })
-- Plug 'mhartington/formatter.nvim'
------------------------------------------------------------------------------------------ Snippets
if not vim.g.vscode then
  Plug('L3MON4D3/LuaSnip', { tag = 'v2.*', ['do'] = 'make install_jsregexp' })
  Plug 'rafamadriz/friendly-snippets'
end

------------------------------------------------------------------------------------------ LSP trouble
if not vim.g.vscode then
  Plug 'folke/trouble.nvim' -- lsp trouble
end

------------------------------------------------------------------------------------------ Misc and additional
if not vim.g.vscode then
  Plug 'rrethy/vim-illuminate'       -- highlight all instances of word under cursor
  Plug 'windwp/nvim-autopairs'       -- autopairs
  Plug 'norcalli/nvim-colorizer.lua' -- colorize hex code like #ff0000
end

------------------------------------------------------------------------------------------ themes
if not vim.g.vscode then
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'ellisonleao/gruvbox.nvim'               -- color scheme
  Plug 'projekt0n/github-nvim-theme'            -- color scheme
  Plug('j-hui/fidget.nvim', { tag = 'legacy' }) -- lsp bottom right status
end

------------------------------------------------------------------------------------------ Navigation
if not vim.g.vscode then
  Plug('nvim-telescope/telescope.nvim', { tag = '0.1.x' })
  Plug 'airblade/vim-gitgutter' -- show git diff in sign column
  Plug 'tpope/vim-surround'     -- surround text with brackets
  Plug 'jiaoshijie/undotree'
  Plug 'stevearc/oil.nvim'
end


------------------------------------------------------------------------------------------ Movements
if not vim.g.vscode then
  Plug 'phaazon/hop.nvim' -- jump to word in the buffer
end

vim.call('plug#end')

-- Basic behavior
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

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.showmatch = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.joinspaces = true
vim.opt.ignorecase = true
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.wildmode = { 'list', 'longest' }
vim.opt.laststatus = 3
vim.opt.statusline = "%#TabLineSel#%f %#TabLine#%=[%l,%v] %p%%"
vim.opt.breakindent = true
vim.opt.signcolumn = 'yes'
vim.opt.autochdir = false
vim.opt.formatoptions:remove('cro')
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.scrolloff = 8
vim.o.background = "dark"
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.opt.list = true
vim.opt.listchars:append "eol:↴"
vim.opt.shell = "/bin/bash"

-- maps
vim.g.mapleader = " "
vim.keymap.set('n', '<SPACE>', '')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '<Leader>tt', ':tabnew<cr>')
vim.keymap.set('n', '<Leader>tn', ':tabnext<cr>')
vim.keymap.set('n', '<Leader>tp', ':tabprevious<cr>')
vim.keymap.set('n', '<Leader>tw', ':tabclose<cr>')
vim.keymap.set('n', '<Leader>bb', ':enew<cr>')
vim.keymap.set('n', '<Leader>bn', ':bnext<cr>')
vim.keymap.set('n', '<Leader>bp', ':bprev<cr>')
vim.keymap.set('n', '<Leader>bd', ':bdelete<cr>')
vim.keymap.set('', '<Leader>y', '"+y')
vim.keymap.set('', '<Leader>p', '"+p')


------------------------------------------------------------------------------------------ Language Features
-- treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "lua", "rust", "python", "cpp", "javascript", "latex", "typescript", "markdown_inline" },
  ignore_install = {},
  modules = {},
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "helm" },
  },
})

------------------------------------------------------------------------------------------ Language Server
require('copilot').setup({
  suggestion = {
    enabled = false,
  },
  panel = { enabled = false },
})

require('mason').setup()
vim.lsp.config.denols = {
  cmd = { "deno", "lsp" },
  root_markers = { "deno.json", "deno.jsonc" },
  single_file_support = false,
}

vim.lsp.config.ts_sl = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = {
    "tsconfig.json",
    "jsconfig.json",
    "package.json",
  },
  single_file_support = false
}

vim.lsp.config.intelephense = {
  root_markers = { 'composer.json' },
  filetypes = { "php" }
}

vim.lsp.config.json = {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
}

vim.lsp.config.prettierd = {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" }
}

vim.lsp.config.pyright = {
  filetypes = { "python" }
}

vim.lsp.config.rust_analyzer = {
  filetypes = { "rust" }
}

vim.lsp.config.volar = {
  filetypes = { "vue" }
}

vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        disable = { "lowercase-global" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/love2d/library",
        },
      },
    },
  }
}

vim.lsp.enable({ 'denols', 'ts_sl', 'lua_ls', 'json', 'prettierd', 'pyright', 'rust_analyzer', 'volar', 'intelephense' })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local bufnr = ev.buf
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<C-Space>', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- Uncomment the following if you want to set up formatting:
    -- vim.keymap.set('n', '<space>fo', function()
    --   vim.lsp.buf.format({ async = true })
    -- end, opts)
  end
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*", -- or specify a list of filetypes, e.g., {"*.js", "*.ts", "*.py"}
  callback = function()
    vim.lsp.buf.format({
      async = false, -- You can set this to true if you prefer asynchronous formatting
    })
  end,
})



vim.o.completeopt = "menu,noinsert,popup,fuzzy"

local pumMaps = {
  ['<Down>'] = '<C-n>',
  ['<Up>'] = '<C-p>',
}
for insertKmap, pumKmap in pairs(pumMaps) do
  vim.keymap.set('i', insertKmap, function()
    return vim.fn.pumvisible() == 1 and pumKmap or insertKmap
  end, { expr = true })
end



------------------------------------------------------------------------------------------ Debugger

------------------------------------------------------------------------------------------ Autocompletion

-- Plug 'hrsh7th/nvim-cmp'
-- Plug 'hrsh7th/cmp-buffer'
-- Plug 'hrsh7th/cmp-path'
-- Plug 'saadparwaiz1/cmp_luasnip'
-- Plug 'hrsh7th/cmp-nvim-lsp'
-- Plug 'hrsh7th/cmp-nvim-lua'
-- Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
-- Plug 'zbirenbaum/copilot-cmp'
require("copilot_cmp").setup()
local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = 'copilot',    priority = 1000 },
    { name = 'treesitter', priority = 800 },
    { name = 'path',       priority = 300 },
    { name = 'nvim_lsp',   priority = 200 },
    { name = 'luasnip' },
    { name = 'buffer',     keyword_length = 3 },
  },
  -- formatting = cmp_format,
  mapping = cmp.mapping.preset.insert({
    ['<c-p>'] = cmp.mapping.select_prev_item(),
    ['<c-n>'] = cmp.mapping.select_next_item(),
    ['<cr>'] = cmp.mapping.confirm({ select = false }),
    ['<c-c>'] = cmp.mapping.complete(),
    ['<c-e>'] = cmp.mapping.close(),
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  }
})

-- Plug 'hrsh7th/cmp-cmdline'
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})

vim.diagnostic.config({
  virtual_text = true
})



------------------------------------------------------------------------------------------ Formatter
-- local util = require "formatter.util"
-- local defaults = require("formatter.defaults")
-- vim.keymap.set('n', '<leader>fo', '<Plug>(Prettier)')
-- require('formatter').setup({
--   logging = true,
--   filetype = {
--     javascript = { util.copyf(defaults.prettierd) },
--   }
-- })

-- vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   group = "FormatAutogroup",
--   command = "FormatWrite",
-- })

------------------------------------------------------------------------------------------ LSP trouble / diagnostics
-- Plug 'folke/trouble.nvim' -- lsp trouble
require('trouble').setup()
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble diagnostics toggle<cr>", { silent = true, noremap = true })

vim.diagnostic.config({
  virtual_lines = true
})

------------------------------------------------------------------------------------------ Misc and additional

-- Plug 'zbirenbaum/copilot.lua'
-- Plug 'rrethy/vim-illuminate' -- highlight all instances of word under cursor
require('illuminate').configure({
  providers = {
    -- 'lsp',
    -- 'treesitter',
    'regex',
  },
  delay = 0,
  filetype_overrides = {},
  filetypes_denylist = {
    'dirvish',
    'fugitive',
  },
  filetypes_allowlist = {},
  modes_denylist = {},
  modes_allowlist = {},
  providers_regex_syntax_denylist = {},
  providers_regex_syntax_allowlist = {},
  under_cursor = true,
  large_file_cutoff = nil,
  large_file_overrides = nil,
  min_count_to_highlight = 1,
})

-- Plug 'windwp/nvim-autopairs' -- autopairs
require("nvim-autopairs").setup({
  enable_check_bracket_line = true, --Don't add pairs if it already has a close pair in the same line
  check_ts = true,
  ignored_next_char = "[%w%.]",     -- will ignore alphanumeric and `.` symbol
  disable_filetype = { "TelescopePrompt", "tex", "latex" },
})
-- Plug 'norcalli/nvim-colorizer.lua' -- colorize hex code like #ff0000
require('colorizer').setup()


------------------------------------------------------------------------------------------ themes

-- Plug 'ryanoasis/vim-devicons' -- icons
-- Plug 'ellisonleao/gruvbox.nvim' -- color scheme
require('gruvbox').setup({
  contrast = 'hard',
})


require("fidget").setup {}

------------------------------------------------------------------------------------------ Navigation

-- Plug('nvim-telescope/telescope.nvim', { ['tag']= '0.1.x' })
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Plug Plug 'jiaoshijie/undotree' -- undo tree
require('undotree').setup()
vim.keymap.set('n', '<leader>u', require('undotree').toggle, { noremap = true, silent = true })

-- Plug 'stevearc/oil.nvim' -- navigation through buffer
require("oil").setup({
  delete_to_trash = true,
  view_options = {
    show_hidden = true
  }
})
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = "Open parent directory" })

------------------------------------------------------------------------------------------ Movements
-- Plug 'phaazon/hop.nvim' -- jump to word in the buffer
local hop = require('hop')
hop.setup()
vim.keymap.set('', '<Leader>gw',
  function() hop.hint_words({ direction = require('hop.hint').HintDirection.AFTER_CURSOR }) end, {})
vim.keymap.set('', '<Leader>gb',
  function() hop.hint_words({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR }) end, {})
