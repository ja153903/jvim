return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    -- lazy = false,
    -- priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "main",
        disable_italics = true,
      })
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode").setup({
        -- Enable transparent background
        -- transparent = true,
        -- enable italic comment
        italic_comments = true,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
}
