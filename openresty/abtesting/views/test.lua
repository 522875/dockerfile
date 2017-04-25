--
-- Created by IntelliJ IDEA.
-- User: chenyongbing
-- Date: 2017/1/17
-- Time: 上午10:43
-- To change this template use File | Settings | File Templates.
--


#!/usr/bin/env index.lua
-- index.lua
require"orbit"

-- 声明
 module("myorbit", package.seeall, orbit.new)

-- 处理程序
function index(web)
  return my_home_page()
end

-- 分配器
myorbit:dispatch_get(index, "/", "/index")

-- 样例页面
function my_home_page()
   return [[
    <head></head>
    <html>
    <h2>First Page</h2>
    </html>
    ]]
end