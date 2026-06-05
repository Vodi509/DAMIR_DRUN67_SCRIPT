-- [[ DAMIR_DRUN67 HUB v5.4 - EXTREME HAMMER ]] --

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

local Theme = {
    MainBg = Color3.fromRGB(15, 16, 22),
    InnerBg = Color3.fromRGB(22, 24, 33),
    StrokeDefault = Color3.fromRGB(38, 42, 56),
    StatusOnline = Color3.fromRGB(0, 255, 163),
    StatusOffline = Color3.fromRGB(255, 46, 92),
    BtnBg = Color3.fromRGB(30, 33, 45),
    TextMain = Color3.fromRGB(255, 255, 255),
    TextSub = Color3.fromRGB(125, 131, 150),
    AccentGlow = Color3.fromRGB(0, 200, 255)
}

local MemeIds = {
    "rbxthumb://type=Asset&id=18314115147&w=150&h=150",
    "rbxthumb://type=Asset&id=6072171427&w=150&h=150",
    "rbxthumb://type=Asset&id=6072166311&w=150&h=150",
    "rbxthumb://type=Asset&id=6072153923&w=150&h=150"
}

local function getMyCar()
    local char = localPlayer.Character
    if not char then return nil end
    if char:FindFirstChild("Humanoid") and char.Humanoid.SeatPart then
        local seat = char.Humanoid.SeatPart
        if seat:IsA("VehicleSeat") then
            local car = seat:FindFirstAncestorOfClass("Model")
            if car then return car end
        end
    end
    local folders = {workspace:FindFirstChild("CarCollection"), workspace:FindFirstChild("Vehicles"), workspace}
    for _, folder in pairs(folders) do
        if folder then
            for _, v in pairs(folder:GetChildren()) do
                if v:IsA("Model") then
                    local owner = v:FindFirstChild("Owner")
                    if (owner and owner.Value == localPlayer) or v.Name == localPlayer.Name then
                        return v
                    end
                end
            end
        end
    end
    return nil
end

local function findSpawn()
    local pg = localPlayer:WaitForChild("PlayerGui")
    for _, g in pairs(pg:GetChildren()) do
        if g:IsA("ScreenGui") then
            for _, o in pairs(g:GetDescendants()) do
                if (o:IsA("TextButton") or o:IsA("ImageButton")) and o.Visible and o.Active then
                    local t = o:IsA("TextButton") and o.Text or ""
                    if o.Name:lower():find("spawn") or t:lower():find("spawn") or t:lower():find("car") then
                        if not t:lower():find("vip") and not t:lower():find("pass") then
                            return o
                        end
                    end
                end
            end
        end
    end
    return nil
end

local function clickSpawn()
    local b = findSpawn()
    if b then
        pcall(function() if b.MouseButton1Click then firesignal(b.MouseButton1Click) end end)
        return true
    end
    return false
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedHubDamir"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

-- Кот
local catBtn = Instance.new("ImageButton")
catBtn.Size = UDim2.new(0, 48, 0, 48)
catBtn.Position = UDim2.new(0.02, 0, 0.12, 0)
catBtn.BackgroundColor3 = Theme.InnerBg
catBtn.Image = "rbxassetid://18314115147"
catBtn.ScaleType = Enum.ScaleType.Fit
catBtn.ZIndex = 200
catBtn.Visible = false
catBtn.Active = true
catBtn.Draggable = true
catBtn.Parent = screenGui
Instance.new("UICorner", catBtn).CornerRadius = UDim.new(1, 0)

local mainFrame = Instance.new("Frame")
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.4, 0)
mainFrame.Size = UDim2.new(0, 480, 0, 320)
mainFrame.BackgroundColor3 = Theme.MainBg
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true
mainFrame.ZIndex = 100
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", mainFrame).Thickness = 1
Instance.new("UIStroke", mainFrame).Color = Theme.StrokeDefault

local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundColor3 = Theme.InnerBg
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)

local titleText = Instance.new("TextLabel", titleBar)
titleText.Size = UDim2.new(1, -70, 1, 0)
titleText.Position = UDim2.new(0, 14, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "🐱 DAMIR HUB v5.4"
titleText.TextColor3 = Theme.TextMain
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 13
titleText.TextXAlignment = Enum.TextXAlignment.Left

local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 26, 0, 26)
minBtn.Position = UDim2.new(1, -34, 0, 5)
minBtn.BackgroundColor3 = Color3.fromRGB(160, 100, 255)
minBtn.Text = "—"
minBtn.TextColor3 = Color3.new(1, 1, 1)
minBtn.TextSize = 16
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 13)

minBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    catBtn.Visible = true
end)
catBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    catBtn.Visible = false
end)

local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 120, 1, -36)
sidebar.Position = UDim2.new(0, 0, 0, 36)
sidebar.BackgroundColor3 = Theme.InnerBg
sidebar.BorderSizePixel = 0
Instance.new("UIStroke", sidebar).Thickness = 1
Instance.new("UIStroke", sidebar).Color = Theme.StrokeDefault

