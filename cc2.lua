-- [[ DAMIR_DRUN67 HUB v4.1 - POWER HAMMER + AUTO FARM (FIXED) ]] --

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

-- ==================== ТЕМА ====================
local Theme = {
    MainBg = Color3.fromRGB(12, 13, 18),
    InnerBg = Color3.fromRGB(18, 20, 28),
    StrokeDefault = Color3.fromRGB(35, 38, 50),
    StatusOnline = Color3.fromRGB(0, 255, 163),
    StatusOffline = Color3.fromRGB(255, 46, 92),
    BtnBg = Color3.fromRGB(25, 28, 38),
    BtnStroke = Color3.fromRGB(50, 55, 70),
    TextMain = Color3.fromRGB(255, 255, 255),
    TextSub = Color3.fromRGB(140, 145, 165),
    AccentGlow = Color3.fromRGB(0, 200, 255),
    Gold = Color3.fromRGB(255, 215, 0),
    Purple = Color3.fromRGB(160, 100, 255),
    Orange = Color3.fromRGB(255, 140, 0)
}

local MemeIds = {
    "rbxthumb://type=Asset&id=18314115147&w=150&h=150",
    "rbxthumb://type=Asset&id=6072171427&w=150&h=150",
    "rbxthumb://type=Asset&id=6072166311&w=150&h=150",
    "rbxthumb://type=Asset&id=6072153923&w=150&h=150"
}

-- ==================== ПОИСК МАШИНЫ ====================
local function getMyCar()
    local char = localPlayer.Character
    if not char then return nil end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.SeatPart then
        local seat = humanoid.SeatPart
        local current = seat
        while current do
            if current:IsA("Model") and current ~= char then
                return current
            end
            current = current.Parent
        end
    end
    
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
    if torso then
        local current = torso
        while current do
            if current:IsA("Model") and current ~= char then
                if current.PrimaryPart or current:FindFirstChildWhichIsA("VehicleSeat") then
                    return current
                end
            end
            current = current.Parent
        end
    end
    
    local folders = {workspace:FindFirstChild("Vehicles"), workspace:FindFirstChild("CarCollection"), workspace}
    for _, folder in pairs(folders) do
        if folder then
            for _, v in pairs(folder:GetChildren()) do
                if v:IsA("Model") then
                    local owner = v:FindFirstChild("Owner")
                    if (owner and owner:IsA("ObjectValue") and owner.Value == localPlayer) then
                        return v
                    end
                end
            end
        end
    end
    
    if torso then
        local nearest, minDist = nil, 20
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChildWhichIsA("VehicleSeat") then
                local root = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
                if root then
                    local dist = (root.Position - torso.Position).Magnitude
                    if dist < minDist then
                        minDist = dist
                        nearest = v
                    end
                end
            end
        end
        if nearest then return nearest end
    end
    
    return nil
end

local function getCarDisplayName(car)
    if not car then return "???" end
    if car.Name == "Body" and car.Parent and car.Parent:IsA("Model") then
        return car.Parent.Name
    end
    for _, child in pairs(car:GetChildren()) do
        if child:IsA("Model") and child.Name ~= "Body" then
            return child.Name
        end
    end
    return car.Name
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
                    if name:find("spawn") or name:find("get") or text:lower():find("spawn") or text:lower():find("car") then
                        local locked = false
                        if text:lower():find("vip") or text:lower():find("pass") then locked = true end
                        if obj.BackgroundColor3 and obj.BackgroundColor3.r < 0.3 and obj.BackgroundColor3.g < 0.3 and obj.BackgroundColor3.b < 0.3 then
                            locked = true
                        end
                        for _, child in pairs(obj:GetChildren()) do
                            if child:IsA("ImageLabel") and tostring(child.Image):lower():find("lock") then
                                locked = true
                            end
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
            firesignal(btn.MouseButton1Click)
        end)
        pcall(function()
            btn.Activated:Fire()
        end)
        return true
    end
    return false
end

-- ==================== GUI ====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedHubDamir"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
screenGui.Parent = (success and coreGui) and coreGui or localPlayer:WaitForChild("PlayerGui")

-- КНОПКА-КОТ
local catBtn = Instance.new("ImageButton")
catBtn.Name = "CatBtn"
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
local catStroke = Instance.new("UIStroke", catBtn)
catStroke.Thickness = 1.5
catStroke.Color = Theme.Purple

-- ГЛАВНОЕ ОКНО
local mainFrame = Instance.new("Frame")
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.42, 0)
mainFrame.Size = UDim2.new(0, 440, 0, 310)
mainFrame.BackgroundColor3 = Theme.MainBg
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true
mainFrame.ZIndex = 100
mainFrame.Parent = screenGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", mainFrame).Thickness = 1
Instance.new("UIStroke", mainFrame).Color = Theme.StrokeDefault

