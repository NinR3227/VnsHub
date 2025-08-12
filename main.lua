-- main.lua
-- Entry for Germa66 modular UI

local function fetch(url)
    local ok, src = pcall(function() return game:HttpGet(url, true) end)
    if not ok then warn("[Germa66] Fetch failed: " .. tostring(src)) return nil end
    local chunk, err = loadstring(src)
    if not chunk then warn("[Germa66] Compile error: " .. tostring(err)) return nil end
    local ok2, result = pcall(chunk)
    if not ok2 then warn("[Germa66] Runtime error: " .. tostring(result)) return nil end
    return result
end

-- Replace with your repo RAW base (must end with /)
local BASE = "https://raw.githubusercontent.com/NinR3227/VnsHub/main/"

local Utils = fetch(BASE .. "utils.lua")
local Gui = fetch(BASE .. "gui.lua")
local BuildAutomation = fetch(BASE .. "automation.lua")

if not (Utils and Gui and BuildAutomation) then
    warn("[Germa66] Missing one or more modules; aborting init")
    return
end

Gui.init(Utils)

-- Sidebar menu: 4 options, only 2nd is active
Gui.addMenuItem({ label = "Reserved", name = "Reserved1", disabled = true })
Gui.addMenuItem({
    label = "Automation Panel",
    name = "Automation Panel",
    onClick = function()
        local root = Gui.getRoot()
        if not root.panels["Automation Panel"] then
            BuildAutomation(Gui, Utils)
        end
        Gui.showPanel("Automation Panel")
    end
})
Gui.addMenuItem({ label = "Reserved", name = "Reserved3", disabled = true })
Gui.addMenuItem({ label = "Reserved", name = "Reserved4", disabled = true })

-- Optional: placeholder panel
local p = Gui.createPanel("Reserved")
local txt = Utils.createText(p, "Reserved for future updates", 16, Utils.Theme.Muted, false, Enum.TextXAlignment.Center)
txt.TextXAlignment = Enum.TextXAlignment.Center

-- Default selection
task.defer(function()
    Gui.showPanel("Automation Panel")
    local root = Gui.getRoot()
    for _, info in ipairs(root.menuButtons) do
        if info.name == "Automation Panel" then
            Utils.setActiveButton(info.button, true)
            break
        end
    end
end)

print("[Germa66] UI loaded")