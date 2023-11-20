return {
  {
    "rose-pine/neovim",
    -- lazy = false,
    -- priority = 1000,
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        disable_italics = true,
      })
    end,
  },
  {
    "ja153903/solarized-kyoto",
    lazy = false,
    priority = 1000
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized",
    },
  },
}
