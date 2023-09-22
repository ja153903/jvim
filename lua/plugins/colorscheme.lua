return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        disable_italics = true,
      })
    end,
  },
  { "ja153903/gruvbox-baby" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-baby",
    },
  },
}
