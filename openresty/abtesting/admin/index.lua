local dkjson = require('abtesting.libs.dkjson')
local log = ngx.log

local _M = {}

_M.new = function(self)
    return setmetatable(self, { __index = _M } )
end

local say_error = function(msg)
    ngx.status = 500
    ngx.say("{\"code\":500, \"msg\":\"", msg,"\"}")
    ngx.exit(500)
end

local say_ok = function(msg,data)
    if not data then
        ngx.say("{\"code\":200, \"msg\":\"", msg,"\"}")
    else
        ngx.say(dkjson.encode({code=200,msg=msg,data=data}))
    end
end

local get_sys_name = function(k)
    local from, to, err = ngx.re.find(k, "uid_(.*)_", "jo")
    local sys_name = string.sub(k, from+4, to-1)
    return sys_name
end


local inTable = function(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then return key end
    end
    return false
end

local get_args = function()
    local method = ngx.req.get_method()
    if method == 'GET' then
        local args, err = ngx.req.get_uri_args()
        return args
    elseif method == 'POST' then
        ngx.req.read_body()
        local args, err = ngx.req.get_post_args()
        return args
    end
end

local get_cache = function()
--    local cache_name = system .. '_upstream_cache'
    local cache_name = 'ks_upstream_cache'
    local mycache = ngx.shared[cache_name]
    if not mycache then
        say_error("找不到缓存:" .. cache_name)
        return
    end
    return mycache
end

local gen_key = function(system,key)
    if not key  or not system then return "null" end
    return "uid_"..system.."_"..key
end

_M.ab_get = function(self)
    local request_args = get_args()
    if not request_args then
        say_error("get request args error")
    end
    local system = request_args.system
    local uid = request_args.uid
    if not system or not uid then
        say_error("缺少参数, system,uid")
        return
    end

    local mycache = get_cache()
    if not mycache then return end
    local key = gen_key(system,uid)
    local value = mycache:get(key)
    if not value then value = "null" end
--    say_ok("proxy upstream: ".. key .. "=".. value)
    say_ok("返回成功",{key=key,value=value})
end

_M.ab_set = function(self)
    local request_args = get_args()
    if not request_args then
        say_error("get request args error")
    end

    local system = request_args.system
    local uid = request_args.uid
    local upstream_url = request_args.upstream
    if not system or not uid or not upstream_url then
        say_error("缺少参数, system,uid,upstream")
        return
    end

    local mycache = get_cache()
    local key =  gen_key(system,uid)
    mycache:set(key, upstream_url, 0)
    say_ok("设置成功, " .. key .. "=" .. mycache:get(key))
end



_M.ab_get_sys = function(self)
    local systems = {}
    local mycache = get_cache()
    if not mycache then return end
    local keys = mycache:get_keys(200)
    if not keys then
        say_ok("keys are empty.")
    end
    for i,k in pairs(keys) do
        print(i,k)
        if ngx.re.match(k,"^uid_") then
            local system = get_sys_name(k)
            if not inTable(systems,system) then
                table.insert(systems , system)
            end
        end
    end
    say_ok("返回成功",systems)
end




_M.ab_get_all = function(self)
    local request_args = get_args()
    if not request_args then
        say_error("get request args error")
    end
    local system = request_args.system
    if not system then
        say_error("缺少参数, system")
        return
    end
    local mycache = get_cache()
    if not mycache then return end
    local keys = mycache:get_keys(200)
    local values = {}

    if not keys then
        say_ok("keys are empty")
    end
    for i,k in pairs(keys) do
      print(i,k)
      if ngx.re.match(k,"^uid_"..system.."_") then
          local v = mycache:get(k)
          if v == nil then v = "" end
--          table.insert(values, k .. "=" .. v)
          table.insert(values,{key=k,value=v})
      end
    end
--    say_ok(table.concat(values, "\n"))
    say_ok("返回成功",values)
end

_M.ab_del = function(self)
    local request_args = get_args()
    if not request_args then
        say_error("get request args error")
    end
    local system = request_args.system
    local uid = request_args.uid
    if not system or not uid then
        say_error("缺少参数, system,uid")
        return
    end

    local mycache = get_cache()
    if not mycache then return end
    local key = gen_key(system,uid)
    local value = mycache:set(key, nil)
    say_ok("delete key:".. key .. " ok")
end

_M.ab_del_all = function(self)
    local request_args = get_args()
    if not request_args then
        say_error("get request args error")
    end
    local system = request_args.system
    if not system then
        say_error("缺少参数, system")
        return
    end
    local mycache = get_cache()
    if not mycache then return end


    local keys = mycache:get_keys(200)
    local values = {}

    if not keys then
        say_ok("keys are empty")
    end
    for i,k in pairs(keys) do
        if ngx.re.match(k,"^uid_"..system.."_") then
            ret = mycache:delete(k)
            ngx.log(ngx.NOTICE , "delete key "..k,ret)
        end
    end
--    local keys = mycache:flush_all()
    say_ok("flush keys ok")
end

return _M
-- ngx.say("args:", args)
