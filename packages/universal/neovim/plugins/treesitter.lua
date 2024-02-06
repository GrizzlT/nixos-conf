require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    disable = function(lang, buf)
        if lang == 'lua' then
          return true
        end

        local max_filesize = 200 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
  },
  -- indent = { enable = true, },
  context_commentstring = { enable = true, enable_autocmd = false, },
  auto_install = false,
})