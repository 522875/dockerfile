

local _M = {}

--_M.get_cookie = function()
--    local abproxy = ngx.var.cookie_AB_PROXY
--    if not (abproxy == "yes" or abproxy == "true") then return end
--    return 'bycookie'
--end

_M.get_cookie = function()
    local uid = ngx.var["cookie_X-AB-UID"]
    ngx.log(ngx.NOTICE , "cookie_X-AB-UID : ",uid)
    return uid
end


return _M
