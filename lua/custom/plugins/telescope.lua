return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      enabled = true,
    },
    { 'nvim-telescope/telescope-file-browser.nvim', enabled = true },
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'

    telescope.setup {
      defaults = {
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
          prompt_position = 'top',
          preview_width = 0.7,
        },
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
            ['<C-j>'] = actions.move_selection_next, -- move to next result
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
            ['<C-p>'] = actions.cycle_history_prev,
            ['<C-n>'] = actions.cycle_history_next,
          },
        },
      },
      extensions = {
        file_browser = {
          path = '%:p:h', -- open from within the folder of your current buffer
          display_stat = false, -- don't show file stat
          grouped = true, -- group initial sorting by directories and then files
          hidden = true, -- show hidden files
          hijack_netrw = true, -- use telescope file browser when opening directory paths
          prompt_path = true, -- show the current relative path from cwd as the prompt prefix
          use_fd = true, -- use `fd` instead of plenary, make sure to install `fd`
        },
      },
    }

    telescope.load_extension 'fzf'
    telescope.load_extension 'file_browser'

    local builtin = require 'telescope.builtin'

    -- key maps

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map('n', ';', ':Telescope file_browser<CR>')

    map('n', '<leader>ff', builtin.find_files, opts) -- Lists files in your current working directory, respects .gitignore
    map('n', '<leader>fx', builtin.treesitter, opts) -- Lists tree-sitter symbols
    map('n', '<leader>fs', builtin.spell_suggest, opts) -- Lists spell options
    map('n', '<leader>lg', function()
      builtin.live_grep { glob_pattern = { '!vendor/' } }
    end, opts) -- search text, exclude the vendor file

    map('n', '<leader>gs', builtin.git_status, opts) -- git status
  end,
}
