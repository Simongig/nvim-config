-- ============================================================================
--  lua/config/autocmds.lua  –  Automatische Aktionen ("Autocommands")
-- ============================================================================
--
--  Ein Autocommand sagt: "Wenn EREIGNIS passiert, führe FUNKTION aus."
--
--    vim.api.nvim_create_autocmd(EREIGNIS, {
--      group    = ...,   -- Gruppe (siehe unten)
--      pattern  = ...,   -- optional: nur für bestimmte Dateitypen/Pfade
--      callback = function(ev) ... end,  -- was passieren soll
--    })
--
--  Häufige Ereignisse: BufWritePre (vor dem Speichern), FileType (Dateityp
--  erkannt), TextYankPost (nach dem Kopieren), LspAttach (LSP verbunden).
--  Liste aller Ereignisse:  :help autocmd-events
--
--  Gruppen mit { clear = true } verhindern, dass Autocommands doppelt
--  angelegt werden, wenn du die Datei erneut lädst (:source %).
-- ============================================================================

local group = vim.api.nvim_create_augroup('user-autocmds', { clear = true })

-- Kopierten Text kurz aufleuchten lassen (sichtbares Feedback bei "yy", "yiw", ...)
vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  desc = 'Kopierten Text hervorheben',
  callback = function()
    vim.hl.on_yank({ timeout = 200 })
  end,
})

-- Für diese Dateitypen 2 statt 4 Leerzeichen Einrückung (übliche Konvention).
-- `vim.bo` = buffer-lokale Optionen → gilt nur für die aktuelle Datei.
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = { 'lua', 'yaml', 'json', 'jsonc', 'html', 'css', 'javascript', 'typescript', 'markdown' },
  desc = '2 Leerzeichen Einrückung für bestimmte Sprachen',
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
})

-- Beim Öffnen einer Datei an die zuletzt bearbeitete Stelle springen
vim.api.nvim_create_autocmd('BufReadPost', {
  group = group,
  desc = 'Zur letzten Cursorposition springen',
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"') -- Marke " = letzte Position
    local line_count = vim.api.nvim_buf_line_count(ev.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Splits gleichmäßig verteilen, wenn sich die Terminalgröße ändert
vim.api.nvim_create_autocmd('VimResized', {
  group = group,
  desc = 'Splits bei Größenänderung angleichen',
  command = 'wincmd =',
})
