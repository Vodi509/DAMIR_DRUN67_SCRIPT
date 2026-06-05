-- [[ DAMIR_DRUN67 HUB v3.3 - MOLOT FIX + AURA GENERATOR ]] --

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

-- === ДИЗАЙН ===
local Theme = {
    MainBg = Color3.fromRGB(15, 16, 22),
    InnerBg = Color3.fromRGB(22, 24, 33),
    StrokeDefault = Color3.fromRGB(38, 42, 56),
    StatusOnline = Color3.fromRGB(0, 255, 163),
    StatusOffline = Color3.fromRGB(255, 46, 92),
    BtnBg = Color3.fromRGB(30, 33, 45),
    BtnStroke = Color3.fromRGB(52, 58, 77),
    BtnHover = Color3.fromRGB(255, 46, 92),
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

-- === ПОИСК МАШИНЫ ===
local function getMyCar()
    local char = localPlayer.Character
    if char and char:FindFirstChild("Humanoid") and char.Humanoid.SeatPart then
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

-- === ИНТЕРФЕЙС ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedHubDamir"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
screenGui.Parent = (success and coreGui) and coreGui or localPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.4, 0)
mainFrame.Size = UDim2.new(0, 480, 0, 320) -- чуть выше для ауры
mainFrame.BackgroundColor3 = Theme.MainBg
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 1
mainStroke.Color = Theme.StrokeDefault
mainStroke.Parent = mainFrame

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 120, 1, 0)
sidebar.BackgroundColor3 = Theme.InnerBg
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

local sidebarStroke = Instance.new("UIStroke")
sidebarStroke.Thickness = 1
sidebarStroke.Color = Theme.StrokeDefault
sidebarStroke.Parent = sidebar

local logoLabel = Instance.new("TextLabel")
logoLabel.Size = UDim2.new(1, 0, 0, 40)
logoLabel.BackgroundTransparency = 1
logoLabel.Text = "DAMIR HUB"
logoLabel.TextColor3 = Theme.BtnHover
logoLabel.Font = Enum.Font.GothamBold
logoLabel.TextSize = 14
logoLabel.Parent = sidebar

local container = Instance.new("Frame")
container.Position = UDim2.new(0, 130, 0, 10)
container.Size = UDim2.new(1, -140, 1, -20)
container.BackgroundTransparency = 1
container.Parent = mainFrame

