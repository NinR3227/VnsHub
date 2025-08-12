-- utils.lua
-- Shared helper functions for Nin's GUI Framework

local utils = {}

-- Round corners
function utils.applyCorner(guiObject, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = guiObject
    return c
end

-- Vertical gradient background
function utils.applyGradient(guiObject, c1, c2)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, c1),
        ColorSequenceKeypoint.new(1, c2)
    })
    g.Rotation = 90
    g.Parent = guiObject
    return g
end

-- Button factory
function utils.makeButton(parent, text, width, height)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, width or 100, 0, height or 32)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(60,60,60)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.AutoButtonColor = true
    utils.applyCorner(b, 6)
    b.Parent = parent
    return b
end

-- Label factory
function utils.makeLabel(parent, text, size, bold)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Size = UDim2.new(1, 0, 0, size or 20)
    l.Text = text
    l.TextColor3 = Color3.new(1,1,1)
    l.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.TextSize = size or 14
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent
    return l
end

return utils
