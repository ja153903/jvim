return {
  { "echasnovski/mini.pairs", enabled = false },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup()
      vim.cmd("colorscheme rose-pine")
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    enabled = true,
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "copilot.lua",
    opts = {},
    config = function(_, opts)
      local copilot_cmp = require("copilot_cmp")
      copilot_cmp.setup(opts)
      -- attach cmp source whenever copilot attaches
      -- fixes lazy-loading issues with the copilot cmp source
      require("lazyvim.util").on_attach(function(client)
        if client.name == "copilot" then
          copilot_cmp._on_insert_enter()
        end
      end)
    end,
  },
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<CR>"] = cmp.mapping.confirm({
          -- this is the important line
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      opts.sources = cmp.config.sources({
        { name = "copilot", group_index = 2 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "luasnip", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "path", group_index = 2 },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "black",
        "pyright",
        "rust-analyzer",
        "typescript-language-server",
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources, nls.builtins.formatting.black)
    end,
  },
  {
    "telescope.nvim",
    keys = {
      {
        "<leader>sg",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Extended search with grep",
      },
    },
    dependencies = {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- build = "make",
      config = function()
        require("telescope").load_extension("live_grep_args")
      end,
    },
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣠⠤⡤⣄⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣴⣶⣶⠞⠋⢡⠀⠀⠀⢠⡀⠀⠉⠙⠲⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⢞⣉⡴⢁⡾⠁⠀⠀⢸⡆⠀⠀⠀⠉⠳⣦⡀⠀⠈⠋⠳⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⡴⢟⡿⠋⠈⠀⣼⠁⠀⠀⠀⠈⢳⡀⠀⠀⠀⠀⠀⠙⢶⣄⠀⠀⠀⠙⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣠⠟⢄⡞⠀⠀⠀⢨⡏⠀⠀⠀⠀⠀⠈⢷⠀⠀⠀⠀⠀⠀⠀⠙⢦⡀⠀⠂⠈⢳⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣠⠿⢀⡞⠀⠀⠀⠀⢻⡇⠀⠀⠀⣀⣀⢀⡈⣇⠀⠀⠀⠀⠀⠀⠀⠀⠳⡄⠀⠀⠀⢻⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢠⠟⠀⣾⠀⠀⠀⠐⠲⣼⡇⢀⠀⣾⡏⢹⣷⡀⢹⡄⠀⠀⠀⠀⠀⠀⠀⠀⠹⡆⠀⠀⠀⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣾⠀⢸⠇⠀⢀⣀⣀⣠⠿⠿⠾⠷⢾⡇⢸⡟⠋⠛⠋⠉⠉⠙⠓⠒⠲⠶⠦⣼⢽⡄⠀⠀⠘⣇⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⣼⠋⠀⣿⠛⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠛⠛⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⠠⢿⡀⠀⠀⢻⡀⠀⠀⠀⠀⠀⠀⠀
⠀⢀⣿⠀⢠⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠈⡷⢄⠀⢸⣇⠀⠀⠀⠀⠀⠀⠀
⠀⢸⠁⠸⢹⢹⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣶⠀⢹⡀⠀⠈⣿⠀⠀⠀⠀⠀⠀⠀
⠀⣼⠀⠀⣿⣽⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠨⣿⢦⡜⢷⠄⠀⣿⡄⠀⠀⠀⠀⠀⠀
⢀⡏⠀⠀⣿⢺⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡿⠀⠀⠀⠀⠀⢻⡇⠀⠀⠀⠀⠀⠀
⢸⡇⠀⠀⣿⢼⡇⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⣇⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀
⣾⣿⠀⡀⢹⣼⡇⠀⠀⠀⠀⠀⣿⣿⠆⠀⠀⠐⠒⠒⠒⠀⠀⢼⣿⡷⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀
⣿⣿⣄⢣⠸⣿⡇⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠁⠀⠀⠀⠀⠀⠀⡇⠀⠈⢳⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀
⣿⡇⣏⡄⣧⢺⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⢸⠀⠀⣸⡇⠀⠀⠀⠀⠀⠀
⣿⣿⣿⡃⠈⠈⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⢰⠀⢸⠀⠀⣾⡇⠀⠀⠀⠀⠀⠀
⢹⣧⢻⡆⠀⠀⢻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⢸⠀⢸⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀
⢸⣿⢸⡇⢠⣀⠻⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⡿⠀⢸⠀⠀⢺⣷⠀⠀⠀⠀⠀⠀
⠈⣿⣆⡇⠀⢹⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣧⡇⠀⢸⠀⠀⢸⢸⠀⠀⠀⠀⠀⠀
⠀⠸⣿⣧⠀⣾⡟⡷⢤⣤⣤⠴⣶⣶⣶⠶⣶⣶⣖⣲⠒⢒⣒⣶⣶⣷⣾⠒⣶⢲⠒⠲⣿⠇⠀⢸⠀⠄⣾⢸⠀⠀⠀⠀⠀⠀
⠀⠀⠹⣿⡄⢸⡇⢹⡄⠀⢹⠀⢸⡀⢾⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⡿⢻⠀⣿⢸⡄⠀⡞⠀⠀⢸⢀⡄⣿⢺⡆⠀⠀⠀⠀⠀
⠀⠀⠀⠙⣿⠀⡇⠐⣇⠀⢸⠀⠈⣇⢸⣇⣬⣿⣿⣹⣿⣿⣿⣿⠟⠀⢸⣤⣏⢸⠆⢠⡇⠀⠀⢸⠀⠁⢯⢸⣷⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣿⡆⣧⠀⠹⡄⠘⡇⠀⣿⣿⣿⣿⡟⢿⣿⣿⠿⠟⠁⠀⠀⠸⣿⣿⣿⣀⣾⠀⠀⠀⠸⠀⠀⠸⡖⢹⡀⠀⠀⠀⠀
⠀⠀⠀⠀⢻⠀⣿⠀⠀⢧⢠⣧⣼⣿⣿⣿⠛⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢹⣿⢹⣿⣶⣶⣤⣀⡀⠀⠀⢻⠘⡇⠀⠀⠀⠀
⠀⠀⠀⠀⢸⠀⣹⣠⣴⣾⣾⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⡿⣸⣿⣿⣿⣿⣿⣿⣿⣶⣾⣤⣷⠀⠀⠀⠀
⠀⠀⣀⣠⠾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⢀⣀⣀⣤⣄⣀⠀⠀⣾⣿⣷⣿⣿⣿⣿⠿⢿⣿⣿⣿⣿⣽⣿⣿⣷⣤⡀
⣴⣿⣿⣿⣷⣶⣤⣤⣌⣙⣛⡻⠿⣿⣿⣿⣿⣿⡟⢛⣋⣉⣁⣈⡛⡿⣾⣿⣿⣿⣿⠟⣋⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
    ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        -- dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        -- dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
