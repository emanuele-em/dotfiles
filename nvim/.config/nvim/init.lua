local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.local/share/nvim/plugged')

------------------------------------------------------------------------------------------ Foundational
if not vim.g.vscode then
Plug 'nvim-lua/plenary.nvim'
end

------------------------------------------------------------------------------------------ Language Features
if not vim.g.vscode then
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate'})
end

------------------------------------------------------------------------------------------ LSP
if not vim.g.vscode then
Plug ('VonHeikemen/lsp-zero.nvim', {branch = 'v3.x'})
Plug ('williamboman/mason.nvim', { ['do'] = ':MasonUpdate'}) -- to install language servers
Plug 'williamboman/mason-lspconfig.nvim' -- to install language servers
Plug 'neovim/nvim-lspconfig' -- language server
Plug 'zbirenbaum/copilot.lua'
Plug ('CopilotC-Nvim/CopilotChat.nvim', { branch = 'canary' })
Plug ('towolf/vim-helm')
end

------------------------------------------------------------------------------------------ Autocompletion

if not vim.g.vscode then
Plug 'hrsh7th/nvim-cmp' 
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'zbirenbaum/copilot-cmp'
end

------------------------------------------------------------------------------------------ Formatter

Plug ('prettier/vim-prettier', { ['do'] = 'yarn install --frozen-lockfile --production' })
------------------------------------------------------------------------------------------ Snippets
if not vim.g.vscode then
Plug ('L3MON4D3/LuaSnip', {tag = 'v2.*', ['do'] = 'make install_jsregexp'})
Plug 'rafamadriz/friendly-snippets'
end

------------------------------------------------------------------------------------------ LSP trouble
if not vim.g.vscode then
Plug 'folke/trouble.nvim' -- lsp trouble
end

------------------------------------------------------------------------------------------ Misc and additional
if not vim.g.vscode then
Plug 'ThePrimeagen/harpoon' -- to save and jump to bookmarks
Plug 'rrethy/vim-illuminate' -- highlight all instances of word under cursor
Plug 'windwp/nvim-autopairs' -- autopairs
Plug 'norcalli/nvim-colorizer.lua' -- colorize hex code like #ff0000
Plug 'hrsh7th/cmp-cmdline'
end
-- Plug 'numToStr/Comment.nvim' -- comment with gcc shrot cut

------------------------------------------------------------------------------------------ themes
if not vim.g.vscode then
Plug 'ryanoasis/vim-devicons' -- icons
Plug 'ellisonleao/gruvbox.nvim' -- color scheme
Plug 'projekt0n/github-nvim-theme' -- color scheme 
Plug ('j-hui/fidget.nvim', { tag = 'legacy' })  -- lsp bottom right status
end

------------------------------------------------------------------------------------------ Navigation
if not vim.g.vscode then
Plug('nvim-telescope/telescope.nvim', {tag = '0.1.x' })
Plug 'airblade/vim-gitgutter' -- show git diff in sign column
Plug 'tpope/vim-surround' -- surround text with brackets
Plug 'jiaoshijie/undotree'
end

------------------------------------------------------------------------------------------Latex
if not vim.g.vscode then
Plug 'lervag/vimtex' -- compile latex
end

------------------------------------------------------------------------------------------ Productivity
if not vim.g.vscode then
Plug 'folke/zen-mode.nvim'
end

------------------------------------------------------------------------------------------ Movements
if not vim.g.vscode then
Plug 'phaazon/hop.nvim' -- jump to word in the buffer
end

vim.call('plug#end')

-- Basic behavior
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
vim.opt.wildmode = {'list', 'longest'}
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
vim.g.netrw_liststyle=3
vim.g.netrw_banner = 0
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 50) 
vim.opt.list = true
vim.opt.listchars:append "eol:↴"

-- maps
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
vim.keymap.set('', '<Leader>y', '"+y')
vim.keymap.set('', '<Leader>p', '"+p')

------------------------------------------------------------------------------------------ Language Features
-- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "rust", "python", "cpp", "javascript", "latex", "typescript", "markdown_inline"},
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {"helm"},
  },
}


------------------------------------------------------------------------------------------ Language Server
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
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
    -- vim.keymap.set('n', '<space>fo', function()
    --   vim.lsp.buf.format({ async = true })
    -- end, opts)
