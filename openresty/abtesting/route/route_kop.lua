local dkjson = require('abtesting.libs.dkjson')

local _M = {}

local get_post_args = function()
    ngx.req.read_body()
    local request_args = ngx.req.get_post_args()

    -- ngx.say("args", request_args.biz_content)
    local biz_content = request_args.biz_content
    if biz_content==nil then
        return nil
    end

    local biz_content_table , p , err = dkjson.decode(biz_content)
    if err then
        ngx.log(ngx.ERR  , 'biz_content decode 出错,'..biz_content)
        return nil
    end
    -- ngx.say("biz", biz_content_table.device_sn)
    return biz_content_table
end


_M.get_device_sn = function(self)
    local biz_content_table = get_post_args()

    if biz_content_table == nil then
        -- ngx.say("no biz content")
        return end
    device_sn = biz_content_table.device_sn

    if not device_sn or device_sn == "" then
        return nil
    end
    return device_sn
end


return _M
