-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        'git', 'clone', '--filter=blob:none',
        'https://github.com/echasnovski/mini.nvim', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

vim.g.mapleader = ","

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })
local add = MiniDeps.add

-- require('mini.animate').setup({cursor = {enable=false}})
require('mini.basics').setup({mappings = {windows = true}})
require('mini.statusline').setup()
require('mini.cursorword').setup()


vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
add({source = 'nvim-tree/nvim-tree.lua'})
--add({source = 'DaikyXendo/nvim-material-icon'})
--require("nvim-material-icon").setup({})
add({source = 'nvim-tree/nvim-web-devicons'})
require("nvim-web-devicons").setup({})
require("nvim-tree").setup({
        renderer={
        icons = {
                      show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = false,
            modified = true,
            hidden = false,
            diagnostics = true,
            bookmarks = false,
          },
          }}})
nvimtree = require("nvim-tree.renderer")
vim.keymap.set('n', '<leader>l', '<cmd>NvimTreeToggle<cr>')


add({
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'master',
  monitor = 'main',
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'lua', 'vimdoc' , 'python', 'rust'},
  highlight = { enable = true ,disable ={"rust"}},
})

-- python setup
-- loosely based on https://github.com/chrisgrieser/nvim-kickstart-python/blob/main/kickstart-python.lua
add({
    source = 'WhoIsSethDaniel/mason-tool-installer.nvim',
    depends = {'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim'}
})
require("mason").setup()
require("mason-lspconfig").setup()
require('mason-tool-installer').setup({
    ensure_installed = {
        "pyright", -- LSP for python
        "basedpyright", -- LSP for python
        "ruff", -- linter for python (includes flake8, pep8, etc.)
        "rust-analyzer",
        "debugpy", -- debugger
        "black", -- formatter
        "isort", -- organize imports
        "taplo", -- LSP for toml (for pyproject.toml files)
        "typos",
        "rustfmt",
        "typos-lsp"
    }
})

-- fstring helper
add({source = 'chrisgrieser/nvim-puppeteer'})

add({source = 'neovim/nvim-lspconfig'})
local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
lspCapabilities.textDocument.completion.completionItem.snippetSupport = true
require("lspconfig").pyright.setup({
    capabilities = lspCapabilities,
})
require("lspconfig").taplo.setup({
    capabilities = lspCapabilities,
})
require'lspconfig'.rust_analyzer.setup{
  ---@param client lsp.Client
 settings = {
    ['rust-analyzer'] = {
      check = {
        --ignore = {"unused_imports", "unused_variables"};
      }
    }
  }
}

require("lspconfig").typos_lsp.setup({})
require("lspconfig").ruff.setup({
    -- organize imports disabled, since we are already using `isort` for that
    -- alternative, this can be enabled to make `organize imports`
    -- available as code action
    settings = {
            organizeImports = false,
    },
    -- disable ruff as hover provider to avoid conflicts with pyright
    on_attach = function(client) client.server_capabilities.hoverProvider = false end,
})

add({source = 'stevearc/conform.nvim'})
require("conform").setup({
    formatters_by_ft = {
        -- first use isort and then black
        python = { "isort", "black" },
        rust = {"rustfmt"},
        -- "inject" is a special formatter from conform.nvim, which
        -- formats treesitter-injected code. Basically, this makes
        -- conform.nvim format python codeblocks inside a markdown file.
        markdown = { "inject" },
    },
    -- enable format-on-save
    -- format_on_save = {
    --     -- when no formatter is setup for a filetype, fallback to formatting
    --     -- via the LSP. This is relevant e.g. for taplo (toml LSP), where the
    --     -- LSP can handle the formatting for us
    --     lsp_fallback = true,
    -- },

})
vim.keymap.set("n", "<leader>f", require("conform").format,{})
require("conform").format({ lsp_fallback = true })

