--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = false,
  pattern = "*.lua",
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- -- Change theme settings
lvim.colorscheme = "catppuccin"

-- After changing plugin config exit and reopen LunarVim, Run :PackerSync
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = true

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "stylua" },
  {
    command = "prettier",
    extra_args = { "--print-with", "100" },
    filetypes = { "typescript", "typescriptreact" },
  },
}
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    command = "shellcheck",
    args = { "--severity", "warning" },
  },
}

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
    {
      "folke/trouble.nvim",
      cmd = "TroubleToggle",
    },
    { "sudormrfbin/cheatsheet.nvim" },
    { "iamcco/markdown-preview.nvim" },
    { "aspeddro/pandoc.nvim" },
    { "ThePrimeagen/vim-be-good" },
    {
      "sindrets/diffview.nvim",
      event = "BufRead",
    },
    { "catppuccin/nvim" },
    {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup()
      end,
    },
    {
      "p00f/nvim-ts-rainbow",
    },
    {
      "nvim-telescope/telescope-project.nvim",
      event = "BufWinEnter",
      setup = function()
        vim.cmd [[packadd telescope.nvim]]
      end,
    },
    {
      "npxbr/glow.nvim",
      ft = {"markdown"}
      -- run = "yay -S glow"
    },
    {
      "karb94/neoscroll.nvim",
      event = "WinScrolled",
      config = function()
      require('neoscroll').setup({
            -- All these keys will be mapped to their corresponding default scrolling animation
            mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
            '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
            hide_cursor = true,          -- Hide cursor while scrolling
            stop_eof = true,             -- Stop at <EOF> when scrolling downwards
            use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
            respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
            cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
            easing_function = nil,        -- Default easing function
            pre_hook = nil,              -- Function to run before the scrolling animation starts
            post_hook = nil,              -- Function to run after the scrolling animation ends
            })
      end
    },
    {
      "turbio/bracey.vim",
      cmd = {"bracey", "bracystop", "braceyreload", "braceyeval"},
      run = "npm install --prefix server",
    },
    {
      "metakirby5/codi.vim",
      cmd = "Codi",
    },
    { 
     "rafamadriz/friendly-snippets"
    },
}

-- -- autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("filetype", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
lvim.builtin.which_key.mappings["t"] = {
  name = "diagnostics",
  t = { "<cmd>troubletoggle<cr>", "trouble" },
  w = { "<cmd>troubletoggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>troubletoggle document_diagnostics<cr>", "document" },
  q = { "<cmd>troubletoggle quickfix<cr>", "quickfix" },
  l = { "<cmd>troubletoggle loclist<cr>", "loclist" },
  r = { "<cmd>troubletoggle lsp_references<cr>", "references" },
},
-- aditional configs
-- vim.opt.backup = false -- creates a backup file
-- vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
-- vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
-- vim.opt.colorcolumn = "99999" -- fixes indentline for now
-- vim.opt.completeopt = { "menuone", "noselect" }
-- vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
-- vim.opt.fileencoding = "utf-8" -- the encoding written to a file
-- vim.opt.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
-- vim.opt.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
-- vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
-- vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
-- vim.opt.hlsearch = true -- highlight all matches on previous search pattern
-- vim.opt.ignorecase = true -- ignore case in search patterns
-- vim.opt.mouse = "a" -- allow the mouse to be used in neovim
-- vim.opt.pumheight = 10 -- pop up menu height
-- vim.opt.showmode = false -- we don't need to see things like -- insert -- anymore
-- vim.opt.showtabline = 2 -- always show tabs
-- vim.opt.smartcase = true -- smart case
-- vim.opt.smartindent = true -- make indenting smarter again
-- vim.opt.splitbelow = true -- force all horizontal splits to go below current window
-- vim.opt.splitright = true -- force all vertical splits to go to the right of current window
-- vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors == true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 100 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true -- set the title of window to the value of the titlestring
-- vim.opt.titlestring = "%<%f%=%l/%l - nvim" -- what the title of the window will be set to
-- vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
-- vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion
-- vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
-- vim.opt.expandtab = true -- convert tabs to spaces
-- vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
-- vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.cursorline = true -- highlight the current line
-- vim.opt.number = true -- set numbered lines
-- vim.opt.relativenumber = false -- set relative numbered lines
-- vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
-- vim.opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
vim.opt.wrap = true -- display lines as one long line
-- vim.opt.spell = false
-- vim.opt.spelllang = "en"
vim.opt.scrolloff = 8 -- is one of my fav
-- vim.opt.sidescrolloff = 8
lvim.builtin.treesitter.rainbow.enable = true
lvim.transparent_window = true