-- ЗАГОЛОВОК
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundColor3 = Theme.InnerBg
titleBar.BorderSizePixel = 0

Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

local titleText = Instance.new("TextLabel", titleBar)
titleText.Size = UDim2.new(1, -80, 1, 0)
titleText.Position = UDim2.new(0, 14, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "🐱 DAMIR HUB v4.1"
titleText.TextColor3 = Theme.TextMain
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 13
titleText.TextXAlignment = Enum.TextXAlignment.Left

local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 26, 0, 26)
minBtn.Position = UDim2.new(1, -58, 0, 5)
minBtn.BackgroundColor3 = Theme.Purple
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextSize = 16
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 13)

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.BackgroundColor3 = Theme.StatusOffline
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 13)

minBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    catBtn.Visible = true
end)
catBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    catBtn.Visible = false
end)
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- БОКОВАЯ ПАНЕЛЬ
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 110, 1, -36)
sidebar.Position = UDim2.new(0, 0, 0, 36)
sidebar.BackgroundColor3 = Theme.InnerBg
sidebar.BorderSizePixel = 0

local sidebarStroke = Instance.new("UIStroke", sidebar)
sidebarStroke.Thickness = 1
sidebarStroke.Color = Theme.StrokeDefault

local sidebarList = Instance.new("UIListLayout", sidebar)
sidebarList.Padding = UDim.new(0, 6)

-- КОНТЕЙНЕР
local container = Instance.new("Frame", mainFrame)
container.Position = UDim2.new(0, 120, 0, 46)
container.Size = UDim2.new(1, -130, 1, -56)
container.BackgroundTransparency = 1

-- ВКЛАДКИ
local tabs = {}

local function createTab(name, icon)
    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
    tabFrame.ScrollBarThickness = 2
    tabFrame.Visible = false
    tabFrame.ScrollBarImageColor3 = Theme.Purple
    tabFrame.Parent = container
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 8)
    listLayout.Parent = tabFrame
    
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, -16, 0, 32)
    tabBtn.Position = UDim2.new(0, 8, 0, 8)
    tabBtn.BackgroundColor3 = Theme.BtnBg
    tabBtn.Text = icon .. " " .. name
    tabBtn.TextColor3 = Theme.TextSub
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 11
    tabBtn.BorderSizePixel = 0
    tabBtn.Parent = sidebar
    
    Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 5)
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.button.BackgroundColor3 = Theme.BtnBg
            t.button.TextColor3 = Theme.TextSub
            t.frame.Visible = false
        end
        tabBtn.BackgroundColor3 = Theme.Purple
        tabBtn.TextColor3 = Theme.TextMain
        tabFrame.Visible = true
    end)
    
    table.insert(tabs, {button = tabBtn, frame = tabFrame})
    return tabFrame
end

local farmTab = createTab("Фарм", "🚀")
local settingsTab = createTab("Настр", "⚙️")
local funTab = createTab("Fun", "🤡")

if #tabs > 0 then
    tabs[1].button.BackgroundColor3 = Theme.Purple
    tabs[1].button.TextColor3 = Theme.TextMain
    tabs[1].frame.Visible = true
end

-- ==================== ВКЛАДКА ФАРМ ====================
local farmTitle = Instance.new("TextLabel", farmTab)
farmTitle.Size = UDim2.new(1, 0, 0, 18)
farmTitle.BackgroundTransparency = 1
farmTitle.Text = "УПРАВЛЕНИЕ ФАРМОМ"
farmTitle.TextColor3 = Theme.TextMain
farmTitle.Font = Enum.Font.GothamBold
farmTitle.TextSize = 11
farmTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Инфо о машине
local carInfo = Instance.new("Frame", farmTab)
carInfo.Size = UDim2.new(1, 0, 0, 32)
carInfo.BackgroundColor3 = Theme.InnerBg
Instance.new("UICorner", carInfo).CornerRadius = UDim.new(0, 5)

local carLabel = Instance.new("TextLabel", carInfo)
carLabel.Size = UDim2.new(1, -16, 1, 0)
carLabel.Position = UDim2.new(0, 8, 0, 0)
carLabel.BackgroundTransparency = 1
carLabel.Text = "🚗 Ищу машину..."
carLabel.TextColor3 = Theme.TextSub
carLabel.Font = Enum.Font.GothamBold
carLabel.TextSize = 10
carLabel.TextXAlignment = Enum.TextXAlignment.Left

task.spawn(function()
    while task.wait(0.3) do
        pcall(function()
            local car = getMyCar()
            if car then
                carLabel.Text = "🚗 " .. getCarDisplayName(car)
                carLabel.TextColor3 = Theme.AccentGlow
            else
                carLabel.Text = "🚗 Нет машины"
                carLabel.TextColor3 = Theme.StatusOffline
            end
        end)
    end
end)

