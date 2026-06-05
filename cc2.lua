-- [[ DAMIR_DRUN67 HUB v4.24 - MINIMAL + AUTO FARM ]] --

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- ==================== ТЕМА ====================
local Theme = {
    MainBg = Color3.fromRGB(12, 13, 18),
    InnerBg = Color3.fromRGB(18, 20, 28),
    StrokeDefault = Color3.fromRGB(35, 38, 50),
    StatusOnline = Color3.fromRGB(0, 255, 163),
    StatusOffline = Color3.fromRGB(255, 46, 92),
    BtnBg = Color3.fromRGB(25, 28, 38),
    TextMain = Color3.fromRGB(255, 255, 255),
    TextSub = Color3.fromRGB(140, 145, 165),
    AccentGlow = Color3.fromRGB(0, 200, 255),
    Purple = Color3.fromRGB(160, 100, 255),
    Orange = Color3.fromRGB(255, 140, 0)
}

-- ==================== ПОИСК МАШИНЫ ====================
local function getMyCar()
    local char = localPlayer.Character
    if not char then return nil end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and hum.SeatPart then
        local m = hum.SeatPart
        while m do
            if m:IsA("Model") and m ~= char then return m end
            m = m.Parent
        end
    end
    return nil
end

-- ==================== ПОИСК КНОПКИ РЕСПАВНА ====================
local function findSpawnButton()
    local playerGui = localPlayer:WaitForChild("PlayerGui")
    for _, gui in pairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            for _, obj in pairs(gui:GetDescendants()) do
                if (obj:IsA("TextButton") or obj:IsA("ImageButton")) and obj.Visible and obj.Active then
                    local text = obj:IsA("TextButton") and obj.Text or ""
                    local name = obj.Name:lower()
                    if name:find("spawn") or text:lower():find("spawn") or text:lower():find("car") then
                        local locked = false
                        if text:lower():find("vip") or text:lower():find("pass") then locked = true end
                        if obj.BackgroundColor3 and obj.BackgroundColor3.r < 0.3 and obj.BackgroundColor3.g < 0.3 and obj.BackgroundColor3.b < 0.3 then
                            locked = true
                        end
                        if not locked then return obj end
                    end
                end
            end
        end
    end
    return nil
end

local function clickSpawn()
    local btn = findSpawnButton()
    if btn then
        pcall(function()
            if btn.MouseButton1Click then
                firesignal(btn.MouseButton1Click)
            end
        end)
        return true
    end
    return false
end

-- ==================== GUI ====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedHubDamir"
screenGui.ResetOnSpawn = false
screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

-- Кнопка-кот
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
Instance.new("UIStroke", catBtn).Thickness = 1.5
Instance.new("UIStroke", catBtn).Color = Theme.Purple

-- Окно
local main = Instance.new("Frame")
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.4, 0)
main.Size = UDim2.new(0, 300, 0, 260)
main.BackgroundColor3 = Theme.MainBg
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.ZIndex = 100
main.Parent = screenGui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", main).Thickness = 1
Instance.new("UIStroke", main).Color = Theme.StrokeDefault

-- Заголовок
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 36)
header.BackgroundColor3 = Theme.InnerBg
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🐱 DAMIR HUB v4.24"
title.TextColor3 = Theme.TextMain
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left

local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 26, 0, 26)
minBtn.Position = UDim2.new(1, -30, 0, 5)
minBtn.BackgroundColor3 = Theme.Purple
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextSize = 16
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 13)

minBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    catBtn.Visible = true
end)
catBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    catBtn.Visible = false
end)

-- Машина
local carLabel = Instance.new("TextLabel", main)
carLabel.Size = UDim2.new(1, -20, 0, 28)
carLabel.Position = UDim2.new(0, 10, 0, 46)
carLabel.BackgroundColor3 = Theme.InnerBg
carLabel.Text = "🚗 Ищу машину..."
carLabel.TextColor3 = Theme.TextSub
carLabel.Font = Enum.Font.GothamBold
carLabel.TextSize = 10
Instance.new("UICorner", carLabel).CornerRadius = UDim.new(0, 5)

-- Молот (ручной)
local hammerActive = false
local hammerBtn = Instance.new("TextButton", main)
hammerBtn.Size = UDim2.new(1, -20, 0, 36)
hammerBtn.Position = UDim2.new(0, 10, 0, 84)
hammerBtn.BackgroundColor3 = Theme.BtnBg
hammerBtn.Text = "🔨 МОЛОТ (РУЧНОЙ)"
hammerBtn.TextColor3 = Theme.StatusOffline
hammerBtn.Font = Enum.Font.GothamBold
hammerBtn.TextSize = 12
hammerBtn.BorderSizePixel = 0
Instance.new("UICorner", hammerBtn).CornerRadius = UDim.new(0, 5)

