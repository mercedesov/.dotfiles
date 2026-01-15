vim.opt.number = true          
vim.opt.relativenumber = true   
vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true        
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.mouse = "a"            
vim.opt.termguicolors = true    
vim.opt.swapfile = false       

vim.cmd [[
  highlight LineNr ctermfg=cyan guifg=cyan
  highlight CursorLineNr ctermfg=cyan guifg=cyan
]]

vim.opt.wrap = true            
vim.opt.linebreak = true       
vim.opt.textwidth = 80  

highlight ColorColumn ...
vim.opt.colorcolumn = "81"

vim.opt.formatoptions = "tcrqn"
vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 6

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.undofile = true
