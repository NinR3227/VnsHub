local ShopList = loadstring(game:HttpGet("https://raw.githubusercontent.com/NinR3227/VnsHub/main/shoplist.lua"))()
local BuySeedStock = game:GetService("ReplicatedStorage").GameEvents:WaitForChild("BuySeedStock")

local BUY_COUNT = 25 -- Number of Times to buy each seed

for _, seed in ipairs(ShopList.Seeds) do
	for i = 1, BUY_COUNT do
		BuySeedStock:FireServer(seed)
		wait(0.1)
	end
end

print ("[Bought All Seeds x" ..BUY_COUNT .. "]")