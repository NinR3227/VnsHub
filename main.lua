-- main.lua
-- Entry for Germa66 modular UI

local function fetch(url)
    local ok, src = pcall(function() return game:HttpGet(url, true) end)
    if not ok then warn("[Germa66] Failed to fetch: " .. tostring(src)) return nil end
    local chunk, err = loadstring(src)
    if not chunk then warn("[Germa66] Compile error: " .. tostring(err)) return nil end
    local ok2, mod = pcall(chunk)
    if not ok2 then warn("[Germa66] Runtime error: " .. tostring(mod)) return nil end
    return mod
end

-- Set your GitHub RAW base (trailing slash required)
local BASE = "https://raw.githubusercontent.com/YourUser/YourRepo/main/"

local Utils = fetch(BASE .. "utils.lua")
local Gui = fetch(BASE .. "gui.lua")
local BuildAutomation = fetch(BASE .. "automation.lua")

if not (Utils and Gui and BuildAutomation) then
    warn("[Germa66] Missing one or more modules; aborting init")
    return
end

-- Init base window
Gui.init(Utils)

-- Sidebar: four options, only the 2nd is active (Automation Panel)
Gui.addMenuItem({ label = "Reserved", name = "Reserved1", disabled = true })
Gui.addMenuItem({
    label = "Automation Panel",
    name = "Automation Panel",
    onClick = function()
        -- build panel if not already
        local state = Gui.getRoot()
        if not state.panels["Automation Panel"] then
            BuildAutomation(Gui, Utils)
        end
    end
})
Gui.addMenuItem({ label = "Reserved", name = "Reserved3", disabled = true })
Gui.addMenuItem({ label = "Reserved", name = "Reserved4", disabled = true })

-- Create placeholder panels for reserved (optional)
local resPanel = Gui.createPanel("Reserved")
local resText = Utils.createText(resPanel, "Reserved for future updates", 16, Utils.Theme.Muted, false)
resText.TextXAlignment = Enum.TextXAlignment.Center

-- Default to Automation Panel selection
task.defer(function()
    Gui.showPanel("Automation Panel")
    -- simulate clicking its button to highlight
    local root = Gui.getRoot()
    for _, info in ipairs(root.menuButtons) do
        if info.name == "Automation Panel" then
            info.button:Activate()
            break
        end
    end
end)

print("[Germa66] UI loaded")