-- Статистика
local statsLabel = Instance.new("TextLabel", farmTab)
statsLabel.Size = UDim2.new(1, 0, 0, 18)
statsLabel.BackgroundTransparency = 1
statsLabel.Text = "Ударов: 0 | Сломано: 0 | Авто: 0"
statsLabel.TextColor3 = Theme.TextSub
statsLabel.Font = Enum.Font.Gotham
statsLabel.TextSize = 9
statsLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ====== МОЛОТ ======
local hammerActive = false
local hammerHeight = 80
local hammerSpeed = 500
local hammerHits = 0
local carsDestroyed = 0
local autoFarmCount = 0

local hammerBtn = Instance.new("TextButton", farmTab)
hammerBtn.Size = UDim2.new(1, 0, 0, 38)
hammerBtn.BackgroundColor3 = Theme.BtnBg
hammerBtn.Text = "🔨 МОЛОТ (РУЧНОЙ)"
hammerBtn.TextColor3 = Theme.StatusOffline
hammerBtn.Font = Enum.Font.GothamBold
hammerBtn.TextSize = 11
hammerBtn.BorderSizePixel = 0
Instance.new("UICorner", hammerBtn).CornerRadius = UDim.new(0, 5)
Instance.new("UIStroke", hammerBtn).Thickness = 1
Instance.new("UIStroke", hammerBtn).Color = Theme.BtnStroke

local function doOneHammerHit()
    local car = getMyCar()
    if not car then return false end
    
    local root = car.PrimaryPart or car:FindFirstChildWhichIsA("BasePart")
    if not root then return false end
    
    root.Velocity = Vector3.zero
    root.CFrame = CFrame.new(root.Position.X, hammerHeight, root.Position.Z)
    task.wait(0.1)
    root.Velocity = Vector3.new(0, -hammerSpeed, 0)
    task.wait(0.8)
    
    if not car.Parent then
        carsDestroyed = carsDestroyed + 1
        return true
    end
    return false
end

local function runHammer()
    while hammerActive do
        local destroyed = doOneHammerHit()
        if destroyed then
            carLabel.Text = "💀 Уничтожена!"
        end
        hammerHits = hammerHits + 1
        statsLabel.Text = "Ударов: " .. hammerHits .. " | Сломано: " .. carsDestroyed .. " | Авто: " .. autoFarmCount
        task.wait(0.3)
    end
end

hammerBtn.MouseButton1Click:Connect(function()
    hammerActive = not hammerActive
    if hammerActive then
        hammerBtn.Text = "🔨 МОЛОТ РАБОТАЕТ"
        hammerBtn.TextColor3 = Theme.StatusOnline
        hammerBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 30)
        task.spawn(runHammer)
    else
        hammerBtn.Text = "🔨 МОЛОТ (РУЧНОЙ)"
        hammerBtn.TextColor3 = Theme.StatusOffline
        hammerBtn.BackgroundColor3 = Theme.BtnBg
    end
end)

-- ====== АВТО-ФАРМ ======
local autoFarmActive = false

local autoFarmBtn = Instance.new("TextButton", farmTab)
autoFarmBtn.Size = UDim2.new(1, 0, 0, 38)
autoFarmBtn.BackgroundColor3 = Theme.BtnBg
autoFarmBtn.Text = "🤖 АВТО-ФАРМ (С РЕСПАВНОМ)"
autoFarmBtn.TextColor3 = Theme.Orange
autoFarmBtn.Font = Enum.Font.GothamBold
autoFarmBtn.TextSize = 11
autoFarmBtn.BorderSizePixel = 0
Instance.new("UICorner", autoFarmBtn).CornerRadius = UDim.new(0, 5)
Instance.new("UIStroke", autoFarmBtn).Thickness = 1
Instance.new("UIStroke", autoFarmBtn).Color = Theme.Orange

local function runAutoFarm()
    while autoFarmActive do
        local car = getMyCar()
        if not car then
            carLabel.Text = "🚗 Респавн..."
            clickSpawn()
            task.wait(3)
            car = getMyCar()
            if not car then
                task.wait(2)
                -- идём на следующий цикл
            end
        end
        
        if car then
            local destroyed = false
            local attempts = 0
            while not destroyed and attempts < 20 and autoFarmActive do
                destroyed = doOneHammerHit()
                hammerHits = hammerHits + 1
                attempts = attempts + 1
                statsLabel.Text = "Ударов: " .. hammerHits .. " | Сломано: " .. carsDestroyed .. " | Авто: " .. autoFarmCount
                carLabel.Text = "🔨 Удар " .. attempts .. "..."
                task.wait(0.2)
            end
            
            if destroyed then
                carsDestroyed = carsDestroyed + 1
                autoFarmCount = autoFarmCount + 1
                carLabel.Text = "💀 Сломана! +1 автоцикл"
                statsLabel.Text = "Ударов: " .. hammerHits .. " | Сломано: " .. carsDestroyed .. " | Авто: " .. autoFarmCount
                task.wait(1)
                carLabel.Text = "🚗 Респавн..."
                clickSpawn()
                task.wait(3)
            else
                task.wait(1)
            end
        end
    end