local tabs = {}
local function createTab(name)
    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.CanvasSize = UDim2.new(0, 0, 2, 0) -- больше места
    tabFrame.ScrollBarThickness = 2
    tabFrame.Visible = false
    tabFrame.Parent = container
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 8)
    listLayout.Parent = tabFrame
    
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(0, 100, 0, 30)
    tabBtn.Position = UDim2.new(0, 10, 0, 45 + (#container:GetChildren() * 35))
    tabBtn.BackgroundColor3 = Theme.BtnBg
    tabBtn.Text = name
    tabBtn.TextColor3 = Theme.TextMain
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 11
    tabBtn.Parent = sidebar
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = tabBtn
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.Visible = false end
        tabFrame.Visible = true
    end)
    
    tabs[name] = tabFrame
    return tabFrame
end

local farmTab = createTab("🚀 Авто Фарм")
local funTab = createTab("🤡 Fun Zone")
tabs["🚀 Авто Фарм"].Visible = true

-- === АВТО ФАРМ ===
local farmTitle = Instance.new("TextLabel")
farmTitle.Size = UDim2.new(1, 0, 0, 20)
farmTitle.BackgroundTransparency = 1
farmTitle.Text = "ПРОГРАММА «МОЛОТ»"
farmTitle.TextColor3 = Theme.TextMain
farmTitle.Font = Enum.Font.GothamBold
farmTitle.TextSize = 12
farmTitle.TextXAlignment = Enum.TextXAlignment.Left
farmTitle.Parent = farmTab

local carInfoFrame = Instance.new("Frame")
carInfoFrame.Size = UDim2.new(1, 0, 0, 35)
carInfoFrame.BackgroundColor3 = Theme.InnerBg
carInfoFrame.Parent = farmTab

local carInfoCorner = Instance.new("UICorner")
carInfoCorner.CornerRadius = UDim.new(0, 6)
carInfoCorner.Parent = carInfoFrame

local carInfoStroke = Instance.new("UIStroke")
carInfoStroke.Thickness = 1
carInfoStroke.Color = Theme.StrokeDefault
carInfoStroke.Parent = carInfoFrame

local currentCarLabel = Instance.new("TextLabel")
currentCarLabel.Size = UDim2.new(1, -20, 1, 0)
currentCarLabel.Position = UDim2.new(0, 10, 0, 0)
currentCarLabel.BackgroundTransparency = 1
currentCarLabel.Text = "🚗 Ищу машину..."
currentCarLabel.TextColor3 = Theme.TextSub
currentCarLabel.Font = Enum.Font.GothamBold
currentCarLabel.TextSize = 11
currentCarLabel.TextXAlignment = Enum.TextXAlignment.Left
currentCarLabel.Parent = carInfoFrame

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            local foundCar = getMyCar()
            if foundCar then
                currentCarLabel.Text = "🚗 Текущее авто: " .. tostring(foundCar.Name)
                currentCarLabel.TextColor3 = Theme.AccentGlow
            else
                currentCarLabel.Text = "🚗 Сядьте в машину!"
                currentCarLabel.TextColor3 = Theme.StatusOffline
            end
        end)
    end
end)

-- МОЛОТ
local hammerActive = false
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, 0, 0, 40)
toggleBtn.BackgroundColor3 = Theme.BtnBg
toggleBtn.Text = "ВКЛЮЧИТЬ МОЛОТ"
toggleBtn.TextColor3 = Theme.StatusOffline
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 12
toggleBtn.Parent = farmTab

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 6)
toggleCorner.Parent = toggleBtn

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Thickness = 1
toggleStroke.Color = Theme.StrokeDefault
toggleStroke.Parent = toggleBtn

local function runHammer()
    while hammerActive do
        pcall(function()
            local car = getMyCar()
            if not car then
                currentCarLabel.Text = "🚗 Нет машины, жду..."
                task.wait(2)
                return
            end
            
            local root = car:FindFirstChild("PrimaryPart") or car:FindFirstChildWhichIsA("BasePart")
            if not root then return end
            
            root.Velocity = Vector3.new(0, 0, 0)
            root.CFrame = CFrame.new(root.Position.X, 50, root.Position.Z)
            task.wait(0.2)
            root.Velocity = Vector3.new(0, -300, 0)
            task.wait(1.0)
            
            if not car.Parent then
                currentCarLabel.Text = "💀 Машина уничтожена, ожидаю новую..."
                task.wait(3)
            end
        end)
        task.wait(0.5)
    end
end

toggleBtn.MouseButton1Click:Connect(function()
    hammerActive = not hammerActive
    if hammerActive then
        toggleBtn.Text = "МОЛОТ РАБОТАЕТ"
        toggleBtn.TextColor3 = Theme.StatusOnline
        toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 30)
        task.spawn(runHammer)
    else
        toggleBtn.Text = "ВКЛЮЧИТЬ МОЛОТ"
        toggleBtn.TextColor3 = Theme.StatusOffline
        toggleBtn.BackgroundColor3 = Theme.BtnBg
    end
end)

-- === FUN ZONE (AURA + MEMES) ===
local funTitle = Instance.new("TextLabel")
funTitle.Size = UDim2.new(1, 0, 0, 20)
funTitle.BackgroundTransparency = 1
funTitle.Text = "💎 AURA GENERATOR"
funTitle.TextColor3 = Theme.TextMain
funTitle.Font = Enum.Font.GothamBold
funTitle.TextSize = 12
funTitle.TextXAlignment = Enum.TextXAlignment.Left
funTitle.Parent = funTab

