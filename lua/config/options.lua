-- ============================================================================
--  lua/config/options.lua  –  Editor-Optionen
-- ============================================================================
--
--  `vim.opt.<name> = <wert>` setzt eine Option – das Lua-Gegenstück zu
--  `:set <name>=<wert>` in Vimscript.
--
--  Hilfe zu JEDER Option bekommst du mit  :help '<name>'
--  (mit einfachen Anführungszeichen!), z.B.  :help 'relativenumber'
--
--  Den aktuellen Wert prüfen:  :set relativenumber?
-- ============================================================================

local opt = vim.opt -- Abkürzung, damit wir nicht jedes Mal vim.opt tippen

-- ---------------------------------------------------------------------------
-- Zeilennummern & Darstellung
-- ---------------------------------------------------------------------------
opt.number = true          -- Absolute Zeilennummer der aktuellen Zeile anzeigen
opt.relativenumber = true  -- Andere Zeilen relativ nummerieren → "5j" springt 5 runter
opt.cursorline = true      -- Aktuelle Zeile hervorheben
opt.signcolumn = 'yes'     -- Spalte links für Fehler-Icons IMMER zeigen (sonst springt der Text)
opt.wrap = false           -- Lange Zeilen nicht umbrechen
opt.scrolloff = 8          -- Beim Scrollen immer 8 Zeilen Abstand zum Rand halten
opt.sidescrolloff = 8      -- Dasselbe horizontal
opt.termguicolors = true   -- 24-bit Farben (für moderne Farbschemata)
opt.showmode = false       -- "-- INSERT --" ausblenden (sieht man am Cursor)
opt.list = true            -- Unsichtbare Zeichen anzeigen ...
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- ... und zwar so
opt.winborder = 'rounded'  -- Abgerundete Ränder für Popups (z.B. LSP-Hover)

-- ---------------------------------------------------------------------------
-- Einrückung
-- ---------------------------------------------------------------------------
-- Standard: 4 Leerzeichen (PEP 8 für Python). Einige Sprachen bekommen in
-- autocmds.lua 2 Leerzeichen.
opt.expandtab = true    -- Tab-Taste fügt Leerzeichen statt Tab-Zeichen ein
opt.tabstop = 4         -- Ein echtes Tab-Zeichen wird 4 Spalten breit dargestellt
opt.shiftwidth = 4      -- ">>" und Auto-Einrückung verwenden 4 Spalten
opt.softtabstop = 4     -- Backspace löscht 4 Leerzeichen auf einmal
opt.smartindent = true  -- Neue Zeilen sinnvoll einrücken

-- ---------------------------------------------------------------------------
-- Suche
-- ---------------------------------------------------------------------------
opt.ignorecase = true  -- Groß-/Kleinschreibung bei der Suche ignorieren ...
opt.smartcase = true   -- ... AUSSER der Suchbegriff enthält Großbuchstaben
opt.hlsearch = true    -- Treffer hervorheben (mit <Esc> wieder ausblenden, s. keymaps)
opt.incsearch = true   -- Schon beim Tippen springen
opt.inccommand = 'split' -- Live-Vorschau bei :%s/alt/neu/ in einem Split

-- ---------------------------------------------------------------------------
-- Fenster & Verhalten
-- ---------------------------------------------------------------------------
opt.splitright = true  -- :vsplit öffnet rechts (statt links)
opt.splitbelow = true  -- :split öffnet unten (statt oben)
opt.mouse = 'a'        -- Maus in allen Modi erlauben (praktisch zum Lernen)
opt.undofile = true    -- Undo-Verlauf auf Platte speichern → Undo auch nach Neustart
opt.swapfile = false   -- Keine .swp-Dateien
opt.updatetime = 250   -- Nach 250 ms Inaktivität "CursorHold" auslösen (schnelleres Feedback)
opt.timeoutlen = 400   -- Wartezeit (ms) auf die nächste Taste einer Tastenfolge
opt.confirm = true     -- Bei :q mit ungespeicherten Änderungen nachfragen statt Fehler

-- Vervollständigungsmenü: Menü auch bei einem Treffer, nichts automatisch wählen
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- ---------------------------------------------------------------------------
-- Zwischenablage
-- ---------------------------------------------------------------------------
-- Yank/Paste nutzen die System-Zwischenablage (Strg+C / Strg+V in anderen Apps).
-- `vim.schedule` verschiebt das auf "nach dem Start", weil das Erkennen des
-- Clipboard-Tools (wl-copy, xclip, pbcopy, ...) sonst den Start verlangsamt.
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)
