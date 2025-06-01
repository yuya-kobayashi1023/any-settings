-- nvim settings

-- overwrite key configs
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- visible line number
vim.opt.number = true

--tab and indent settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- char code
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- ps is default 
vim.opt.shell = 'powershell'
vim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
vim.opt.shellquote = ''
vim.opt.shellxquote = ''

-- invisible
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  space = "·",
  eol = "↴",
}

-- lazy.nvim initialize
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- load plugin
require("lazy").setup({
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          treesitter = true,
          native_lsp = { enabled = true },
          telescope = true,
          nvimtree = true,
          cmp = true,
          gitsigns = true,
        },
      })
      vim.cmd("colorscheme catppuccin")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          section_separators = '',
          component_separators = '',
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch' },
          lualine_c = {
            { 'filename', path = 1 }
          },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        }
      })
    end,
  },

  {
    "gaoDean/autolist.nvim",
    ft = { "markdown", "text", "tex" },
    config = function()
      require("autolist").setup()
      vim.keymap.set("i", "<CR>", "<CR><C-o>:AutolistNewBullet<CR>")
      vim.keymap.set("n", "o", "o<C-r>=AutolistNewBullet()<CR>")
      vim.keymap.set("n", "O", "O<C-r>=AutolistNewBullet()<CR>")
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 15,
        open_mapping = [[<C-\>]],
        direction = 'horizontal',
        start_in_insert = true,
        shell = vim.o.shell, -- ← powershell反映
      })
    end
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "│" },
        scope = { enabled = true },
      })
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true,
          }
        }
      })
  
      vim.keymap.set("n", "<leader>e", ":Neotree toggle current<CR>", { noremap = true, silent = true })
    end
  }
})