local auraCount = 0
local auraLabel = Instance.new("TextLabel")
auraLabel.Size = UDim2.new(1, 0, 0, 30)
auraLabel.BackgroundColor3 = Theme.InnerBg
auraLabel.Text = "💎 Текущая аура: 0"
auraLabel.TextColor3 = Theme.AccentGlow
auraLabel.Font = Enum.Font.GothamBold
auraLabel.TextSize = 14
auraLabel.Parent = funTab

local auraCorner = Instance.new("UICorner")
auraCorner.CornerRadius = UDim.new(0, 6)
auraCorner.Parent = auraLabel

local addAuraBtn = Instance.new("TextButton")
addAuraBtn.Size = UDim2.new(1, 0, 0, 45)
addAuraBtn.BackgroundColor3 = Theme.BtnBg
addAuraBtn.Text = "✨ +1 000 000 AURA"
addAuraBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
addAuraBtn.Font = Enum.Font.GothamBold
addAuraBtn.TextSize = 14
addAuraBtn.Parent = funTab

local addCorner = Instance.new("UICorner")
addCorner.CornerRadius = UDim.new(0, 6)
addCorner.Parent = addAuraBtn

local addStroke = Instance.new("UIStroke")
addStroke.Thickness = 1.5
addStroke.Color = Color3.fromRGB(255, 200, 0)
addStroke.Parent = addAuraBtn

addAuraBtn.MouseButton1Click:Connect(function()
    auraCount = auraCount + 1000000
    auraLabel.Text = "💎 Текущая аура: " .. auraCount
    addAuraBtn.BackgroundColor3 = Color3.fromRGB(50, 40, 0)
    task.wait(0.15)
    addAuraBtn.BackgroundColor3 = Theme.BtnBg
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "AURA EARNED",
            Text = "+1,000,000 AURA!",
            Duration = 3,
            Icon = "rbxassetid://18314115147"
        })
    end)
end)

local memeLabel = Instance.new("TextLabel")
memeLabel.Size = UDim2.new(1, 0, 0, 20)
memeLabel.BackgroundTransparency = 1
memeLabel.Text = "🎭 МЕМ ГЕНЕРАТОР"
memeLabel.TextColor3 = Theme.TextMain
memeLabel.Font = Enum.Font.GothamBold
memeLabel.TextSize = 12
memeLabel.TextXAlignment = Enum.TextXAlignment.Left
memeLabel.Parent = funTab

local memeImage = Instance.new("ImageLabel")
memeImage.Size = UDim2.new(0, 140, 0, 140)
memeImage.BackgroundColor3 = Theme.InnerBg
memeImage.Image = MemeIds[1]
memeImage.Parent = funTab

local memeCorner = Instance.new("UICorner")
memeCorner.CornerRadius = UDim.new(0, 6)
memeCorner.Parent = memeImage

local nextMemeBtn = Instance.new("TextButton")
nextMemeBtn.Size = UDim2.new(1, 0, 0, 35)
nextMemeBtn.BackgroundColor3 = Theme.BtnBg
nextMemeBtn.Text = "НЕ СМЕШНО, ДАВАЙ СЛЕДУЮЩИЙ"
nextMemeBtn.TextColor3 = Theme.TextMain
nextMemeBtn.Font = Enum.Font.GothamBold
nextMemeBtn.TextSize = 11
nextMemeBtn.Parent = funTab

local nextCorner = Instance.new("UICorner")
nextCorner.CornerRadius = UDim.new(0, 6)
nextCorner.Parent = nextMemeBtn

nextMemeBtn.MouseButton1Click:Connect(function()
    local randomMeme = MemeIds[math.random(1, #MemeIds)]
    memeImage.Image = randomMeme
end)
