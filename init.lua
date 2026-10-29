-- Leader zuerst – bevor irgendein Keymap angelegt wird
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.lsp.basedpyright')

-- Plugins kommen hier Schritt für Schritt dazu

require('plugins.colorscheme')
require('plugins.whichkey')
require('plugins.telescope')
require('plugins.treesitter')
