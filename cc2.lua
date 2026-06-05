-- [[ DAMIR_DRUN67 HUB v3.0 - INFINITE AUTOFARM EDITION ]] --

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

-- === СТРОГАЯ ДИЗАЙН-СИСТЕМА (КИБЕРПАНК) ===
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
    "rbxassetid://18314115147", 
    "rbxassetid://6072171427",  
    "rbxassetid://6072166311",  
    "rbxassetid://6072153923"   
}

-- === СОЗДАНИЕ ИНТЕРФЕЙСА ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedHubDamir"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
screenGui.Parent = (success and coreGui) and coreGui or localPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.4, 0)
mainFrame.Size = UDim2.new(0, 480, 0, 300)
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

-- === БОКОВАЯ ПАНЕЛЬ ===
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

-- === ЛОГИКА ВКЛАДОК ===
local tabs = {}
local currentTab = nil

local function createTab(name)
    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)
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

-- === РАЗДЕЛ 1: АВТО ФАРМ И ИНФО О МАШИНЕ ===
local farmTitle = Instance.new("TextLabel")
farmTitle.Size = UDim2.new(1, 0, 0, 20)
farmTitle.BackgroundTransparency = 1
farmTitle.Text = "ПРОГРАММА «МОЛОТ» (БЕСКОНЕЧНАЯ)"
farmTitle.TextColor3 = Theme.TextMain
farmTitle.Font = Enum.Font.GothamBold
farmTitle.TextSize = 12
farmTitle.TextXAlignment = Enum.TextXAlignment.Left
farmTitle.Parent = farmTab

-- ПАНЕЛЬ ОПРЕДЕЛЕНИЯ МАШИНЫ
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
currentCarLabel.Text = "🚗 Сканирование авто..."
currentCarLabel.TextColor3 = Theme.TextSub
currentCarLabel.Font = Enum.Font.GothamBold
currentCarLabel.TextSize = 11
currentCarLabel.TextXAlignment = Enum.TextXAlignment.Left
currentCarLabel.Parent = carInfoFrame

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            local foundCar = nil
            local carName = nil
            
            for _, v in pairs(workspace.Vehicles:GetChildren()) do
                if v:FindFirstChild("Owner") and v.Owner.Value == localPlayer then
                    foundCar = v
                    carName = v.Name
                    break
                end
            end
            
            if foundCar and carName then
                currentCarLabel.Text = "🚗 Текущее авто: " .. tostring(carName)
                currentCarLabel.TextColor3 = Theme.AccentGlow
            else
                currentCarLabel.Text = "🚗 Авто: Нет на карте"
                currentCarLabel.TextColor3 = Theme.StatusOffline
            end
        end)
    end
end)

-- ОПИСАНИЕ И КНОПКА МОЛОТА
local farmDesc = Instance.new("TextLabel")
farmDesc.Size = UDim2.new(1, 0, 0, 30)
farmDesc.BackgroundTransparency = 1
farmDesc.Text = "Автоматически подкидывает, разбивает и респавнит твою машину по кругу."
farmDesc.TextColor3 = Theme.TextSub
farmDesc.Font = Enum.Font.Gotham
farmDesc.TextSize = 10
farmDesc.TextWrapped = true
farmDesc.TextXAlignment = Enum.TextXAlignment.Left
farmDesc.Parent = farmTab

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

-- === ОБНОВЛЕННАЯ ЛОГИКА ФАРМА С АВТОРЕСПАВНОМ ===
local function runHammer()
    while hammerActive do
        pcall(function()
            local car = nil
            -- 1. Ищем машину
            for _, v in pairs(workspace.Vehicles:GetChildren()) do
                if v:FindFirstChild("Owner") and v.Owner.Value == localPlayer then
                    car = v
                    break
                end
            end
            
            if car and car:FindFirstChild("PrimaryPart") then
                local root = car.PrimaryPart
                -- 2. Подкидываем и бьем
                root.CFrame = CFrame.new(root.Position.X, 650, root.Position.Z)
                task.wait(0.15)
                root.AssemblyLinearVelocity = Vector3.new(0, -6000, 0)
                
                -- 3. Ждем, пока машина разобьется и начислятся деньги
                task.wait(1.5) 
                
                -- 4. АВТОРЕСПАВН (Бот сам жмет кнопку респавна текущей машины)
                game:GetService("ReplicatedStorage").NetworkRemote.SpawnVehicle:InvokeServer()
                task.wait(1) -- Ждем пока машина появится
            else
                -- Если машины вообще нет, просто спавним её
                game:GetService("ReplicatedStorage").NetworkRemote.SpawnVehicle:InvokeServer()
                task.wait(1.5)
            end
        end)
        task.wait(0.1) -- Небольшая пауза, чтобы не перегружать сервер
    end
end

toggleBtn.MouseButton1Click:Connect(function()
    hammerActive = not hammerActive
    if hammerActive then
        toggleBtn.Text = "МОЛОТ РАБОТАЕТ (АВТО)"
        toggleBtn.TextColor3 = Theme.StatusOnline
        toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 30)
        task.spawn(runHammer)
    else
        toggleBtn.Text = "ВКЛЮЧИТЬ МОЛОТ"
        toggleBtn.TextColor3 = Theme.StatusOffline
        toggleBtn.BackgroundColor3 = Theme.BtnBg
    end
end)

-- === РАЗДЕЛ 2: FUN ZONE (МЕМЫ И ОТСЫЛКИ) ===
local funTitle = Instance.new("TextLabel")
funTitle.Size = UDim2.new(1, 0, 0, 20)
funTitle.BackgroundTransparency = 1
funTitle.Text = "МЕМ ГЕНЕРАТОР"
funTitle.TextColor3 = Theme.TextMain
funTitle.Font = Enum.Font.GothamBold
funTitle.TextSize = 12
funTitle.TextXAlignment = Enum.TextXAlignment.Left
funTitle.Parent = funTab

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

local secretBtn = Instance.new("TextButton")
secretBtn.Size = UDim2.new(1, 0, 0, 30)
secretBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 25)
secretBtn.Text = "⚠️ СЕКРЕТНАЯ КНОПКА ДАМИРА"
secretBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
secretBtn.Font = Enum.Font.GothamBold
secretBtn.TextSize = 10
secretBtn.Parent = funTab

local secretCorner = Instance.new("UICorner")
secretCorner.CornerRadius = UDim.new(0, 6)
secretCorner.Parent = secretBtn

secretBtn.MouseButton1Click:Connect(function()
    secretBtn.Text = "Скрипт заряжен на 1000000$!"
    task.wait(1.5)
    secretBtn.Text = "⚠️ СЕКРЕТНАЯ КНОПКА ДАМИРА"
end)

