-- ============================================================================
--  Schritt 1: Farbschema – offizielles Dracula (github.com/dracula/vim)
-- ============================================================================

vim.pack.add({
  -- Das Repo heißt "vim" – ohne `name` hieße der Plugin-Ordner auch "vim".
  -- Mit `name` geben wir ihm einen sprechenden Namen.
  { src = 'https://github.com/morhetz/gruvbox', name = 'gruvbox' },
})

-- Vim-Plugins werden über g:-Variablen konfiguriert (Lua-Plugins über setup()).
-- Sie werden beim Laden des Colorschemes gelesen → also VOR colorscheme setzen.
-- Alle Optionen: :help dracula-configuration

vim.cmd.colorscheme('gruvbox')
