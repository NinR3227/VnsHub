-- ⚡ Ultra-Fast Auto-Buy: Seeds + Gears with Live Toggles

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")

-- 🔄 Hot‑Reload Helper: forces fresh fetch every run, safe compile
local function fetchLatest(url)
    local versionTag = "?_v=" .. tostring(os.time()) -- bypass cache
    local src
    local ok, err = pcall(function()
        src = game:HttpGet(url .. versionTag)
    end)
    if not ok then
        warn("[Loader] HTTP error: " .. tostring(err))
        return nil
    end

    local compiler = loadstring or load
    if not compiler then
        warn("[Loader] No Lua compiler (load/loadstring) available.")
        return nil
    end

    local fn, compileErr = compiler(src)
    if not fn then
        warn("[Loader] Compile error: " .. tostring(compileErr))
        return nil
    end

    local runOk, result = pcall(fn)
    if not runOk then
        warn("[Loader] Runtime error: " .. tostring(result))
        return nil
    end
    return result
end

-- 🧹 Remove any old GUI before loading the new one (client‑safe)
if Players.LocalPlayer then
    local pg = Players.LocalPlayer:WaitForChild("PlayerGui")
    local oldGui = pg:FindFirstChild("AutoBuyGui")
    if oldGui then oldGui:Destroy() end
else
    warn("[GUI] LocalPlayer not available — running in server context? GUI will be skipped.")
end

-- Remotes by category
local ShopRemotes = {
    Seeds = GameEvents:FindFirstChild("BuySeedStock") or GameEvents:WaitForChild("BuySeedStock", 5),
    Gears = GameEvents:FindFirstChild("BuyGearStock") or GameEvents:WaitForChild("BuyGearStock", 5),
}

-- ✅ Load modules
local GUI = fetchLatest("https://raw.githubusercontent.com/NinR3227/VnsHub/main/gui.lua")
local ShopList = fetchLatest("https://raw.githubusercontent.com/NinR3227/VnsHub/main/shoplist.lua") or {}

-- Global toggles table (controlled by GUI)
_G.AutoBuyToggles = _G.AutoBuyToggles or {Seeds = false, Gears = false}

-- Validate ShopList
if type(ShopList) ~= "table" then
    warn("[ShopList] Invalid or missing table — aborting.")
    ShopList = {}
end

-- Validate remotes
for cat, remote in pairs(ShopRemotes) do
    if remote == nil then
        warn("[Remote] Missing for category: " .. cat)
    else
        print("[Remote] " .. cat .. " -> " .. remote.ClassName .. " (" .. remote.Name .. ")")
    end
end

-- Fire wrapper
local function fire(remote, itemName)
    if not remote then return false, "nil remote" end
    if remote:IsA("RemoteEvent") then
        local ok, err = pcall(function()
            remote:FireServer(itemName)
        end)
        return ok, err
    elseif remote:IsA("RemoteFunction") then
        local ok, res = pcall(function()
            return remote:InvokeServer(itemName)
        end)
        return ok, res
    else
        return false, "Unsupported remote type: " .. remote.ClassName
    end
end

-- Tunables
local BUY_COUNT = 25
local MIN_STEP_DELAY = 0 -- 0 = fastest burst

-- --- Toggle‑aware category controllers
for category, itemList in pairs(ShopList) do
    local remote = ShopRemotes[category]

    if remote == nil or not (remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction")) then
        warn("[Skip] No valid remote for category: " .. tostring(category))
        continue
    end
    if type(itemList) ~= "table" then
        warn("[Skip] Item list for " .. tostring(category) .. " is not a table")
        continue
    end

    task.spawn(function()
        print("[Ready] " .. category .. " controller running. Toggle ON in GUI to start.")
        while true do
            -- Idle until ON
            while not (_G.AutoBuyToggles and _G.AutoBuyToggles[category]) do
                task.wait(0.2)
            end

            print("[Go] " .. category .. " ON — buying " .. tostring(#itemList) .. " items")
            for _, itemName in ipairs(itemList) do
                -- Burst per item in a separate task
                task.spawn(function()
                    for i = 1, BUY_COUNT do
                        if not (_G.AutoBuyToggles and _G.AutoBuyToggles[category]) then
                            break -- toggle OFF mid‑burst
                        end
                        local ok, err = fire(remote, itemName)
                        if not ok then
                            warn("[Fail] " .. category .. " -> " .. tostring(itemName) .. " (" .. tostring(i) .. "): " .. tostring(err))
                        end
                        if MIN_STEP_DELAY > 0 then
                            task.wait(MIN_STEP_DELAY)
                        else
                            task.wait()
                        end
                    end
                end)
            end

            -- Cooldown before re‑checking
            task.wait(0.5)
        end
    end)
end