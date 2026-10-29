-- ============================================================================
--  lua/config/keymaps.lua  –  Allgemeine Tastenkürzel
-- ============================================================================
--
--  vim.keymap.set(MODUS, TASTEN, AKTION, OPTIONEN)
--
--    MODUS:   'n' = Normal, 'i' = Insert, 'v' = Visual, 'x' = nur Visual,
--             't' = Terminal. Mehrere Modi als Tabelle: { 'n', 'v' }
--    TASTEN:  z.B. '<leader>w'  →  Leertaste, dann w
--             <C-h> = Strg+h,  <S-Tab> = Shift+Tab,  <CR> = Enter
--    AKTION:  ein Befehl als String ('<cmd>write<CR>') ODER eine Lua-Funktion
--    OPTIONEN: { desc = '...' } → Beschreibung, die which-key und
--             Telescope (<leader>sk) anzeigen. Immer angeben!
--
--  Alle Keymaps ansehen:  :map   bzw. nur eigene:  <leader>sk  (Telescope)
--  Wer belegt eine Taste?  :verbose nmap <leader>w
--
--  LSP-spezifische Keymaps stehen in lua/plugins/lsp.lua,
--  Such-Keymaps in lua/plugins/telescope.lua.
-- ============================================================================

local map = vim.keymap.set

-- Such-Hervorhebung mit <Esc> ausblenden
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Suchmarkierung entfernen' })

-- Speichern & Beenden
map('n', '<leader>w', '<cmd>write<CR>', { desc = 'Datei speichern' })
map('n', '<leader>q', '<cmd>quit<CR>', { desc = 'Fenster schließen' })

-- Zwischen Fenstern (Splits) wechseln mit Strg + h/j/k/l
-- (statt Strg+w und dann h/j/k/l)
map('n', '<C-h>', '<C-w>h', { desc = 'Fenster links' })
map('n', '<C-j>', '<C-w>j', { desc = 'Fenster unten' })
map('n', '<C-k>', '<C-w>k', { desc = 'Fenster oben' })
map('n', '<C-l>', '<C-w>l', { desc = 'Fenster rechts' })

-- Im Visual-Modus einrücken, OHNE dass die Auswahl verloren geht
map('v', '<', '<gv', { desc = 'Ausrückung (Auswahl bleibt)' })
map('v', '>', '>gv', { desc = 'Einrückung (Auswahl bleibt)' })

-- Ausgewählte Zeilen mit J/K nach unten/oben verschieben
map('v', 'J', ":move '>+1<CR>gv=gv", { desc = 'Auswahl nach unten verschieben' })
map('v', 'K', ":move '<-2<CR>gv=gv", { desc = 'Auswahl nach oben verschieben' })

-- Beim Halbseiten-Scrollen und Suchen den Cursor mittig halten
map('n', '<C-d>', '<C-d>zz', { desc = 'Halbe Seite runter (zentriert)' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Halbe Seite hoch (zentriert)' })
map('n', 'n', 'nzzzv', { desc = 'Nächster Treffer (zentriert)' })
map('n', 'N', 'Nzzzv', { desc = 'Voriger Treffer (zentriert)' })

-- Integriertes Terminal: mit <Esc><Esc> zurück in den Normal-Modus
-- (Terminal öffnen: :terminal  oder  :split | terminal)
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Terminal-Modus verlassen' })

-- Diagnosen (Fehler/Warnungen) – funktionieren mit jeder Quelle, nicht nur LSP.
-- Hinweis: [d und ]d (vorige/nächste Diagnose) sind in Neovim schon eingebaut.
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Diagnose der Zeile anzeigen' })
map('n', '<leader>cq', vim.diagnostic.setloclist, { desc = 'Alle Diagnosen als Liste' })
