return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter', -- Load cmp when entering insert mode
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    'hrsh7th/cmp-buffer', -- Buffer source
    'hrsh7th/cmp-path', -- Path source
    'L3MON4D3/LuaSnip', -- Snippet engine
    'saadparwaiz1/cmp_luasnip', -- Snippet source for cmp
    'saghen/blink.cmp', -- Your existing blink.cmp wrapper
    'onsails/lspkind.nvim', -- For nice completion icons
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local lspkind = require 'lspkind' -- Require lspkind here for formatting

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(), -- Manually trigger completion
        ['<C-e>'] = cmp.mapping.abort(), -- Close completion window
        ['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item
        -- Tab/Shift-Tab for cycling completion items and jumping snippets
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = cmp.config.sources {
        { name = 'nvim_lsp' }, -- LSP (e.g., gopls) completion
        { name = 'luasnip' }, -- Snippets
        { name = 'buffer' }, -- Words from current buffer
        { name = 'path' }, -- File paths
      },
      formatting = {
        -- Use lspkind to format completion items with icons and text
        format = lspkind.cmp_format {
          with_text = true,
          maxwidth = 50, -- Max width for the text, truncates if longer
          -- You can also specify custom icons or highlight groups here
          -- mode = 'symbol', -- 'text', 'symbol', or 'none'
          -- menu = {
          --     buffer = "[Buffer]",
          --     nvim_lsp = "[LSP]",
          --     luasnip = "[Snippet]",
          --     path = "[Path]",
          -- },
        },
      },
      window = {
        completion = cmp.config.window.bordered(), -- Add border to completion window
        documentation = cmp.config.window.bordered(), -- Add border to documentation window
      },
      -- Enable completion only when not in a prompt buffer (e.g., Telescope)
      enabled = function()
        return vim.bo.buftype ~= 'prompt'
      end,
      completion = {
        completeopt = 'menu,menuone,noinsert', -- Show completion menu, only one if matches, don't auto-insert
      },
      preselect = cmp.PreselectMode.None, -- Do not preselect the first item by default
    }
  end,
}
