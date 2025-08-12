-- automation.lua
-- Builds the "Automation Panel" with Auto Buy -> Seeds/Gears/Eggs categories

local Utils

local function createCategory(parent, categoryName, items, callbacks)
    -- callbacks: { buyOne = function(item), buyAll = function() }
    local t = Utils.Theme

    local block = Instance.new("Frame")
    block.BackgroundColor3 = t.Background
    block.Size = UDim2.new(1, 0, 0, 36)
    block.Parent = parent
    Utils.roundify(block, 8)
    Utils.pad(block, 8)
    Utils.listLayout(block, 8)

    -- Dropdown to select item in this category
    local selected = nil
    local dd = Utils.createDropdown(block, "Select " .. categoryName, items, function(choice)
        selected = choice
    end)

    -- Buttons row
    local row = Instance.new("Frame")
    row.BackgroundTransparency = 1
    row.Size = UDim2.new(1, 0, 0, 36)
    row.Parent = block

    local grid = Instance.new("UIGridLayout")
    grid.CellPadding = UDim2.new(0, 8, 0, 0)
    grid.CellSize = UDim2.new(0.5, -4, 1, 0)
    grid.FillDirectionMaxCells = 2
    grid.SortOrder = Enum.SortOrder.LayoutOrder
    grid.Parent = row

    local buySelected = Utils.createButton(row, "Buy " .. categoryName, function()
        if selected and callbacks.buyOne then callbacks.buyOne(selected) end
    end, { bold = true })

    local buyAll = Utils.createButton(row, "Buy All " .. categoryName, function()
        if callbacks.buyAll then callbacks.buyAll() end
    end, { })

    return {
        setItems = function(newItems) dd.setOptions(newItems) end,
        setSelected = function(label) dd.setLabel(label) end,
        getSelected = function() return selected end
    }
end

local function buildAutomationPanel(Gui, U)
    Utils = U
    local panel = Gui.createPanel("Automation Panel")

    -- Section: Auto Buy (collapsible)
    local section, content = Utils.createSection(panel, "Auto Buy")

    -- Example item pools (replace with your actual lists)
    local seeds = { "Wheat", "Corn", "Carrot", "Potato", "Tomato" }
    local gears = { "Wrench", "Hammer", "Pulley", "Gear A", "Gear B" }
    local eggs  = { "Red Egg", "Blue Egg", "Golden Egg", "Mystic Egg" }

    -- Stubs for your game logic (replace these with actual handlers)
    local function notify(msg)
        print("[Germa66] " .. msg)
    end

    local catSeeds = createCategory(content, "Seeds", seeds, {
        buyOne = function(item) notify("Buying Seed: " .. tostring(item)) end,
        buyAll = function() notify("Buying all Seeds in stock") end
    })
    local catGears = createCategory(content, "Gears", gears, {
        buyOne = function(item) notify("Buying Gear: " .. tostring(item)) end,
        buyAll = function() notify("Buying all Gears in stock") end
    })
    local catEggs = createCategory(content, "Eggs", eggs, {
        buyOne = function(item) notify("Buying Egg: " .. tostring(item)) end,
        buyAll = function() notify("Buying all Eggs in stock") end
    })

    -- Open section by default
    task.defer(function()
        -- simulate a click to expand and size correctly
        for _, child in ipairs(panel:GetChildren()) do
            if child:IsA("Frame") and child:FindFirstChildWhichIsA("TextButton") then
                child:FindFirstChildWhichIsA("TextButton"):Activate()
                break
            end
        end
    end)

    return panel
end

return buildAutomationPanel