local logoLabel = Instance.new("TextLabel", sidebar)
logoLabel.Size = UDim2.new(1, 0, 0, 40)
logoLabel.BackgroundTransparency = 1
logoLabel.Text = "DAMIR HUB"
logoLabel.TextColor3 = Theme.StatusOffline
logoLabel.Font = Enum.Font.GothamBold
logoLabel.TextSize = 14

local container = Instance.new("Frame", mainFrame)
container.Position = UDim2.new(0, 130, 0, 46)
container.Size = UDim2.new(1, -140, 1, -56)
container.BackgroundTransparency = 1

local tabs = {}
local function createTab(name)
    local tf = Instance.new("ScrollingFrame", container)
    tf.Size = UDim2.new(1, 0, 1, 0)
    tf.BackgroundTransparency = 1
    tf.CanvasSize = UDim2.new(0, 0, 2, 0)
    tf.ScrollBarThickness = 2
    tf.Visible = false
    Instance.new("UIListLayout", tf).Padding = UDim.new(0, 8)
    
    local tb = Instance.new("TextButton", sidebar)
    tb.Size = UDim2.new(1, -16, 0, 32)
    tb.Position = UDim2.new(0, 8, 0, 45 + (#tabs * 38))
    tb.BackgroundColor3 = Theme.BtnBg
    tb.Text = name
    tb.TextColor3 = Theme.TextMain
    tb.Font = Enum.Font.GothamBold
    tb.TextSize = 11
    tb.BorderSizePixel = 0
    Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 5)
    
    tb.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.Visible = false end
        tf.Visible = true
    end)
    
    table.insert(tabs, tf)
    return tf
end

local farmTab = createTab("🚀 Авто Фарм")
local funTab = createTab("🤡 Fun Zone")
tabs[1].Visible = true

-- Фарм
local farmTitle = Instance.new("TextLabel", farmTab)
farmTitle.Size = UDim2.new(1, 0, 0, 20)
farmTitle.BackgroundTransparency = 1
farmTitle.Text = "ПРОГРАММА «МОЛОТ» v5.4"
farmTitle.TextColor3 = Theme.TextMain
farmTitle.Font = Enum.Font.GothamBold
farmTitle.TextSize = 12
farmTitle.TextXAlignment = Enum.TextXAlignment.Left

local carFrame = Instance.new("Frame", farmTab)
carFrame.Size = UDim2.new(1, 0, 0, 35)
carFrame.BackgroundColor3 = Theme.InnerBg
Instance.new("UICorner", carFrame).CornerRadius = UDim.new(0, 6)

local carLabel = Instance.new("TextLabel", carFrame)
carLabel.Size = UDim2.new(1, -20, 1, 0)
carLabel.Position = UDim2.new(0, 10, 0, 0)
carLabel.BackgroundTransparency = 1
carLabel.Text = "🚗 Ищу машину..."
carLabel.TextColor3 = Theme.TextSub
carLabel.Font = Enum.Font.GothamBold
carLabel.TextSize = 11
carLabel.TextXAlignment = Enum.TextXAlignment.Left

task.spawn(function()
    while task.wait(0.3) do
        pcall(function()
            local c = getMyCar()
            if c then
                carLabel.Text = "🚗 " .. c.Name
                carLabel.TextColor3 = Theme.AccentGlow
            else
                carLabel.Text = "🚗 Сядьте в машину!"
                carLabel.TextColor3 = Theme.StatusOffline
            end
        end)
    end
end)

local statsLabel = Instance.new("TextLabel", farmTab)
statsLabel.Size = UDim2.new(1, 0, 0, 18)
statsLabel.BackgroundTransparency = 1
statsLabel.Text = "Ударов: 0 | Сломано: 0 | Авто: 0"
statsLabel.TextColor3 = Theme.TextSub
statsLabel.Font = Enum.Font.Gotham
statsLabel.TextSize = 10
statsLabel.TextXAlignment = Enum.TextXAlignment.Left

local ha, aa, hh, cd, afc = false, false, 0, 0, 0

local function doHit()
    local c = getMyCar()
    if not c then return false end
    local r = c.PrimaryPart or c:FindFirstChildWhichIsA("BasePart")
    if not r then return false end
    r.Velocity = Vector3.zero
    r.CFrame = CFrame.new(r.Position.X, 200, r.Position.Z)
    task.wait(0.15)
    r.Velocity = Vector3.new(0, -1500, 0)
    task.wait(1.0)
    if not c.Parent then cd = cd + 1 return true end
    return false
end

local hammerBtn = Instance.new("TextButton", farmTab)
hammerBtn.Size = UDim2.new(1, 0, 0, 40)
hammerBtn.BackgroundColor3 = Theme.BtnBg
hammerBtn.Text = "🔨 ВКЛЮЧИТЬ МОЛОТ"
hammerBtn.TextColor3 = Theme.StatusOffline
hammerBtn.Font = Enum.Font.GothamBold
hammerBtn.TextSize = 12
hammerBtn.BorderSizePixel = 0
Instance.new("UICorner", hammerBtn).CornerRadius = UDim.new(0, 6)

