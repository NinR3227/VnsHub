--========================================================
-- VnsHub Main GUI Script  |  Cleaned & merged August 2025
--========================================================

--== Player setup ==
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local serverId = game.JobId ~= "" and game.JobId or "Local/Studio"

--== ScreenGui ==
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GardenGameGUI"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

--== Main Frame ==
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

--== Window Controls ==
local minimizeButton = Instance.new("TextButton", mainFrame)
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -70, 0, 0)
minimizeButton.Text = "—"
minimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
minimizeButton.TextColor3 = Color3.new(1, 1, 1)

local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.Text = "✖"
closeButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

--== ShopList load (safe) ==
local success, ShopList = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/NinR3227/VnsHub/main/ShopList.lua"))()
end)
if not success then
    warn("[VnsHub] ShopList load failed:", ShopList)
    ShopList = {}
end

--== Restore Button ==
local restoreButton = Instance.new("TextButton", screenGui)
restoreButton.Size = UDim2.new(0, 100, 0, 30)
restoreButton.Position = UDim2.new(0, 10, 0, 10)
restoreButton.Text = "Vns"
restoreButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
restoreButton.TextColor3 = Color3.new(1, 1, 1)
restoreButton.Visible = false

minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    restoreButton.Visible = true
end)
restoreButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    restoreButton.Visible = false
end)

--== Tabs ==
local tabs = {"Main", "Misc", "Pet"}
local tabFrames = {}

for i, tabName in ipairs(tabs) do
    local tabButton = Instance.new("TextButton", mainFrame)
    tabButton.Size = UDim2.new(0, 120, 0, 25)
    tabButton.Position = UDim2.new(0, 0, 0, 30 + ((i - 1) * 30))
    tabButton.Text = tabName
    tabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    tabButton.TextColor3 = Color3.new(1, 1, 1)
    tabButton.Font = Enum.Font.SourceSans
    tabButton.TextSize = 18
    tabButton.BorderSizePixel = 0

    local tabFrame = Instance.new("Frame", mainFrame)
    tabFrame.Size = UDim2.new(1, -130, 1, -30)
    tabFrame.Position = UDim2.new(0, 130, 0, 30)
    tabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tabFrame.Visible = (i == 1)
    tabFrames[tabName] = tabFrame

    tabButton.MouseButton1Click:Connect(function()
        for _, frame in pairs(tabFrames) do
            frame.Visible = false
        end
        tabFrame.Visible = true
    end)
end

--== MAIN TAB ==
local mainTab = tabFrames["Main"]

-- INFO + SERVER HOP Toggle Buttons
local infoToggle = Instance.new("TextButton", mainTab)
infoToggle.Size = UDim2.new(0, 100, 0, 30)
infoToggle.Position = UDim2.new(0, 10, 0, 10)
infoToggle.Text = "INFO"
infoToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
infoToggle.TextColor3 = Color3.new(1, 1, 1)
infoToggle.Font = Enum.Font.GothamBold
infoToggle.TextSize = 18

local serverHopToggle = Instance.new("TextButton", mainTab)
serverHopToggle.Size = UDim2.new(0, 120, 0, 30)
serverHopToggle.Position = UDim2.new(0, 120, 0, 10)
serverHopToggle.Text = "SERVER HOP"
serverHopToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
serverHopToggle.TextColor3 = Color3.new(1, 1, 1)
serverHopToggle.Font = Enum.Font.GothamBold
serverHopToggle.TextSize = 18

--== Info Container ==
local infoContainer = Instance.new("Frame", mainTab)
infoContainer.Size = UDim2.new(1, -20, 1, -60)
infoContainer.Position = UDim2.new(0, 10, 0, 50)
infoContainer.BackgroundTransparency = 1
infoContainer.Visible = true

local displayArea = Instance.new("Frame", infoContainer)
displayArea.Size = UDim2.new(1, -20, 1, -60)
displayArea.Position = UDim2.new(0, 10, 0, 50)
displayArea.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
displayArea.BorderSizePixel = 0

