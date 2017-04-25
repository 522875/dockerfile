

local _M = {}

_M.get_header = function()
    local headers = ngx.req.get_headers()
    local uid = headers['x-ab-uid']
    if not uid or uid == '' then return end
    return uid
end



return _M
