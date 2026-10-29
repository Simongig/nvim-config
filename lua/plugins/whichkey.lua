-- ============================================================================
--  Schritt 2: which-key – zeigt, welche Tasten als Nächstes möglich sind
-- ============================================================================

vim.pack.add({ 'https://github.com/folke/which-key.nvim' })

local wk = require('which-key')

-- Ohne Nerd Font: Tasten als Text statt als Symbol anzeigen.
-- Wir bauen eine Lua-Tabelle (= Dictionary): Schlüssel → Anzeigetext.
local text_keys = {
  Up = '<Up> ', Down = '<Down> ', Left = '<Left> ', Right = '<Right> ',
  C = '<C-…> ', M = '<M-…> ', D = '<D-…> ', S = '<S-…> ',
  CR = '<CR> ', Esc = '<Esc> ', NL = '<NL> ', BS = '<BS> ',
  Space = '<Space> ', Tab = '<Tab> ',
  ScrollWheelDown = '<ScrollWheelDown> ', ScrollWheelUp = '<ScrollWheelUp> ',
}
-- F1 bis F12 per Schleife ergänzen (.. verbindet Strings in Lua)
for i = 1, 12 do
  text_keys['F' .. i] = '<F' .. i .. '> '
end

wk.setup({
  preset = 'helix', -- Aussehen: 'classic', 'modern' oder 'helix' – probier sie aus!
  delay = 300,       -- ms bis zum Popup (unabhängig von 'timeoutlen')
  icons = {
    -- `a and b or c` ist Luas Kurzform für "wenn a, dann b, sonst c"
    mappings = vim.g.have_nerd_font,
    keys = vim.g.have_nerd_font and {} or text_keys,
  },
})

-- wk.add() kann zwei Dinge:
--  1. Gruppen benennen: Präfixe bekommen im Popup einen Namen statt "+2 keymaps"
--  2. Keymaps anlegen – wie vim.keymap.set, nur als Tabelle
-- Neue Gruppen ergänzen wir, sobald neue Plugins neue Präfixe bringen.
wk.add({
  { '<leader>c', group = 'Code' }, -- <leader>cd, <leader>cq aus keymaps.lua

  -- Zeigt nur die Keymaps, die in DIESER Datei gelten (wichtig ab LSP-Schritt)
  { '<leader>?', function() wk.show({ global = false }) end, desc = 'Keymaps nur dieses Buffers' },
})
