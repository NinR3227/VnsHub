local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/NinR3227/VnsHub/main/gui.lua"))()
local ShopList = loadstring(game:HttpGet("https://raw.githubusercontent.com/NinR3227/VnsHub/main/shoplist.lua"))()

local ShopRemotes = {
	Seeds = game:GetService("ReplicatedStorage").GameEvents:WaitForChild("BuySeedStock"),
	Gears = game:GetService("ReplicatedStorage").GameEvents:WaitForChild("BuyGearStock"),
	Eggs = game:GetService("ReplicatedStorage").GameEvents:WaitForChild("BuyEggStock")
}

local BUY_COUNT = 25 -- Number of Times to buy each items

for category, itemList in pairs(ShopList) do
	local remote = ShopRemote[category]
	if remote then
		for _, item in ipairs(itemList) do
			for i = 1, BUY_COUNT do
				remote:Fireserver(item)
				wait(0.001)
			end
		end
		print("[Bought All " .. category .. "]")
	else
		warn("[No RemoteEvent found for category: " .. category .. "]")
	end
end