-- Player Count Label (live updates)
local playerCountLabel = Instance.new("TextLabel", displayArea)
playerCountLabel.Size = UDim2.new(0, 200, 0, 30)
playerCountLabel.Position = UDim2.new(1, -210, 0, 10)
playerCountLabel.TextColor3 = Color3.new(1, 1, 1)
playerCountLabel.BackgroundTransparency = 1
playerCountLabel.TextXAlignment = Enum.TextXAlignment.Right
playerCountLabel.Font = Enum.Font.SourceSansBold
playerCountLabel.TextSize = 18
local function updatePlayerCount()
    playerCountLabel.Text = "Players: " .. tostring(#game.Players:GetPlayers())
end
updatePlayerCount()
game.Players.PlayerAdded:Connect(updatePlayerCount)
game.Players.PlayerRemoving:Connect(updatePlayerCount)

local infoSection = Instance.new("TextLabel", displayArea)
infoSection.Size = UDim2.new(1, -20, 1, -20)
infoSection.Position = UDim2.new(0, 10, 0, 40)
infoSection.TextColor3 = Color3.new(1, 1, 1)
infoSection.BackgroundTransparency = 1
infoSection.TextWrapped = true
infoSection.TextYAlignment = Enum.TextYAlignment.Top
infoSection.Font = Enum.Font.SourceSans
infoSection.TextSize = 16
infoSection.Text = "Player: " .. player.Name ..
    "\nServer ID: " .. serverId ..
    "\nPlace Version: " .. tostring(game.PlaceVersion)

--== SERVER HOP CONTAINER ==
local serverHopContainer = Instance.new("Frame", mainTab)
serverHopContainer.Size = UDim2.new(1, -20, 1, -60)
serverHopContainer.Position = UDim2.new(0, 10, 0, 50)
serverHopContainer.BackgroundTransparency = 1
serverHopContainer.Visible = false
serverHopContainer:ClearAllChildren()
serverHopContainer.Visible = false

-- Button layout frame
local buttonRow = Instance.new("Frame", serverHopContainer)
buttonRow.Size = UDim2.new(1, -20, 0, 30)
buttonRow.Position = UDim2.new(0, 10, 0, 10)
buttonRow.BackgroundTransparency = 1

local rowLayout = Instance.new("UIListLayout", buttonRow)
rowLayout.FillDirection = Enum.FillDirection.Horizontal
rowLayout.Padding = UDim.new(0, 6)

-- REJOIN
local rejoinButton = Instance.new("TextButton", buttonRow)
rejoinButton.Size = UDim2.new(0, 100, 1, 0)
rejoinButton.Text = "Rejoin"
rejoinButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
rejoinButton.TextColor3 = Color3.new(1, 1, 1)
applyCorner(rejoinButton, 6)
rejoinButton.MouseButton1Click:Connect(function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
end)

-- HOP SERVER
local hopButton = Instance.new("TextButton", buttonRow)
hopButton.Size = UDim2.new(0, 120, 1, 0)
hopButton.Text = "Hop Server"
hopButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
hopButton.TextColor3 = Color3.new(1, 1, 1)
applyCorner(hopButton, 6)
hopButton.MouseButton1Click:Connect(function()
    local success, pages = pcall(function()
        return game.HttpService:JSONDecode(
            game:HttpGet(string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100", game.PlaceId))
        )
    end)
    if success and pages and pages.data then
        for _, server in ipairs(pages.data) do
            if tostring(server.id) ~= tostring(game.JobId) then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, server.id, player)
                break
            end
        end
    else
        warn("[VnsHub] Failed to fetch server list for hop.")
    end
end)

-- JOB ID TELEPORT
local jobIdBox = Instance.new("TextBox", serverHopContainer)
jobIdBox.Size = UDim2.new(1, -20, 0, 30)
jobIdBox.Position = UDim2.new(0, 10, 0, 50)
jobIdBox.PlaceholderText = "Enter JobId..."
jobIdBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
jobIdBox.TextColor3 = Color3.new(1, 1, 1)
jobIdBox.ClearTextOnFocus = false
applyCorner(jobIdBox, 6)

local joinByIdButton = Instance.new("TextButton", serverHopContainer)
joinByIdButton.Size = UDim2.new(0, 120, 0, 30)
joinByIdButton.Position = UDim2.new(0, 10, 0, 90)
joinByIdButton.Text = "Join by JobId"
joinByIdButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
joinByIdButton.TextColor3 = Color3.new(1, 1, 1)
applyCorner(joinByIdButton, 6)
joinByIdButton.MouseButton1Click:Connect(function()
    local jobId = jobIdBox.Text:trim()
    if jobId ~= "" then
        pcall(function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, jobId, player)
        end)
    else
        warn("[VnsHub] JobId box is empty.")
    end
end)

-- SERVER LIST SCROLL FRAME
serverList.Parent = serverHopContainer
serverList.Position = UDim2.new(0, 10, 0, 130)
serverList.Size = UDim2.new(1, -20, 1, -140)

