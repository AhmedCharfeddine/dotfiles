return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {}

    -- LazyGit terminal instance
    local Terminal = require('toggleterm.terminal').Terminal
    local Lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }

    function _lazygit_toggle()
      Lazygit:toggle()
    end

    -- Keymap to toggle lazygit
    vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })
  end,
}
