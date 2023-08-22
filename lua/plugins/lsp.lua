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
        "rust-analyzer",
        "haskell-language-server",
        "clangd",
        "ruff-lsp",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                diagnosticMode = "openFilesOnly",
              },
            },
          },
        },
      },
    },
  },
}
