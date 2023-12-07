local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.local/share/nvim/plugged')
-- themes
Plug 'ryanoasis/vim-devicons' -- icons
Plug 'nvim-tree/nvim-web-devicons' -- file icons
Plug 'ellisonleao/gruvbox.nvim' -- color scheme

-- others
Plug 'nvim-lua/plenary.nvim' -- required for telescope
Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn[':TSUpdate']})
-- lsp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip' 
Plug 'zbirenbaum/copilot.lua'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp' 
Plug 'zbirenbaum/copilot-cmp'

Plug('nvim-telescope/telescope.nvim', { ['tag']= '0.1.x' })
Plug 'airblade/vim-gitgutter' -- show git diff in sign column
Plug 'tpope/vim-surround' -- surround text with brackets
Plug('williamboman/mason.nvim', { ['do'] = vim.fn[':MasonUpdate'] }) -- to install language servers
Plug 'ThePrimeagen/harpoon' -- to save and jump to bookmarks
Plug 'numToStr/Comment.nvim' -- comment with gcc shrot cut
Plug 'rrethy/vim-illuminate' -- highlight all instances of word under cursor
Plug 'windwp/nvim-autopairs' -- autopairs
Plug 'norcalli/nvim-colorizer.lua' -- colorize hex code like #ff0000
Plug 'lervag/vimtex' -- compile latex
Plug 'neovim/nvim-lspconfig' -- language server
Plug 'williamboman/mason-lspconfig.nvim' -- to install language servers
Plug('j-hui/fidget.nvim', { ['tag']= 'legacy' })  -- lsp bottom right status
Plug 'folke/trouble.nvim' -- lsp trouble
Plug 'simrat39/rust-tools.nvim' -- rust tools
Plug 'folke/zen-mode.nvim'
Plug 'phaazon/hop.nvim' -- jump to word in the buffer
vim.call('plug#end')

-- Basic behavior
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.showmatch = true
vim.opt.tabstop=4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.joinspaces = true
vim.opt.ignorecase = true
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.wildmode = {'list', 'longest'}
vim.opt.laststatus = 3
vim.opt.breakindent = true
vim.opt.signcolumn = 'yes'
vim.opt.autochdir = false
vim.opt.formatoptions:remove('cro')
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.scrolloff = 8
vim.o.background = "dark"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- gruvobx
require('gruvbox').setup({
    contrast_dark = 'soft',
})

-- colorizer
require('colorizer').setup()

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 50) 

vim.cmd([[
autocmd FileType * set formatoptions-=cro
colorscheme gruvbox
highlight illuminatedWordText guibg=#504945
]])

-- copilot
require('copilot').setup({
    suggestion = {
        enabled = false,
        auto_trigger = false,
    },
    panel = { enabled = false },
})


--auto pairs
require("nvim-autopairs").setup({
    enable_check_bracket_line = true, --Don't add pairs if it already has a close pair in the same line
    check_ts = true,
    ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
    disable_filetype = { "TelescopePrompt" , "tex", "latex" },
})

-- telescope
local builtin = require('telescope.builtin')

-- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

--zen mode
require('zen-mode').setup{}


-- trouble
require('trouble').setup({
    icons = false,
})


-- Setup language servers.
require("mason").setup({
  ui = {
      icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = "",
      },
  }
})
require("mason-lspconfig").setup()
local lspconfig = require('lspconfig')
local rt = require("rust-tools")

rt.setup({
  server = {
    -- on_attach = function(_, bufnr)
      -- Hover actions
      -- vim.keymap.set("n", "<space>s", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      -- vim.keymap.set("n", "<space>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    -- end,
    checkOnSave = {
      allFeatures = true,
        overrideCommand = {
         "cargo",
         "clippy",
         "--workspace",
         "--message-format=json",
         "--all-targets",
         "--all-features",
        },
    },
  },
})
lspconfig.pyright.setup{}
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
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
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
-- lsp status with fidget
require("fidget").setup{}

require("copilot_cmp").setup()
-- Completion Plugin Setup && lspkind.lua
-- local lspkind = require("lspkind")
local cmp = require("cmp")
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    end),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-c>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'copilot', keyword_lengh = 0 },
    { name = 'path', keyword_length = 2 },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 2 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip'},         -- nvim-cmp source for vim-vsnip
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      require("copilot_cmp.comparators").prioritize,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done({
    tex = false
  })
)

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

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})


-- vim-illuminate
require('illuminate').configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
        -- 'lsp',
        -- 'treesitter',
        'regex',
    },
    -- delay: delay in milliseconds
    delay = 0,
    -- filetype_overrides: filetype specific overrides.
    -- The keys are strings to represent the filetype while the values are tables that
    -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
    filetype_overrides = {},
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
        'dirvish',
        'fugitive',
    },
    -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
    filetypes_allowlist = {},
    -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
    -- See `:help mode()` for possible values
    modes_denylist = {},
    -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
    -- See `:help mode()` for possible values
    modes_allowlist = {},
    -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_denylist = {},
    -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_allowlist = {},
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
    -- large_file_cutoff: number of lines at which to use large_file_config
    -- The `under_cursor` option is disabled when this cutoff is hit
    large_file_cutoff = nil,
    -- large_file_config: config to use for large files (based on large_file_cutoff).
    -- Supports the same keys passed to .configure
    -- If nil, vim-illuminate will be disabled for large files.
    large_file_overrides = nil,
    -- min_count_to_highlight: minimum number of matches required to perform highlighting
    min_count_to_highlight = 1,
})

-- treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "python", "cpp", "css", "javascript", "json", "latex", "markdown", "markdown_inline", "svelte", "swift", "yaml"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
-- commenter
require('Comment').setup()

-- hop / easymotion
local hop = require('hop')
hop.setup()

-- indent indent-blankline
vim.opt.list = true
vim.opt.listchars:append "eol:↴"

-- map
vim.g.mapleader = " "
vim.keymap.set('n', '<SPACE>', '')
vim.keymap.set('n', 'J', '5j')
vim.keymap.set('n', '<Leader>j', 'J')
vim.keymap.set('n', 'K', '5k')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '<Leader>tt', ':tabnew<cr>')
vim.keymap.set('n', '<Leader>tn', ':tabnext<cr>')
vim.keymap.set('n', '<Leader>tp', ':tabprevious<cr>')
vim.keymap.set('n', '<Leader>td', ':tabclose<cr>')
vim.keymap.set('n', '<Leader>bb', ':enew<cr>')
vim.keymap.set('n', '<Leader>bn', ':bnext<cr>')
vim.keymap.set('n', '<Leader>bp', ':bprev<cr>')
vim.keymap.set('n', '<Leader>bd', ':bdelete<cr>')
vim.keymap.set("n", "<C-a>", mark.add_file)
vim.keymap.set("n", "<C-d>", ui.toggle_quick_menu)
vim.keymap.set("n", "<C-n>", function() ui.nav_prev() end)
vim.keymap.set("n", "<C-p>", function() ui.nav_next() end)
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('', '<Leader>y', '"+y')
vim.keymap.set('', '<Leader>p', '"+p')
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set('', '<Leader><Leader>w', function() hop.hint_words({ direction = require('hop.hint').HintDirection.AFTER_CURSOR}) end, {})
vim.keymap.set('', '<Leader><Leader>b', function() hop.hint_words({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR}) end, {})
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle workspace_diagnostics<cr>", {silent = true, noremap = true})
