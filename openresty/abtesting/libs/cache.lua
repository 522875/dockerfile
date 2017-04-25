local ERRORINFO     = require('abtesting.error.errorcode').error


local _M = {}
_M._VERSION = '0.1'

_M.new = function(self, system, sharedCache)
    if not sharedCache then
        error{ERRORINFO.ARG_BLANK_ERROR, 'cache name valid from nginx.conf'}
    end
    self.system = system
    self.cache = ngx.shared[sharedCache]
    if not self.cache then
        error{ERRORINFO.PARAMETER_ERROR, 'cache name [' .. sharedDict .. '] valid from nginx.conf'}
    end

    return setmetatable(self, { __index = _M } )
end

_M.setUpstream = function(self, key, upstream)
    local cache = self.cache
    local ok,err = cache:set(key, upstream, 0)
    local result = 'yes'
    if not ok then result = 'no' end
    ngx.say("Set system:",self.system," Upstream:", key,"=",upstream, ", Is Ok? ", result)

end

_M.getUpstream = function(self, key)
    local cache = self.cache
    local val,err = cache:get(key)
    ngx.say("Get system:", self.system, " Upstream:", key,"=", val)
end

return _M