-- Автофарм
local autoActive = false
local autoBtn = Instance.new("TextButton", main)
autoBtn.Size = UDim2.new(1, -20, 0, 36)
autoBtn.Position = UDim2.new(0, 10, 0, 128)
autoBtn.BackgroundColor3 = Theme.BtnBg
autoBtn.Text = "🤖 АВТО-ФАРМ + РЕСПАВН"
autoBtn.TextColor3 = Theme.Orange
autoBtn.Font = Enum.Font.GothamBold
autoBtn.TextSize = 12
autoBtn.BorderSizePixel = 0
Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0, 5)

-- Статистика
local stats = Instance.new("TextLabel", main)
stats.Size = UDim2.new(1, -20, 0, 20)
stats.Position = UDim2.new(0, 10, 0, 174)
stats.BackgroundTransparency = 1
stats.Text = "Ударов: 0 | Сломано: 0"
stats.TextColor3 = Theme.TextSub
stats.Font = Enum.Font.Gotham
stats.TextSize = 10
stats.TextXAlignment = Enum.TextXAlignment.Left

local hits = 0
local destroyed = 0

-- Один удар молота
local function hammerHit()
    local car = getMyCar()
    if not car then return false end
    
    local root = car.PrimaryPart or car:FindFirstChildWhichIsA("BasePart")
    if not root then return false end
    
    root.Velocity = Vector3.zero
    root.CFrame = CFrame.new(root.Position.X, 80, root.Position.Z)
    task.wait(0.1)
    root.Velocity = Vector3.new(0, -500, 0)
    task.wait(0.8)
    
    if not car.Parent then
        destroyed = destroyed + 1
        return true
    end
    return false
end

-- Молот ручной
hammerBtn.MouseButton1Click:Connect(function()
    hammerActive = not hammerActive
    if hammerActive then
        autoBtn.BackgroundColor3 = Theme.BtnBg
        autoBtn.Text = "🤖 АВТО-ФАРМ + РЕСПАВН"
        autoBtn.TextColor3 = Theme.Orange
        autoActive = false
        
        hammerBtn.Text = "🔨 МОЛОТ РАБОТАЕТ"
        hammerBtn.TextColor3 = Theme.StatusOnline
        hammerBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 30)
        
        spawn(function()
            while hammerActive do
                pcall(function()
                    local car = getMyCar()
                    if car then
                        carLabel.Text = "🚗 " .. car.Name
                        carLabel.TextColor3 = Theme.AccentGlow
                    else
                        carLabel.Text = "🚗 Нет машины"
                        carLabel.TextColor3 = Theme.StatusOffline
                    end
                    if hammerHit() then
                        carLabel.Text = "💀 Уничтожена!"
                    end
                    hits = hits + 1
                    stats.Text = "Ударов: " .. hits .. " | Сломано: " .. destroyed
                end)
                task.wait(0.3)
            end
        end)
    else
        hammerBtn.Text = "🔨 МОЛОТ (РУЧНОЙ)"
        hammerBtn.TextColor3 = Theme.StatusOffline
        hammerBtn.BackgroundColor3 = Theme.BtnBg
    end
end)

-- Автофарм
autoBtn.MouseButton1Click:Connect(function()
    autoActive = not autoActive
    if autoActive then
        hammerBtn.BackgroundColor3 = Theme.BtnBg
        hammerBtn.Text = "🔨 МОЛОТ (РУЧНОЙ)"
        hammerBtn.TextColor3 = Theme.StatusOffline
        hammerActive = false
        
        autoBtn.Text = "🤖 АВТО-ФАРМ РАБОТАЕТ"
        autoBtn.TextColor3 = Theme.StatusOnline
        autoBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 10)
        
        spawn(function()
            while autoActive do
                pcall(function()
                    local car = getMyCar()
                    if not car then
                        carLabel.Text = "🚗 Респавн..."
                        clickSpawn()
                        task.wait(3)
                    else
                        carLabel.Text = "🚗 " .. car.Name
                        carLabel.TextColor3 = Theme.AccentGlow
                        
                        local broken = false
                        for i = 1, 25 do
                            if not autoActive then break end
                            broken = hammerHit()
                            hits = hits + 1
                            stats.Text = "Ударов: " .. hits .. " | Сломано: " .. destroyed
                            carLabel.Text = "🔨 Удар " .. i .. "..."
                            if broken then break end
                            task.wait(0.2)
                        end
                        
                        if broken then
                            carLabel.Text = "💀 Сломана!"
                            task.wait(1)
                            carLabel.Text = "🚗 Респавн..."
                            clickSpawn()
                            task.wait(3)
                        end
                    end
                end)
            end
        end)
    else
        autoBtn.Text = "🤖 АВТО-ФАРМ + РЕСПАВН"
        autoBtn.TextColor3 = Theme.Orange
        autoBtn.BackgroundColor3 = Theme.BtnBg
    end
end)
