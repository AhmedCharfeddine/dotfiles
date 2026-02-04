return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = {
          'node_modules',
          '.git/',
          'target',
          'build',
          '%.o',
          '%.class',
          '__pycache__',
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'

    -- Search selection helper
    local function get_visual_selection()
      local lines = vim.fn.getregion(vim.fn.getpos 'v', vim.fn.getpos '.', { type = vim.fn.mode() })
      return table.concat(lines, ' '):gsub('%s+', ' '):gsub('^%s+', ''):gsub('%s+$', '')
    end

    -- Keymaps
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', function()
      require('telescope.builtin').find_files(require('telescope.themes').get_dropdown {
        previewer = true,
        hidden = true,
      })
    end, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', function()
      builtin.grep_string(require('telescope.themes').get_ivy {
        previewer = true,
        hidden = true,
      })
    end, { desc = '[S]earch current [W]ord' })

    vim.keymap.set('n', '<leader>sg', function()
      builtin.live_grep(require('telescope.themes').get_ivy {})
    end, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sb', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {})
    end, { desc = '[S]earch current [B]uffer' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>so', function()
      builtin.oldfiles { previewer = false }
    end, { desc = '[S]earch Recent Files ("o" for oldfiles)' })
    vim.keymap.set('n', '<leader><leader>', function()
      require('telescope.builtin').buffers(require('telescope.themes').get_dropdown {
        previewer = false,
      })
    end, { desc = '[ ] Find existing buffers' })

    -- Visual mode selection search
    vim.keymap.set('x', '<leader>sg', function()
      local selection = get_visual_selection()
      if selection ~= '' then
        builtin.live_grep(require('telescope.themes').get_ivy {
          default_text = selection,
          previewer = true,
        })
      end
    end, { desc = '[S]earch selection by [G]rep' })
    vim.keymap.set('x', '<leader>sb', function()
      local selection = get_visual_selection()
      if selection ~= '' then
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          default_text = selection,
          previewer = false,
        })
      end
    end, { desc = '[S]earch selection in [B]uffer' })

    -- Shortcut for searching Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
