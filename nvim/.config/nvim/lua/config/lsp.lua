-- vim.lsp.config.denols = {
--   cmd = { "deno", "lsp" },
--   root_markers = { "deno.json", "deno.jsonc" },
--   single_file_support = false,
-- }

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
