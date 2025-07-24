return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' }, -- Formats before saving
    cmd = { 'ConformInfo' }, -- Makes :ConformInfo available
    keys = {
      {
        '<leader>f',
        function()
          -- Formats the whole buffer in normal mode or selected range in visual mode
          require('conform').format { async = true, lsp_format = 'fallback', buf = 0 }
        end,
        mode = { 'n', 'v' }, -- Apply in normal and visual modes
        desc = '[F]ormat buffer (Conform)',
      },
      -- You might also want a dedicated visual mode mapping for selected text:
      -- {
      --   '<leader>F', -- Or some other key combo for visual selection
      --   function()
      --     require('conform').format { async = true, lsp_format = 'fallback', range = true }
      --   end,
      --   mode = 'v',
      --   desc = '[F]ormat selection (Conform)',
      -- },
    },
    opts = {
      -- Only notify on errors, not on successful formatting
      notify_on_error = false,

      -- Configuration for formatting on save
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style or where external formatters are preferred.
        local disable_filetypes = {
          c = true,
          cpp = true,
          -- Add any other filetypes you do NOT want to auto-format on save
          -- e.g., tex = true,  -- LaTeX files might have specific formatting needs
        }

        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil -- Disable format on save for these filetypes
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback', -- Use LSP formatting if no conform formatter is found
          }
        end
      end,

      -- Define your formatters by filetype
      formatters_by_ft = {
        lua = { 'stylua' },
        -- For Go, it's common to use goimports first, then gofumpt for stricter formatting.
        -- Conform will try them in order until one succeeds.
        go = { 'goimports', 'gofumpt', 'gofmt' }, -- Order matters: goimports for imports, gofumpt for strict, gofmt as basic fallback
        -- Add other filetypes and their preferred formatters here
        -- javascript = { 'prettier' },
        -- typescript = { 'prettier' },
        -- json = { 'prettier' },
        -- markdown = { 'prettier' },
        -- python = { 'black', 'isort' }, -- Example: run black, then isort
        -- rust = { 'rustfmt' },
        -- html = { 'prettier' },
        -- css = { 'prettier' },
      },

      -- Optional: Configure individual formatters if they need specific arguments
      formatters = {
        -- stylua = {
        --   -- Example: set specific stylua arguments
        --   prepend_args = { '--indent-type', 'Spaces', '--indent-width', '2' },
        -- },
        -- gofumpt = {
        --   -- Example: enable extra checks for gofumpt
        --   prepend_args = { '-s' },
        -- },
        -- prettier = {
        --   -- Example: use 'prettierd' daemon for faster formatting if installed
        --   -- otherwise fallback to 'prettier'
        --   -- You'd need to install 'prettierd' globally: `npm install -g @fsouza/prettierd`
        --   -- command = 'prettierd',
        --   -- args = { '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
        -- },
      },
    },
  },
}
