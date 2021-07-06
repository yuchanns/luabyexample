local BasePlugin = require "kong.plugins.base_plugin"
local CustomHandler = BasePlugin:extend()
local kong = kong.response
local ngx = ngx

function CustomHandler:new()
    CustomHandler.super.new(self, "orgcode")
end

function CustomHandler:init_worker()
    CustomHandler.super.init_worker(self)
end

function CustomHandler:certificate(config)
    CustomHandler.super.certificate(self)
end

function CustomHandler:rewrite(config)
    CustomHandler.super.rewrite(self)
end

function replace_host_from_redis(red, orgcode)
    local value = red:hget("organization_env",orgcode)
    if type(value) == "string" and value ~= ""
    then
        local values = strsplit(value, ":")
        if type(values[1]) == "string" and values[1] ~= "" then
            ngx.ctx.balancer_data.host = values[1]
            -- 反向代理到其他网关，需要保持路径不变
            ngx.var.upstream_uri = ngx.var.uri
        end
        if type(values[2]) == "string" and values[2] ~= "" then
            ngx.ctx.balancer_data.port = values[2]
        end
        return
    end
end

function strsplit (inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

function CustomHandler:access(config)
    CustomHandler.super.access(self)
    local ip = config.redis_host
    local passwd = config.redis_passwd
    local port = 6379
    local redis = require "resty.redis"
    local red = redis:new()
    red:set_timeout(50000) -- 1 sec
    local ok, err = red:connect(ip, port)
    if not ok then
        ngx.log(ngx.ERR, "connect redis fail")
        return
    end
    local res, err = red:auth(passwd)
    if not res then
        ngx.log(ngx.ERR, "auth redis fail")
        return
    end
    local headers = ngx.req.get_headers()
    local query_header = headers["orgcode"]
    if query_header
    then
        replace_host_from_redis(red, query_header)
    end
end

function CustomHandler:header_filter(config)
    CustomHandler.super.header_filter(self)
end

function CustomHandler:body_filter(config)
    CustomHandler.super.body_filter(self)
end

function CustomHandler:log(config)
    CustomHandler.super.log(self)
end

return CustomHandler