local modulename = 'abtestingErrorInfo'
local _M = {}

_M._VERSION = '0.0.1'

_M.error = {
["SUCCESS"]			        = { 200,   'success '},
["PARAMETER_ERROR"]         = { 50001, '参数错误'},
["ARG_BLANK_ERROR"]         = { 50002, '输入参数错误'},


}

return _M
