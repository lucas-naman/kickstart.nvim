
-- File: lua/custom/plugins/go_lsp.lua
-- This file sets up the Go Language Server (gopls) and related features for Neovim.

return {
  -- nvim-lspconfig is the main plugin to configure LSP servers
  'neovim/nvim-lspconfig',
  dependencies = {
    -- mason.nvim for easy installation and management of language servers
    'williamboman/mason.nvim',
    -- mason-lspconfig.nvim for integrating Mason with nvim-lspconfig
    'williamboman/mason-lspconfig.nvim',
    -- Optional: nvim-cmp and its sources for autocompletion
    -- 'hrsh7th/nvim-cmp',
    -- 'hrsh7th/cmp-nvim-lsp',
    -- 'L3MON4D3/LuaSnip', -- For snippets
    -- 'saadparwaiz1/cmp_luasnip',
  },

  config = function()
    local lspconfig = require('lspconfig')
    local mason_lspconfig = require('mason-lspconfig')
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Optional: If you use nvim-cmp, you might pass its capabilities here for snippet support
    -- if require('cmp_nvim_lsp') then
    --   capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- end

    -- Define the on_attach function.
    -- This function runs every time a language server successfully attaches to a buffer.
    local on_attach = function(client, bufnr)
      -- Set keymaps for common LSP actions, scoped to the current buffer (bufnr)
      local buf_set_keymap = vim.keymap.set
      local opts = { noremap = true, silent = true, buffer = bufnr }

      -- Go to definition/declaration/type definition/implementation
      buf_set_keymap('n', 'gd', vim.lsp.buf.definition, opts)
      buf_set_keymap('n', 'gD', vim.lsp.buf.declaration, opts)
      buf_set_keymap('n', 'gt', vim.lsp.buf.type_definition, opts)
      buf_set_keymap('n', 'gi', vim.lsp.buf.implementation, opts)

      -- Hover (show documentation/type info)
      buf_set_keymap('n', 'K', vim.lsp.buf.hover, opts)

      -- Code actions (refactor, fix, etc.)
      buf_set_keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)

      -- Rename symbol
      buf_set_keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)

      -- Find references
      buf_set_keymap('n', 'gr', vim.lsp.buf.references, opts)

      -- Format on save (from previous interaction)
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('LspFormatGoOnSave', { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 1000 })
          end,
          desc = 'Format Go file on save using LSP',
        })
      end

      -- Optional: Configure Go-specific features like inlay hints
      if client.name == 'gopls' then
        vim.lsp.inlay_hint.enable(bufnr, true) -- Enable inlay hints for gopls
        -- You might want to map a toggle for inlay hints:
        -- buf_set_keymap('n', '<leader>gh', vim.lsp.inlay_hint.toggle, opts)
      end
    end

    -- Setup Mason to install language servers
    require('mason').setup()

    -- Configure mason-lspconfig to manage gopls
    mason_lspconfig.setup({
      ensure_installed = { 'gopls' }, -- Ensure gopls is installed automatically
    })

    -- Configure gopls using nvim-lspconfig
    lspconfig.gopls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "gopls" }, -- Specify the gopls command if it's not found in PATH
      settings = {
        gopls = {
          completeUnimported = true, -- Auto-import packages
          buildFlags = { "-tags=wiremock" }, -- Example: Add build tags if needed
          staticcheck = true, -- Enable static analysis by default
          gofumpt = true, -- Use gofumpt for formatting if available
          inlayHints = { -- Configure gopls inlay hints
            -- For a full list of inlay hint options, refer to gopls documentation
            -- (e.g., https://github.com/golang/tools/blob/master/gopls/doc/settings.md)
            -- For example: parameterNames: true, compositeLiterals: true, constantValues: true
          },
        },
      },
    })

     -- Add setup for lua_ls (Lua Language Server)
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          -- General Lua settings
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false, -- Disable checking of third-party libs
          },
          -- Do not send telemetry data containing your machine info.
          telemetry = {
            enable = false,
          },
        },
      },
    }) end,
}
