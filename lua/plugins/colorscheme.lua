return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    -- config = function()
    --   require("rose-pine").setup({
    --     variant = "moon",
    --     disable_italics = true,
    --   })
    -- end,
  },
  {
    "ja153903/solarized-kyoto",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.solarized_italics = 0
    end
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized",
    },
  },
}
