return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "black",
        "pyright",
        "typescript-language-server",
        "eslint_d",
      },
    },
  },
}
