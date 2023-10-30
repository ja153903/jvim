return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "main",
        disable_italics = true,
      })
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    -- lazy = false,
    -- priority = 1000,
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
    "kvrohit/rasmus.nvim",
    config = function()
      vim.g.rasmus_italic_comments = true
      vim.g.rasmus_bold_functions = true
      vim.g.rasmus_bold_keywords = true
      vim.g.rasmus_bold_booleans = true
    end,
  },
  {
    "NLKNguyen/papercolor-theme",
    name = "papercolor",
  },
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "moonfly",
    },
  },
}
