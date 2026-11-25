vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })


vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = { border = 'rounded' },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    -- Automatische LSP-Vervollständigung
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, {
        autotrigger = true,
      })
    end

    local map = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, {
        buffer = ev.buf,
        desc = desc,
      })
    end

    map('gd', vim.lsp.buf.definition, 'Zur Definition')
    map('gr', vim.lsp.buf.references, 'Referenzen')
    map('<leader>cr', vim.lsp.buf.rename, 'Symbol umbenennen')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code-Aktion')
  end,
})

vim.lsp.enable('basedpyright')

vim.lsp.config['tsc'] = {
  filetypes = {'js', 'ts', 'cjs'}
}
vim.lsp.enable('tsc')