add({source = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'})
require("lsp_lines").setup({})
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)
vim.keymap.set(
  "n",
  "<Leader>e",
  require("lsp_lines").toggle,
  { desc = "Toggle lsp_lines" }
)


add({
    source = 'hrsh7th/nvim-cmp',
    depends = {'hrsh7th/cmp-nvim-lsp'}
})
add({source = 'dcampos/nvim-snippy'})
add({source = 'dcampos/cmp-snippy'})
add({source = 'honza/vim-snippets'})
snippy = require('snippy')
snippy.setup({})

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")

cmp.setup({
    completion = {
    completeopt = 'menu,menuone,noselect', -- remove `noselect`.
  },
  preselect = cmp.PreselectMode.None,
    -- register the lsp as completion provider
    sources = cmp.config.sources({
        { name = "nvim_lsp"}, {name="snippy"},
    }),
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif snippy.can_jump(-1) then
        snippy.previous()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<c-z>"] = cmp.mapping(function(fallback)
        if snippy.can_expand_or_advance() then
            snippy.expand_or_advance()
        elseif has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end, {"i","s"}),
  },

})

--vim.o.completeopt = 'menu,menuone,noselect'

add({source = 'Vigemus/iron.nvim'})
local iron = require("iron.core")
local view = require("iron.view")
iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        -- Can be a table or a function that
        -- returns a table (see below)
        command = {"zsh"}
      },
      python = {
        command = { "ipython", "--no-autoindent" },
        format = require("iron.fts.common").bracketed_paste_python
      }
    },
    -- How the repl window will be displayed
    -- See below for more information
    --repl_open_cmd = require('iron.view').bottom(40),
    repl_open_cmd = view.split.vertical.botright(60),
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    send_motion = "<space>sc",
    visual_send = "<space>sc",
    send_file = "<space>sf",
    send_line = "<space>sl",
    send_paragraph = "<space>sp",
    send_until_cursor = "<space>su",
    send_mark = "<space>sm",
    mark_motion = "<space>mc",
    mark_visual = "<space>mc",
    remove_mark = "<space>md",
    cr = "<space>s<cr>",
    interrupt = "<space>s<space>",
    exit = "<space>sq",
    clear = "<space>cl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

-- color schemes
add({source = 'nyoom-engineering/oxocarbon.nvim'})
add({source = 'agude/vim-eldar'})
add({source = 'VonHeikemen/lsp-zero.nvim'})


add({source = 'https://github.com/smjonas/inc-rename.nvim'})
require("inc_rename").setup()
vim.keymap.set("n", "<leader>r", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

add({source = 'miikanissi/modus-themes.nvim'})
require('modus-themes').setup({
    variant="default",
    on_colours = function(colors)
        colors.bg_active = "#000000"
    end
})

--add({source = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim"})
--local rainbow_delimiters = require 'rainbow-delimiters'
--require('rainbow-delimiters.setup').setup {
--    strategy = {
--        [''] = rainbow_delimiters.strategy['global'],
--        vim = rainbow_delimiters.strategy['local'],
--    },
--    query = {
--        [''] = 'rainbow-delimiters',
--        lua = 'rainbow-blocks',
--    },
--    priority = {
--        [''] = 110,
--        lua = 210,
--    },
--
--}




if vim.env.ITERM_PROFILE ~= "dropdown" then
vim.o.scrolloff = 5
end

vim.api.nvim_set_keymap(  't'  ,  '<ESC>'  ,  '<C-\\><C-n>'  ,  {noremap = true}  )
vim.api.nvim_command("autocmd TermOpen * setlocal nonumber")       -- no numbers
vim.api.nvim_command("autocmd TermEnter * setlocal signcolumn=no")

vim.o.expandtab=true
vim.o.autoindent=true
vim.o.smartindent=true
vim.o.shiftwidth = 4

vim.opt.background = "dark" -- set this to dark or light
vim.cmd.colorscheme "modus"
-- some themes overwrite this
vim.cmd('hi clear MiniCursorword')
vim.cmd('hi MiniCursorwordCurrent guibg=#7D7D7D')
vim.cmd('hi MiniCursorword gui=underline cterm=underline')
vim.cmd('hi clear NvimTreeSpecialFile')
vim.cmd('hi NvimTreeSpecialFile guifg=#ff80ff')
