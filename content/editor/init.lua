local PATH = (...):gsub('%.[^%.]+$', '')
local function Init()
    local mod = {}
    local imgui = require(PATH .. "imgui")
    return mod
end

return Init()
