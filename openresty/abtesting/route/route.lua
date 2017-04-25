local route_kop = require('abtesting.route.route_kop')
local route_cookie = require('abtesting.route.route_cookie')
local route_header = require('abtesting.route.route_header')

local get_uid = function()
  local system_name = ngx.var.system_name
  local uid = nil
  if system_name == 'kop' or system_name=="kop-server" then
      uid = route_kop.get_device_sn()
      -- ngx.say("uid:", uid)
  end
  -- 如果开放平台获取device_sn失败，也可以使用x-ab-uid代替uid
  if not uid then
      uid = route_header.get_header()
  end
  if not uid then
      uid = route_cookie.get_cookie()
  end
  return uid
end

local get_cookie = function()
  return route_cookie.get_cookie()
end

local gen_key = function(system,key)
    if not key  or not system then return  end
    return "uid_"..system.."_"..key
end


local get_upstream = function(key)
  if not key then return end
--  local cache_name = ngx.var.system_name .. '_upstream_cache'
  local cache_name = 'ks_upstream_cache'
  local mycache = ngx.shared[cache_name]
  if not mycache then return  end
  local value = mycache:get(key)
  return value
end


function run()
    local system_name = ngx.var.system_name
    local uid = get_uid()
    local upstream = nil
    -- ngx.say("uid", uid)
    -- 这里需要用gen_key
    upstream = get_upstream(gen_key(system_name,uid))
--    if not upstream then
--      uid = get_cookie()
--
--      upstream = get_upstream(uid)
--    end
    if not upstream then return end
    ngx.log(ngx.NOTICE, "proxy upstream:", upstream)
    ngx.var.proxy_url = upstream
    ngx.header['X-AB-ProxyPass'] = upstream
    ngx.header['X-AB-UID'] = uid
end

run()
