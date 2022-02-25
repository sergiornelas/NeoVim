-- Neovide
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_transparency = 0.8
vim.g.neovide_refresh_rate = 60
vim.g.neovide_transparency = 0.85

-- HARDTIME
-- vim.g.hardtime_default_on = 1
-- vim.g.hardtime_maxcountj= 5
-- vim.g.hardtime_timeout = 1000

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

vim.opt.shortmess:append("c")

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd("set nofoldenable") --helps with everything fold

-- This will keep your cursor centered when you start up, move to another window,
-- add or remove windows or tabs, or resize the GUI. You can disable it during
-- your session with
-- vim.cmd([[
--   augroup VCenterCursor
--   au!
--   au BufEnter,WinEnter,WinNew,VimResized *,*.*
--   \ let &scrolloff=winheight(win_getid())/2
--   augroup END
-- ]])
-- au! VCenterCursor

-- Using autocmd and CursorMoved/CursorMovedI events, zz
-- is applied to every keystroke that would change the cursor position.
-- Minorly optimized by only applying zz to vertical line movement.
-- Will update to lua once autocmd is natively supported, vimscript is
-- currently more performant.

-- vim.api.nvim_exec(
-- 	[[
--     :function StayCenteredI()
--     :  let line = line(".")
--     :  if line != get(b:, 'last_line', 0)
--     :    let col = getcurpos()[4]
--     :    normal! zz
--     :    call cursor(line, col)
--     :    let b:last_line = line
--     :  endif
--     :endfunction
--     :function StayCentered()
--     :  let line = line(".")
--     :  if line != get(b:, 'last_line', 0)
--     :    normal! zz
--     :    let b:last_line = line
--     :  endif
--     :endfunction
--     augroup StayCentered
--       autocmd!
--       autocmd CursorMovedI * :call StayCenteredI()
--       autocmd CursorMoved * :call StayCentered()
--     augroup END
--   ]],
-- 	true
-- )
