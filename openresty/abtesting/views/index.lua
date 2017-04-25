--
-- Created by IntelliJ IDEA.
-- User: chenyongbing
-- Date: 2017/1/12
-- Time: 上午10:07
-- To change this template use File | Settings | File Templates.
--

local orbit=require"orbit"

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


function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function get_systems()
    local systems = {}
    local mycache = get_cache()
    local keys = mycache:get_keys()
    for i , k in pairs(keys) do
        local system = ngx.re.sub(k,"uid_","")
        local system = ngx.re.sub(system,"_.*$","")
        if not table.contains(systems , system) then
            table.insert(systems , system)
        end
    end
    return systems

end



function list()
    local headers = { ["Content-type"] = "text/html" }
    local systems = get_systems()
    ngx.log(ngx.ERR , table.concat(systems, ","))
--    local headers = { ["Content-type"] = "text/html" }


--    return table.concat(systems, ",")
--   return 200, headers, coroutine.wrap(hello_text)
    html  = "<html><head><title name=\"系统列表\"></title></head><body>%s</body></html>"
    body = ""
    for _,v in pairs(systems) do
        ngx.log(ngx.ERR , v)
        li = "<li><a href=\"/ab/show?system=%s\">%s</a></li>"
        li = string.format(li , v , v)
        body = body .. li
    end

    return string.format(html , body)
--    return 200, headers, string.format(html , body)
end

--orbit.htmlify(generate)
ngx.say(list())