-- ============================================================================
--  Schritt 3: Telescope – Fuzzy-Finder für Dateien, Text, Hilfe, Keymaps …
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 1) Build-Hook: fzf-native muss nach Installation/Update kompiliert werden.
--    vim.pack meldet jede Änderung über das Ereignis "PackChanged".
--    WICHTIG: Der Hook muss VOR vim.pack.add stehen – sonst ist die
--    Installation schon vorbei, wenn er angelegt wird.
-- ---------------------------------------------------------------------------


vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  { src = "https://github.com/nvim-telescope/telescope.nvim", version = vim.version.range('*')}, 
})


local telescope = require("telescope")

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    },
    file_ignore_patterns = { '%.git/', 'node_modules/', '%.venv/', '__pycache__/' },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = valuei,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
})

-- ---------------------------------------------------------------------------
-- 4) Tastenkürzel – alle unter <leader>s ("suchen")
--    builtin.* sind die mitgelieferten "Picker". Liste: :Telescope <Tab>
-- ---------------------------------------------------------------------------
local builtin = require("telescope.builtin")
local map = vim.keymap.set

map('n', '<leader>sf', builtin.find_files, { desc = 'Dateien' })
map('n', '<leader>sg', builtin.live_grep, { desc = 'Text im Projekt (grep)' })
map('n', '<leader>sw', builtin.grep_string, { desc = 'Wort unter Cursor' })
map('n', '<leader>sb', builtin.buffers, { desc = 'Offene Buffer' })
map('n', '<leader>sr', builtin.oldfiles, { desc = 'Zuletzt geöffnet' })
map('n', '<leader>sh', builtin.help_tags, { desc = 'Hilfe' })
map('n', '<leader>sk', builtin.keymaps, { desc = 'Keymaps' })
map('n', '<leader>sd', builtin.diagnostics, { desc = 'Diagnosen' })
map('n', '<leader>s.', builtin.resume, { desc = 'Letzte Suche fortsetzen' })
map('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'In aktueller Datei suchen' })
map('n', '<leader><leader>', builtin.find_files, { desc = 'Dateien' })

-- Eigene Config durchsuchen: dieselbe Funktion, nur mit anderem Startordner
map('n', '<leader>sn', function()
  builtin.find_files({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Neovim-Config' })
