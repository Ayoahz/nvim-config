---@diagnostic disable: need-check-nil
-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- 定义一个全局变量来保存 fcitx5 的状态
_G.fcitx5state = 0

-- 当从插入模式离开时触发的函数
function fcitx5_disable()
  local handle = io.popen("fcitx5-remote")
  local result = handle:read("*a")
  handle:close()
  _G.fcitx5state = tonumber(result)
  os.execute("fcitx5-remote -c")
end

-- 当进入插入模式时触发的函数，此处暂时将恢复中文设置为否
function fcitx5_enable()
  -- if _G.fcitx5state == 2 then
  --   os.execute("fcitx5-remote -o")
  -- end
end

-- 自动命令配置
vim.cmd([[
  augroup fcitx5_group
    autocmd!
    autocmd InsertLeave * lua fcitx5_disable()
    autocmd InsertEnter * lua fcitx5_enable()
  augroup END
]])
