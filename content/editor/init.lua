local PATH = (...):gsub('%.[^%.]+$', '')
local function Init()
    local mod = {}
    local imgui = require("imgui")
    return mod
end

return Init()
