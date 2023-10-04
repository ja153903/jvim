return {
  {
    "ja153903/gruvbox-baby",
    config = function()
      vim.g.gruvbox_baby_transparent_mode = 1
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-baby",
    },
  },
}
