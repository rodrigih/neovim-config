-- ####################
--      Vim Options
-- ####################

--  Allow GUI Colours
vim.opt.termguicolors = true

-- Add line numbers
vim.opt.number = true

-- Set fold method
vim.opt.foldmethod = "syntax"

-- Split options
vim.opt.splitright = true

-- Indentation settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Clipboard
vim.api.nvim_set_keymap("n", "<leader>y", '"+y', {});
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', {});
vim.api.nvim_set_keymap("n", "<leader>v", '"+p', {});

-- Custom Commands
vim.api.nvim_create_user_command("Reload", ":source ~/.config/nvim/init.lua", {})

-- ####################
--    Colour Schemes
-- ####################

vim.o.background = "light"
vim.cmd.colorscheme('everforest')
--vim.cmd.colorscheme('melange')
--vim.cmd.colorscheme 'melange'
--vim.cmd.colorscheme 'kanagawa'

-- ####################
--    Plugins
-- ####################

-- Plugin location: ~/.local/share/nvim/site/pack/plugins/start

-- ####################
--    Plugins - Lualine
-- ####################
local lualine = require("lualine").setup()

-- ####################
--    Plugins - Telescope
-- ####################
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})

-- ####################
--    Plugins - ALE
-- ####################
vim.g.ale_fix_on_save = 1
vim.g.ale_linters = {
        ['javascript'] = {'eslint', 'prettier'},
        ['typescript'] = {'eslint', 'prettier'},
        ['typescriptreact'] = {'eslint', 'prettier'},
        ['python'] = {'black'}
}
vim.g.ale_fixers = {
        ['javascript'] = {'eslint', 'prettier'},
        ['typescript'] = {'eslint', 'prettier'},
        ['typescriptreact'] = {'eslint', 'prettier'},
        ['python'] = {'black'}
}

--vim.keymap.set("n", "<leader>p", ":ALEFix<Enter>");
vim.keymap.set('n', '<leader>j', "<cmd>ALENextWrap<cr>", {})
vim.keymap.set('n', '<leader>k', "<cmd>ALEPreviousWrap<cr>", {})

-- ####################
--    Plugins - NERDTree
-- ####################
vim.api.nvim_create_autocmd({"VimEnter"}, {
  pattern = {"*"},
  command = 'if argc() == 0 && !exists("s:std_in") | NERDTree | endif'
});
vim.keymap.set("n", "<C-n>", ":NERDTreeToggle<Enter>");

-- ####################
--    Plugins - nvim-web-devicons
-- ####################
require'nvim-web-devicons'.setup()

-- ####################
--    Plugins - Harpoon
-- ####################
local harpoonMark = require("harpoon.mark")
vim.keymap.set("n", "<leader>ht", harpoonMark.toggle_file, {})
vim.keymap.set("n", "<leader>hc", harpoonMark.clear_all, {})
vim.keymap.set("n", "<leader>hl", "<cmd>Telescope harpoon marks<cr>", {})
