return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources, nls.builtins.formatting.black)
      table.insert(opts.sources, nls.builtins.formatting.prettierd)
      table.insert(opts.sources, nls.builtins.diagnostics.eslint_d)
      -- table.insert(opts.sources, nls.builtins.diagnostics.cppcheck)
      -- table.insert(opts.sources, nls.builtins.diagnostics.cpplint)
    end,
  },
}
