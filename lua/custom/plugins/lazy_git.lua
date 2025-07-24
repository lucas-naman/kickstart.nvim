return {
  'kdheepak/lazygit.nvim',
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- If you want it available instantly, set lazy = false.
  -- Otherwise, 'cmd' will ensure it loads when you call one of its commands.
  lazy = true, -- Keep it lazy by default, loads on command execution

  -- Keybindings for Lazygit:
  keys = {
    {
      '<leader>gg',
      '<cmd>LazyGit<CR>',
      desc = 'Open Lazygit (Terminal UI)',
    },
  },
  -- If you want to configure specific options for lazygit itself,
  -- you can pass them here. These are options that `lazygit` (the external program) takes.
  -- Example:
  -- opts = {
  --   config = {
  --     -- For example, to set the theme:
  --     git = {
  --       paging = {
  --         colorArg = 'always',
  --       },
  --     },
  --     gui = {
  --       theme = {
  --         activeBorderColor =  {"#89B4FA", "bold"},
  --         selectedLineBgColor = {"#334254"},
  --       },
  --     },
  --   },
  -- },
}
