return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
  theme = 'doom',
  config = {
    header = {
					'                                     ',
	'                                     ',
'                                     ',
'                                     ',
		'                                     ',
		'                                     ',
'                                     ',
      ' ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
      ' ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
      ' ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
      ' ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
      ' ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
      ' ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
'                                     ',
'                                     ',
'                                     ',
      '                                     '},
    center = {
              -- Standard dashboard actions (aligned with common usage and doom theme aesthetics)
        { icon = ' ', desc = 'Recent Files', action = 'Telescope oldfiles', shortcut = 'r' },
        { icon = ' ', desc = 'Browse Files', action = 'Telescope file_browser', shortcut = 'p' }, -- Changed shortcut to 'p' to avoid conflict with 'b' if user re-adds
        { icon = ' ', desc = 'Live Grep', action = 'Telescope live_grep', shortcut = 'g' },
        { icon = ' ', desc = 'Git Status', action = 'Telescope git_status', shortcut = 's' },
        { icon = ' ', desc = 'Help Tags', action = 'Telescope help_tags', shortcut = 'h' },
        { icon = ' ', desc = 'Buffers', action = 'Telescope buffers', shortcut = 'l' }, -- Changed shortcut to 'l'
        { icon = ' ', desc = 'Quit Neovim', action = 'qa', shortcut = 'q' }, -- Quit action
    },
    footer = {
'                                     ',
'                                     ',
'                                     ',
				'Fix the Money Fix the World'
	 }  --your footer
  }
}
	end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