--== Function to populate available servers ==
local function populateServers()
    serverList:ClearAllChildren()
    local success, pages = pcall(function()
        return game.HttpService:JSONDecode(
            game:HttpGet(string.format(
                "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100",
                game.PlaceId
            ))
        )
    end)

    if not success or not pages or not pages.data then
        warn("[VnsHub] Failed to fetch server list.")
        return
    end

    for _, server in ipairs(pages.data) do
        -- Skip the current server
        if tostring(server.id) ~= tostring(serverId) then
            local serverButton = Instance.new("TextButton")
            serverButton.Size = UDim2.new(1, -8, 0, 30)
            serverButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            serverButton.TextColor3 = Color3.new(1, 1, 1)
            serverButton.Text = string.format(
                "Players: %d/%d  |  Ping: %dms",
                server.playing or 0,
                server.maxPlayers or 0,
                server.ping or 0
            )
            serverButton.Parent = serverList

            serverButton.MouseButton1Click:Connect(function()
                local tpSuccess, err = pcall(function()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(
                        game.PlaceId,
                        server.id,
                        player
                    )
                end)
                if not tpSuccess then
                    warn("[VnsHub] Teleport failed:", err)
                end
            end)
        end
    end
end

-- Load servers on open
serverHopToggle.MouseButton1Click:Connect(populateServers)

--== MISC TAB ==
local miscTab = tabFrames["Misc"]

-- Example: Simple toggle for a feature
local exampleToggle = Instance.new("TextButton", miscTab)
exampleToggle.Size = UDim2.new(0, 150, 0, 30)
exampleToggle.Position = UDim2.new(0, 10, 0, 10)
exampleToggle.Text = "Example Feature"
exampleToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
exampleToggle.TextColor3 = Color3.new(1, 1, 1)
exampleToggle.Font = Enum.Font.GothamBold
exampleToggle.TextSize = 18

local featureOn = false
exampleToggle.MouseButton1Click:Connect(function()
    featureOn = not featureOn
    if featureOn then
        exampleToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        print("[VnsHub] Example feature ON")
        -- Add your activation logic here
    else
        exampleToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        print("[VnsHub] Example feature OFF")
        -- Add your deactivation logic here
    end
end)

--== PET TAB ==
local petTab = tabFrames["Pet"]

-- Placeholder Pet List
local petList = Instance.new("ScrollingFrame", petTab)
petList.Size = UDim2.new(1, -20, 1, -20)
petList.Position = UDim2.new(0, 10, 0, 10)
petList.CanvasSize = UDim2.new(0, 0, 0, 0)
petList.ScrollBarThickness = 6
petList.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
petList.BorderSizePixel = 0
petList.AutomaticCanvasSize = Enum.AutomaticSize.Y

local petLayout = Instance.new("UIListLayout", petList)
petLayout.SortOrder = Enum.SortOrder.LayoutOrder
petLayout.Padding = UDim.new(0, 4)

-- Example pet entries (replace with your dynamic load logic)
for i = 1, 5 do
    local petButton = Instance.new("TextButton")
    petButton.Size = UDim2.new(1, -8, 0, 30)
    petButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    petButton.TextColor3 = Color3.new(1, 1, 1)
    petButton.Text = "Pet #" .. i
    petButton.Parent = petList

    petButton.MouseButton1Click:Connect(function()
        print("[VnsHub] Selected Pet:", "Pet #" .. i)
        -- Add equip/unequip logic here
    end)
end

--== UI POLISH ==
-- UICorner and Gradient helper
local function applyCorner(obj, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = obj
end

local function applyGradient(obj, color1, color2)
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    })
    grad.Rotation = 90
    grad.Parent = obj
end

-- Apply to main elements
applyCorner(mainFrame, 8)
applyGradient(mainFrame, Color3.fromRGB(0,0,0), Color3.fromRGB(255, 255, 0))

applyCorner(minimizeButton, 6)
applyCorner(closeButton, 6)
applyCorner(restoreButton, 6)
applyCorner(displayArea, 6)
applyCorner(serverList, 6)
applyCorner(petList, 6)
applyCorner(exampleToggle, 6)

-- Button hover effects
local function applyHoverEffect(button)
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = button.BackgroundColor3:lerp(Color3.fromRGB(255, 255, 0), 0.3)
    end)
    button.MouseLeave:Connect(function()
        if button == exampleToggle and featureOn then
            button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        else
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        end
    end)
end

for _, tabFrame in pairs(tabFrames) do
    for _, child in ipairs(tabFrame.Parent:GetChildren()) do
        if child:IsA("TextButton") then
            applyCorner(child, 4)
            applyHoverEffect(child)
        end
    end
end

applyHoverEffect(minimizeButton)
applyHoverEffect(closeButton)
applyHoverEffect(restoreButton)
applyHoverEffect(infoToggle)
applyHoverEffect(serverHopToggle)
applyHoverEffect(exampleToggle)

--== Finished log ==
print("[VnsHub] GUI loaded successfully. Tabs:", table.concat(tabs, ", "))