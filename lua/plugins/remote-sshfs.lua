return {
  {
    'nosduco/remote-sshfs.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      -- Setup the plugin with corrected configuration
      require('remote-sshfs').setup({
        connections = {
          ssh_configs = {
            vim.fn.expand("$HOME/.ssh/config"), -- Ensure this is the correct location
          },
          sshfs_args = {
            "-o reconnect",           -- Automatically reconnect if the connection drops
            "-o Compression=no",      -- Avoid extra compression overhead
            "-o cache=yes",           -- Enable caching
            "-o kernel_cache",        -- Improve re-read speeds
            "-o direct_io",           -- Direct reads and writes
          },
        },
        mounts = {
          base_dir = vim.fn.expand("$HOME/sshfs_mounts/"), -- Custom local mount directory
          unmount_on_exit = true,                          -- Optionally unmount on Neovim exit
        },
      })

      -- Load the extension into Telescope
      require('telescope').load_extension('remote-sshfs')
    end,
  }
}
