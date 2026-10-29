vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('user-treesitter-build', { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    -- Nur bei Updates von nvim-treesitter (bei "install" macht install() den Job)
    if name ~= 'nvim-treesitter' or kind ~= 'update' then
      return
    end
    -- Wie im plug-2-Beispiel: Ist das Plugin in dieser Sitzung noch nicht geladen,
    -- gibt es :TSUpdate noch nicht → erst laden
    if not ev.data.active then
      vim.cmd.packadd('nvim-treesitter')
    end
    -- Neovim-Befehl aus Lua: vim.cmd (Shell-Befehl wäre vim.system wie bei make)
    vim.cmd('TSUpdate')
  end,
})

vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
})

local nvim_treesitter = require("nvim-treesitter")

nvim_treesitter.setup {}

nvim_treesitter.install{"python", "bash", "dockerfile", "lua", "vim", "vimdoc", "markdown", "markdown_inline", "json", "yaml", "toml"}

-- start treesitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "*" },
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf) 
  end,
})
