return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "black",
        "pyright",
        "rust-analyzer",
        "typescript-language-server",
        "clangd",
        "eslint_d",
        "ocaml-lsp",
      },
    },
  },
}
