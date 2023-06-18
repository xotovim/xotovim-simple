local present, signs = pcall(require, "gitsigns")
if not present then return end

signs.setup {
  signs = {
    add = { hl = 'GitSignsAdd', text = '▎', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change = { hl = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    untracked = { hl = 'GitSignsAdd', text = '┆', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
  },
  signcolumn = true, 
  numhl = false, 
  linehl = false, 
  word_diff = false, 
  watch_gitdir = { interval = 700, follow_files = true },
  attach_to_untracked = true,
  current_line_blame = true, 
  current_line_blame_opts = { virt_text = true, virt_text_pos = 'eol',  delay = 700, ignore_whitespace = false, },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, 
  max_file_length = 40000,
  preview_config = { border = xotovim.ui.float.border, style = 'minimal', relative = 'cursor', row = 0, col = 1 },
  yadm = { enable = false },
  
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map({ 'n', 'v' }, '<leader>ghs', gs.stage_hunk)
    map({ 'n', 'v' }, '<leader>ghr', gs.reset_hunk)
    map('n', '<leader>ghS', gs.stage_buffer)
    map('n', '<leader>ghu', gs.undo_stage_hunk)
    map('n', '<leader>ghR', gs.reset_buffer)
    map('n', '<leader>ghp', gs.preview_hunk)
    map('n', '<leader>gm', function() gs.blame_line { full = true } end)
    map('n', '<leader>ghd', gs.diffthis)
    map('n', '<leader>ght', gs.toggle_deleted)

    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
