-- main.lua
-- Entry point for Nin's new modular GUI

-- Helper to load remote Lua files
local function load(url)
    local ok, src = pcall(function()
        return game:HttpGet(url, true)
    end)
    if not ok then
        warn("[NinGUI] Failed to fetch: " .. tostring(src))
        return function() end
    end
    local chunk, err = loadstring(src)
    if not chunk then
        warn("[NinGUI] Compile error: " .. tostring(err))
        return function() end
    end
    return chunk()
end

local base = "https://raw.githubusercontent.com/NinR3227/VnsHub/main/"

-- Load utilities first so _G.utils is ready for all modules
_G.utils = load(base .. "utils.lua")

-- Load the base GUI skeleton; it returns an addTab(name, builder) function
local addTab = load(base .. "gui.lua")

-- Add your first tab to prove everything works
addTab("Example", function(container)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = "Hello from the Example Tab!"
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 20
    label.Parent = container
end)

print("[NinGUI] Loaded successfully")