local mode_n = { "n" }
local mode_i = { "i" }
local mode_v = { "v" }
local mode_nv = { "n", "v" }

local keymap = {
    -- { mode = mode_n,      from = "S",               to = "<cmd>w<CR>",                                              desc = "save file" },
    { mode = mode_n,      from = "Q",               to = "<cmd>q<CR>",                                              desc = "quit" },
    { mode = mode_nv,     from = ";",               to = ":",                                                       desc = "command-line mode" },
    { mode = mode_v,      from = "Y",               to = "\"+y",                                                    desc = "yank to sytem clipboard" },
    { mode = mode_nv,     from = "`",               to = "~",                                                       desc = "toggle case" },

		-- Movement
    { mode = mode_nv,     from = "u",               to = "k",                                                       desc = "move up" },
    { mode = mode_nv,     from = "e",               to = "j",                                                       desc = "move down" },
    { mode = mode_nv,     from = "n",               to = "h",                                                       desc = "move left" },
    { mode = mode_nv,     from = "i",               to = "l",                                                       desc = "move right" },
    { mode = mode_nv,     from = "U",               to = "5k",                                                      desc = "move up 5 lines" },
    { mode = mode_nv,     from = "E",               to = "5j",                                                      desc = "move down 5 lines" },
    { mode = mode_nv,     from = "N",               to = "0",                                                       desc = "move to line start" },
    { mode = mode_nv,     from = "I",               to = "$",                                                       desc = "move to line end" },
    { mode = mode_nv,     from = "gu",              to = "gk",                                                      desc = "move up (wrap-aware)" },
    { mode = mode_nv,     from = "ge",              to = "gj",                                                      desc = "move down (wrap-aware)" },
    { mode = mode_nv,     from = "h",               to = "e",                                                       desc = "jump to end of word" },
    { mode = mode_nv,     from = "<C-U>",           to = "5<C-y>",                                                  desc = "scroll up 5 lines" },
    { mode = mode_nv,     from = "<C-E>",           to = "5<C-e>" ,                                                 desc = "scroll down 5 lines" },
    { mode = mode_n,      from = "ci",              to = "cl",                                                      desc = "change one char" },
    { mode = mode_n,      from = "cn",              to = "ch",                                                      desc = "change left char" },
    { mode = mode_n,      from = "ck",              to = "ci",                                                      desc = "change inside object" },
    { mode = mode_n,      from = "yk",              to = "yi",                                                      desc = "yank inside object" },
    { mode = mode_n,      from = "c,.",             to = "c%",                                                      desc = "change inside brackets" },
    { mode = mode_n,      from = "yh",              to = "ye",                                                      desc = "yank to work end" },

		-- Actions
    { mode = mode_n,      from = "l",               to = "u",                                                       desc = "undo" },
    { mode = mode_nv,     from = "k",               to = "i",                                                       desc = "insert before cursor" },
    { mode = mode_nv,     from = "K",               to = "I",                                                       desc = "insert at line start" },

		-- Search
    { mode = mode_n,      from = "=",               to = "nzz",                                                     desc = "next search (centered)" },
    { mode = mode_n,      from = "-",               to = "Nzz",                                                     desc = "prev search (centered)" },
    { mode = mode_n,      from = "<leader><CR>",    to = "<cmd>nohlsearch<CR>",                                     desc = "clear search highlight" },

		-- Useful actions
    { mode = mode_nv,     from = ",.",              to = "%",                                                       desc = "jump to matching bracket" },
    -- { mode = mode_i,      from = "<c-y>",           to = "<ESC>A {}<ESC>i<CR><ESC>ko",                              desc = "insert braces block" },
    { mode = mode_n,      from = "\\v",             to = "v$h",                                                     desc = "visual select to line end -1" },
    { mode = mode_i,      from = "<c-a>",           to = "<ESC>A",                                                  desc = "append at line end" },

		-- Window & splits
    { mode = mode_n,      from = "<leader>w",       to = "<C-w>w",                                                  desc = "switch window" },
    { mode = mode_n,      from = "<leader>u",       to = "<C-w>k",                                                  desc = "move to window up" },
    { mode = mode_n,      from = "<leader>e",       to = "<C-w>j",                                                  desc = "move to window down" },
    { mode = mode_n,      from = "<leader>n",       to = "<C-w>h",                                                  desc = "move to window left" },
    { mode = mode_n,      from = "<leader>i",       to = "<C-w>l",                                                  desc = "move to window right" },
    { mode = mode_n,      from = "qf",              to = "<C-w>o",                                                  desc = "keep only current window" },
    { mode = mode_n,      from = "s",               to = "<nop>",                                                   desc = "disable default s" },
    -- { mode = mode_n,      from = "su",              to = "<cmd>set nosplitbelow<CR>:split<CR>:set splitbelow<CR>",  desc = "split above" },
    -- { mode = mode_n,      from = "se",              to = "<cmd>set splitbelow<CR>:split<CR>",                       desc = "split below" },
    -- { mode = mode_n,      from = "sn",              to = "<cmd>set nosplitright<CR>:vsplit<CR>:set splitright<CR>", desc = "split left" },
    -- { mode = mode_n,      from = "si",              to = "<cmd>set splitright<CR>:vsplit<CR>",                      desc = "split right" },
    { mode = mode_n,      from = "<up>",            to = "<cmd>res +5<CR>",                                         desc = "increase window height" },
    { mode = mode_n,      from = "<down>",          to = "<cmd>res -5<CR>",                                         desc = "decrease window height" },
    { mode = mode_n,      from = "<left>",          to = "<cmd>vertical resize -5<CR>",                             desc = "decraase window left" },
    { mode = mode_n,      from = "<right>",         to = "<cmd>vertical resize +5<CR>",                             desc = "increase window right" },
    -- { mode = mode_n,      from = "srh",             to = "<C-w>b<C-w>K",                                            desc = "move window to top (horizontal)" },
    -- { mode = mode_n,      from = "srv",             to = "<C-w>b<C-w>H",                                            desc = "move window to left (vertical)" },

		-- Tab management
    { mode = mode_n,      from = "tu",              to = "<cmd>tabe<CR>",                                           desc = "new tab" },
    { mode = mode_n,      from = "tU",              to = "<cmd>tab split<CR>",                                      desc = "split current window to new tab" },
    { mode = mode_n,      from = "tn",              to = "<cmd>-tabnext<CR>",                                       desc = "previous tab" },
    { mode = mode_n,      from = "ti",              to = "<cmd>+tabnext<CR>",                                       desc = "next tab" },
    { mode = mode_n,      from = "tmn",             to = "<cmd>-tabmove<CR>",                                       desc = "move tab left" },
    { mode = mode_n,      from = "tmi",             to = "<cmd>+tabmove<CR>",                                       desc = "move tab right" },


		-- Other
    { mode = mode_n,      from = "<leader>sw",      to = "<cmd>set wrap!<CR>",                                      desc = "toggle warp" },
    { mode = mode_n,      from = "<leader>sc",      to = "<cmd>set spell!<CR>",                                     desc = "toggle spell check" },
    -- { mode = mode_n,      from = "<leader>ss",      to = ":%s/\\<<C-r><C-w>\\>//g<left><left>",                     desc = "global replacement", noise = true },
    { mode = mode_n,      from = ",v",              to = "v%",                                                      desc = "select inside matching brackets" },
    { mode = mode_n,      from = "<leader><esc>",   to = "<nop>",                                                   desc = "disable accidental <leader><esc>" },
    { mode = mode_n,      from = "<leader>p",       to = "<cmd>Lazy<CR>",                                           desc = "open Lazy plugin manager" },
}

for _, mapping in ipairs(keymap) do
    if mapping.desc then
        vim.keymap.set(mapping.mode, mapping.from, mapping.to, { noremap = true, silent = true, desc = mapping.desc })
    else
        vim.keymap.set(mapping.mode, mapping.from, mapping.to, { noremap = true, silent = true })
    end
    if mapping.noise == true then
        vim.keymap.set(mapping.mode, mapping.from, mapping.to, { noremap = true })
    end
end