end)

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {'tsserver','pyright', 'jsonls', 'rust_analyzer'},
  handlers = {
    -- lsp_zero.default_setup,
    function(server_name)
      if server_name == 'tsserver' then
        server_name = 'ts_ls'
        lsp_zero.default_setup(server_name)
      else
        lsp_zero.default_setup(server_name)
      end
    end
  },
})

lsp_zero.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
})

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
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format()

cmp.setup({
    sources = {
      { name = 'copilot'},
      { name = 'nvim_lsp'},
      { name = 'luasnip'},
      { name = 'buffer', keyword_length = 3},
      { name = 'path'},
    },
    formatting = cmp_format,
    mapping = cmp.mapping.preset.insert({
    ['<c-p>'] = cmp.mapping.select_prev_item(),
    ['<c-n>'] = cmp.mapping.select_next_item(),
    ['<cr>'] = cmp.mapping.confirm({select = false}),
    ['<c-c>'] = cmp.mapping.complete(),
    ['<c-e>'] = cmp.mapping.close(),
    }) 
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

local copilot_chat = require("CopilotChat").setup{
    debug = true,
}
vim.keymap.set({'n', 'x'}, '<leader>cc', ':CopilotChat<cr>', {noremap = true})

------------------------------------------------------------------------------------------ Formatter
vim.keymap.set('n', '<leader>fo', '<Plug>(Prettier)')

------------------------------------------------------------------------------------------ Snippets
-- Plug ('L3MON4D3/LuaSnip', {['tag'] = 'v2.*', ['do'] = 'make install_jsregexp'})
-- Plug 'rafamadriz/friendly-snippets'
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.filetype_extend("vue", {"vue"})
vim.keymap.set({"i"}, "<Tab>", function() 
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n")
    end
end, {silent = true})
vim.keymap.set({"i", "s"}, "<Tab>", function() 
    if luasnip.jumpable(1) then
        luasnip.jump(1)
    else
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n")
    end
end, {silent = true})
vim.keymap.set({"i", "s"}, "<S-Tab>", function() 
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "n")
    end
end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-e>", function() if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end, {silent = true})

------------------------------------------------------------------------------------------ LSP trouble
-- Plug 'folke/trouble.nvim' -- lsp trouble
require('trouble').setup()
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble diagnostics toggle<cr>", {silent = true, noremap = true})

------------------------------------------------------------------------------------------ Misc and additional

-- Plug 'zbirenbaum/copilot.lua'
require('copilot').setup({
    suggestion = {
        enabled = false,
        auto_trigger = false,
    },
    panel = { enabled = false },
})

-- Plug 'ThePrimeagen/harpoon' -- to save and jump to bookmarks
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<C-a>", mark.add_file)
vim.keymap.set("n", "<C-d>", ui.toggle_quick_menu)
vim.keymap.set("n", "<C-n>", function() ui.nav_prev() end)
vim.keymap.set("n", "<C-p>", function() ui.nav_next() end)

-- Plug 'numToStr/Comment.nvim' -- comment with gcc shrot cut
-- require('Comment').setup()

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
    ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
    disable_filetype = { "TelescopePrompt" , "tex", "latex" },
})
-- Plug 'norcalli/nvim-colorizer.lua' -- colorize hex code like #ff0000
require('colorizer').setup()


------------------------------------------------------------------------------------------ themes

-- Plug 'ryanoasis/vim-devicons' -- icons
-- Plug 'ellisonleao/gruvbox.nvim' -- color scheme
require('gruvbox').setup({
    contrast = 'hard',
})
vim.cmd([[
autocmd FileType * set formatoptions-=cro
colorscheme gruvbox
highlight illuminatedWordText gui=underline
]])

require("fidget").setup{}

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

-------------------------------------------------------------------------------------------Latex
-- Plug 'lervag/vimtex' -- compile latex

------------------------------------------------------------------------------------------ Productivity
-- Plug 'folke/zen-mode.nvim'
require('zen-mode').setup{
    window = {
        width = 120,
        options = { }
    }
}

------------------------------------------------------------------------------------------ Movements
-- Plug 'phaazon/hop.nvim' -- jump to word in the buffer
local hop = require('hop')
hop.setup()
vim.keymap.set('', '<Leader><Leader>w', function() hop.hint_words({ direction = require('hop.hint').HintDirection.AFTER_CURSOR}) end, {})
vim.keymap.set('', '<Leader><Leader>b', function() hop.hint_words({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR}) end, {})

