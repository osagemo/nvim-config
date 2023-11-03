local has = vim.fn.has

local M = {}
M.is_win = has "win32" == 1
M.silent = { silent = true }

return M
