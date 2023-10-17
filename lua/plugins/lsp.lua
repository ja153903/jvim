return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "black",
        "typescript-language-server",
        "eslint_d",
        "rust-analyzer",
        "haskell-language-server",
        "clangd",
        "ruff-lsp",
        "ruff",
      },
    },
  },
}