hammerBtn.MouseButton1Click:Connect(function()
    ha = not ha
    if ha then
        aa = false
        autoBtn.Text = "🤖 АВТО-ФАРМ"
        autoBtn.TextColor3 = Theme.TextSub
        autoBtn.BackgroundColor3 = Theme.BtnBg
        hammerBtn.Text = "🔨 МОЛОТ РАБОТАЕТ"
        hammerBtn.TextColor3 = Theme.StatusOnline
        hammerBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 30)
        task.spawn(function()
            while ha do
                doHit()
                hh = hh + 1
                statsLabel.Text = "Ударов: " .. hh .. " | Сломано: " .. cd .. " | Авто: " .. afc
                task.wait(0.3)
            end
        end)
    else
        hammerBtn.Text = "🔨 ВКЛЮЧИТЬ МОЛОТ"
        hammerBtn.TextColor3 = Theme.StatusOffline
        hammerBtn.BackgroundColor3 = Theme.BtnBg
    end
end)

local autoBtn = Instance.new("TextButton", farmTab)
autoBtn.Size = UDim2.new(1, 0, 0, 40)
autoBtn.BackgroundColor3 = Theme.BtnBg
autoBtn.Text = "🤖 АВТО-ФАРМ"
autoBtn.TextColor3 = Theme.TextSub
autoBtn.Font = Enum.Font.GothamBold
autoBtn.TextSize = 12
autoBtn.BorderSizePixel = 0
Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0, 6)

autoBtn.MouseButton1Click:Connect(function()
    aa = not aa
    if aa then
        ha = false
        hammerBtn.Text = "🔨 ВКЛЮЧИТЬ МОЛОТ"
        hammerBtn.TextColor3 = Theme.StatusOffline
        hammerBtn.BackgroundColor3 = Theme.BtnBg
        autoBtn.Text = "🤖 АВТО-ФАРМ РАБОТАЕТ"
        autoBtn.TextColor3 = Theme.StatusOnline
        autoBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 10)
        task.spawn(function()
            while aa do
                local c = getMyCar()
                if not c then
                    carLabel.Text = "🚗 Респавн..."
                    clickSpawn()
                    task.wait(3)
                else
                    local d = false
                    for i = 1, 20 do
                        if not aa then break end
                        d = doHit()
                        hh = hh + 1
                        statsLabel.Text = "Ударов: " .. hh .. " | Сломано: " .. cd .. " | Авто: " .. afc
                        if d then break end
                        task.wait(0.2)
                    end
                    if d then
                        afc = afc + 1
                        statsLabel.Text = "Ударов: " .. hh .. " | Сломано: " .. cd .. " | Авто: " .. afc
                        carLabel.Text = "💀 Уничтожена!"
                        task.wait(1)
                        carLabel.Text = "🚗 Респавн..."
                        clickSpawn()
                        task.wait(3)
                    end
                end
            end
        end)
    else
        autoBtn.Text = "🤖 АВТО-ФАРМ"
        autoBtn.TextColor3 = Theme.TextSub
        autoBtn.BackgroundColor3 = Theme.BtnBg
    end
end)

-- Fun Zone
local funTitle = Instance.new("TextLabel", funTab)
funTitle.Size = UDim2.new(1, 0, 0, 20)
funTitle.BackgroundTransparency = 1
funTitle.Text = "МЕМ ГЕНЕРАТОР"
funTitle.TextColor3 = Theme.TextMain
funTitle.Font = Enum.Font.GothamBold
funTitle.TextSize = 12
funTitle.TextXAlignment = Enum.TextXAlignment.Left

local memeImage = Instance.new("ImageLabel", funTab)
memeImage.Size = UDim2.new(0, 140, 0, 140)
memeImage.BackgroundColor3 = Theme.InnerBg
memeImage.Image = MemeIds[1]
Instance.new("UICorner", memeImage).CornerRadius = UDim.new(0, 6)

local nextMemeBtn = Instance.new("TextButton", funTab)
nextMemeBtn.Size = UDim2.new(1, 0, 0, 35)
nextMemeBtn.BackgroundColor3 = Theme.BtnBg
nextMemeBtn.Text = "НЕ СМЕШНО, ДАВАЙ СЛЕДУЮЩИЙ"
nextMemeBtn.TextColor3 = Theme.TextMain
nextMemeBtn.Font = Enum.Font.GothamBold
nextMemeBtn.TextSize = 11
nextMemeBtn.BorderSizePixel = 0
Instance.new("UICorner", nextMemeBtn).CornerRadius = UDim.new(0, 6)

nextMemeBtn.MouseButton1Click:Connect(function()
    memeImage.Image = MemeIds[math.random(1, #MemeIds)]
end)
