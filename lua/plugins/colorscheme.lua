return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        disable_italics = true,
      })
    end,
  },
  {
    "sainnhe/everforest",
    -- lazy = false,
    -- priority = 1000,
    config = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_better_performance = 1
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        -- ...
      })

      vim.cmd("colorscheme github_light")
    end,
  },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "",
  --   },
  -- },
}
