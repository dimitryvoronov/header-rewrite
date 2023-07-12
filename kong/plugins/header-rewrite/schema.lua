local typedefs = require "kong.db.schema.typedefs"

return {
    name = "header-rewrite",
    fields = {
      -- Enable/disable the plugin logic
      { enabled = { type = "boolean", default = true } },
      -- Specify the header to modify
      { header = { type = "string", required = true } },
      -- Define the custom URL prefix
      { apigw_url = { type = "url", required = true, default = "http://apigateway_url:8080/upstream-partner/postfix_path" } },
    },
  }
  
