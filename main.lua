-- ⚡️ Ultra-Fast Auto-Buy: Seeds + Gears, Fully Parallel

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")

local ShopRemotes = {
    Seeds = GameEvents:WaitForChild("BuySeedStock"),
    Gears = GameEvents:WaitForChild("BuyGearStock"),
}

local ShopList = loadstring(game:HttpGet("https://raw.githubusercontent.com/NinR3227/VnsHub/main/shoplist.lua"))()
local BUY_COUNT = 25

-- 🚀 Spawn each category in parallel
for category, itemList in pairs(ShopList) do
    local remote = ShopRemotes[category]
    if remote and remote:IsA("RemoteEvent") then
        task.spawn(function()
            for _, itemName in ipairs(itemList) do
                task.spawn(function()
                    for i = 1, BUY_COUNT do
                        remote:FireServer(itemName)
                        task.wait() -- ⚡️ No delay, pure burst
                    end
                end)
            end
            print("[✅ Buying " .. category .. " in parallel...]")
        end)
    else
        warn("[⚠️ No valid RemoteEvent for category: " .. category .. "]")
    end
end