local ShopList = loadstring(game:HttpGet("https://raw.githubusercontent.com/NinR3227/VnsHub/main/shoplist.lua"))()
local BuySeedStock = game:GetService("ReplicatedStorage").GameEvents:WaitForChild("BuySeedStock")

for _, seed in ipairs(ShopList.Seeds) do
    BuySeedStock:FireServer(seed)
    wait(0.2)
end

print("[✅ Bought All Seeds]")