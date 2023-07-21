package = "kong-plugin-header-rewrite"
version = "1.1.0-1"

local pluginName = package:match("^kong%-plugin%-(.+)$")  -- "header-rewrite"
supported_platforms = {"linux", "macosx"}

source = {
  url = "https://gitlab.devops.telekom.de/fast/infr/tools/kong-plugins/apigw/header-rewrite",
  tag = "1.0.0"
}

description = {
  summary = "The plugin that allows to rewrite header at request"
}
dependencies = {
  "lua ~> 5"
}
build = {
   type = "builtin",
   modules = {
    ["kong.plugins."..pluginName..".handler"] = "kong/plugins/"..pluginName.."/handler.lua",
    ["kong.plugins."..pluginName..".schema"] = "kong/plugins/"..pluginName.."/schema.lua"
   }
}