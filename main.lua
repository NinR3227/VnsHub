local ShopList = loadstring(readfile("shoplist.lua"))()
local BuySeedStock = game:GetService("ReplicatedStorage").GameEvents:WaitForChild("BuySeedStock")

for _, seed in ipairs(ShopList.Seeds) do
    BuySeedStock:FireServer(seed)
    wait(0.2)
end

print("[✅ Bought All Seeds]")