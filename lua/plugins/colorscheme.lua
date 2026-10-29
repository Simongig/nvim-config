-- ============================================================================
--  Schritt 1: Farbschema – offizielles Dracula (github.com/dracula/vim)
-- ============================================================================

vim.pack.add({
  -- Das Repo heißt "vim" – ohne `name` hieße der Plugin-Ordner auch "vim".
  -- Mit `name` geben wir ihm einen sprechenden Namen.
  { src = 'https://github.com/dracula/vim', name = 'dracula' },
})

-- Vim-Plugins werden über g:-Variablen konfiguriert (Lua-Plugins über setup()).
-- Sie werden beim Laden des Colorschemes gelesen → also VOR colorscheme setzen.
-- Alle Optionen: :help dracula-configuration

-- Ptyxis kann Wellenlinien (undercurl) → Fehler werden später "rot gewellt"
-- unterstrichen, ohne dass sich die Textfarbe ändert.
vim.g.dracula_full_special_attrs_support = 1

-- Auf 0 setzen, wenn Neovim den Hintergrund deines Terminals übernehmen soll
-- (z.B. bei transparentem Terminal). Standard: 1 = Dracula-Hintergrund.
vim.g.dracula_colorterm = 0

vim.cmd.colorscheme('dracula')
