vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

vim.diagnostic.config({ virtual_text = true }) -- Fehler als Text neben der Zeile

vim.lsp.enable('basedpyright')

