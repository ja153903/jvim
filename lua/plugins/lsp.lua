return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "typescript-language-server",
        "eslint_d",
        "rust-analyzer",
        "haskell-language-server",
        "clangd",
        "ruff",
        "ruff-lsp",
        "pyright",
        "elixir-ls",
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
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                typeCheckingMode = "off",
              },
            },
          },
        },
      },
    },
  },
}
