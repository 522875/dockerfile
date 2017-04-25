local dkjson = require('abtesting/libs/dkjson')

local _M = {}

-- 知店支持X-UID和Cookie两种方式


_M.get_post_args = function(self)
    local body_data = ngx.req.get_body_data()
    if not body_data then return end
    local obj, pos, err = dkjson.decode(body_data, 1, nil)
end


_M.get_shop = function(self)

end


return _M
