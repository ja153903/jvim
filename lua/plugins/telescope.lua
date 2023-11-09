return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>sg",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Extended search with grep",
      },
    },
    dependencies = {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- build = "make",
      config = function()
        require("telescope").load_extension("live_grep_args")
      end,
    },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            disable_devicons = true,
          },
          live_grep = {
            disable_devicons = true,
          },
          git_files = {
            disable_devicons = true,
          },
        },
      })
    end,
  },
}
