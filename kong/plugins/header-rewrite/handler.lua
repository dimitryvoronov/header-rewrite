local plugin = require("kong.plugins.base_plugin"):extend()

-- constructor
function plugin:new()
  plugin.super.new(self, "header-rewrite")
end

-- This function will be called for each request
function plugin:access(config)
  -- Check if the plugin is enabled
  if config.enabled then
    -- Check if the specified header exists and is not empty
    local headerValue = kong.request.get_header(config.header)
    if headerValue and headerValue ~= "" then
      -- Modify the header value with the custom URL prefix
      local modifiedHeaderValue = config.apigateway_url .. headerValue
      kong.service.request.set_header(config.header, modifiedHeaderValue)
    end
  end
end

-- This function will be called for each response
function plugin:header_filter(config)
  -- Check if the plugin is enabled
  if config.enabled then
    local responseStatus = kong.response.get_status()

    if responseStatus >= 400 then
      -- Modify headers and body for error responses (4xx and 5xx)
      local responseBody = kong.response.get_body()

      if responseStatus >= 400 and responseStatus <= 499 then
        -- Client-side error response (4xx)
        kong.response.set_header("X-Error", "Client Error")
        kong.response.set_body("Client Error: " .. responseBody)
      elseif responseStatus >= 500 and responseStatus <= 599 then
        -- Server-side error response (5xx)
        kong.response.set_header("X-Error", "Server Error")
        kong.response.set_body("Server Error: " .. responseBody)
      end
    end
  end
end

-- Set the plugin priority to execute it early in the processing chain
plugin.PRIORITY = 1000

return plugin
