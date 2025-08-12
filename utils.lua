-- utils.lua
-- General helper functions shared across modules

local utils = {}

function utils.createRoundedFrame(parent, size, pos, color, cornerRadius)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = pos
    frame.BackgroundColor3 = color
    frame.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, cornerRadius or 8)
    corner.Parent = frame

    return frame
end

return utils