end

autoFarmBtn.MouseButton1Click:Connect(function()
    autoFarmActive = not autoFarmActive
    if autoFarmActive then
        autoFarmBtn.Text = "🤖 АВТО-ФАРМ РАБОТАЕТ"
        autoFarmBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 10)
        autoFarmBtn.TextColor3 = Theme.StatusOnline
        task.spawn(runAutoFarm)
    else
        autoFarmBtn.Text = "🤖 АВТО-ФАРМ (С РЕСПАВНОМ)"
        autoFarmBtn.BackgroundColor3 = Theme.BtnBg
        autoFarmBtn.TextColor3 = Theme.Orange
    end
end)

-- ==================== ВКЛАДКА НАСТРОЕК ====================
local settingsTitle = Instance.new("TextLabel", settingsTab)
settingsTitle.Size = UDim2.new(1, 0, 0, 18)
settingsTitle.BackgroundTransparency = 1
settingsTitle.Text = "НАСТРОЙКИ МОЛОТА"
settingsTitle.TextColor3 = Theme.TextMain
settingsTitle.Font = Enum.Font.GothamBold
settingsTitle.TextSize = 11
settingsTitle.TextXAlignment = Enum.TextXAlignment.Left

local heightLabel = Instance.new("TextLabel", settingsTab)
heightLabel.Size = UDim2.new(1, 0, 0, 18)
heightLabel.BackgroundTransparency = 1
heightLabel.Text = "📏 Высота подъёма: 80"
heightLabel.TextColor3 = Theme.TextSub
heightLabel.Font = Enum.Font.Gotham
heightLabel.TextSize = 10
heightLabel.TextXAlignment = Enum.TextXAlignment.Left

local heightInput = Instance.new("TextBox", settingsTab)
heightInput.Size = UDim2.new(1, 0, 0, 30)
heightInput.BackgroundColor3 = Theme.InnerBg
heightInput.Text = "80"
heightInput.TextColor3 = Theme.TextMain
heightInput.Font = Enum.Font.Gotham
heightInput.TextSize = 13
heightInput.PlaceholderText = "10-300"
Instance.new("UICorner", heightInput).CornerRadius = UDim.new(0, 5)

heightInput.FocusLost:Connect(function()
    local val = tonumber(heightInput.Text)
    if val and val >= 10 and val <= 300 then
        hammerHeight = val
        heightLabel.Text = "📏 Высота подъёма: " .. val
    else
        heightInput.Text = tostring(hammerHeight)
    end
end)

local speedLabel = Instance.new("TextLabel", settingsTab)
speedLabel.Size = UDim2.new(1, 0, 0, 18)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "⚡ Скорость удара: 500"
speedLabel.TextColor3 = Theme.TextSub
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextSize = 10
speedLabel.TextXAlignment = Enum.TextXAlignment.Left

local speedInput = Instance.new("TextBox", settingsTab)
speedInput.Size = UDim2.new(1, 0, 0, 30)
speedInput.BackgroundColor3 = Theme.InnerBg
speedInput.Text = "500"
speedInput.TextColor3 = Theme.TextMain
speedInput.Font = Enum.Font.Gotham
speedInput.TextSize = 13
speedInput.PlaceholderText = "100-1500"
Instance.new("UICorner", speedInput).CornerRadius = UDim.new(0, 5)

speedInput.FocusLost:Connect(function()
    local val = tonumber(speedInput.Text)
    if val and val >= 100 and val <= 1500 then
        hammerSpeed = val
        speedLabel.Text = "⚡ Скорость удара: " .. val
    else
        speedInput.Text = tostring(hammerSpeed)
    end
end)

local resetBtn = Instance.new("TextButton", settingsTab)
resetBtn.Size = UDim2.new(1, 0, 0, 32)
resetBtn.BackgroundColor3 = Theme.BtnBg
resetBtn.Text = "🔄 Сбросить статистику"
resetBtn.TextColor3 = Theme.TextSub
resetBtn.Font = Enum.Font.GothamBold
resetBtn.TextSize = 11
resetBtn.BorderSizePixel = 0
Instance.new("UICorner", resetBtn).CornerRadius = UDim.new(0, 5)

resetBtn.MouseButton1Click:Connect(function()
   
