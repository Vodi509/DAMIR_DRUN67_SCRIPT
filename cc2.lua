-- [[ DAMIR_DRUN67 ULTIMATE HUB v12 ]] --
-- Дизайн на основе 1000033498.jpg (Speed Hub Style x Delta)

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Очистка старого GUI
if CoreGui:FindFirstChild("DamirUltimateHub") then
    CoreGui.DamirUltimateHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DamirUltimateHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Главное окно (размер чуть больше под стиль хаба, но компактный)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 420, 0, 260)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Верхняя панель (Топбар)
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
TopBar.BorderSizePixel = 0
local TopCorner = Instance.new("UICorner", TopBar)
TopCorner.CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0.03, 0, 0, 0)
Title.Text = "DAMIR HUB v12 | Car Crushers 2 & Misc"
Title.TextColor3 = Color3.fromRGB(230, 230, 235)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

-- Кнопка закрытия (X)
local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(0.93, 0, 0, 0)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.fromRGB(200, 70, 70)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextSize = 14

-- Кот-сворачиватель (круглый)
local CatBtn = Instance.new("ImageButton", ScreenGui)
CatBtn.Size = UDim2.new(0, 50, 0, 50)
CatBtn.Position = UDim2.new(0.02, 0, 0.05, 0)
CatBtn.Image = "rbxassetid://18314115147"
CatBtn.Visible = false
CatBtn.BorderSizePixel = 0
Instance.new("UICorner", CatBtn).CornerRadius = UDim.new(1, 0)

-- Боковое меню (Sidebar) как на скриншоте 1000033498.jpg
local SideBar = Instance.new("Frame", MainFrame)
SideBar.Size = UDim2.new(0, 110, 0, 230)
SideBar.Position = UDim2.new(0, 0, 0, 30)
SideBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
SideBar.BorderSizePixel = 0

-- Контейнер для вкладок (справа)
local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(0, 310, 0, 230)
ContentFrame.Position = UDim2.new(0, 110, 0, 30)
ContentFrame.BackgroundTransparency = 1

local Tabs = {}
local currentTab = nil

local function CreateTab(name)
    local tabContainer = Instance.new("ScrollingFrame", ContentFrame)
    tabContainer.Size = UDim2.new(1, 0, 1, 0)
    tabContainer.BackgroundTransparency = 1
    tabContainer.CanvasSize = UDim2.new(0, 0, 2, 0)
    tabContainer.ScrollBarThickness = 2
    tabContainer.Visible = false
    
    local layout = Instance.new("UIListLayout", tabContainer)
    layout.Padding = UDim.new(0, 6)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    Tabs[name] = tabContainer
    
    -- Кнопка в боковом меню
    local count = 0
    for _ in pairs(Tabs) do count = count + 1 end
    
    local TabBtn = Instance.new("TextButton", SideBar)
    TabBtn.Size = UDim2.new(0.9, 0, 0, 32)
    TabBtn.Position = UDim2.new(0.05, 0, 0, (count - 1) * 36 + 10)
    TabBtn.Text = name
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.TextSize = 12
    TabBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
    TabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    TabBtn.BorderSizePixel = 0
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 4)
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do t.Visible = false end
        tabContainer.Visible = true
        currentTab = name
    end)
    
    return tabContainer
end

-- Создаем вкладки из структуры Speedhub
local MainTab = CreateTab("🏠 Main")
local FarmTab = CreateTab("⚡ Auto Farm")
local MiscTab = CreateTab("⚙️ Misc")
local SettingsTab = CreateTab("🛠️ Settings")

Tabs["🏠 Main"].Visible = true -- Открыта по дефолту

-- Функция добавления кнопок (Элементы)
local function AddButton(tab, text, callback)
    local btn = Instance.new("TextButton", tab)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.Text = text
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Функция добавления тогглов (Переключателей)
local function AddToggle(tab, text, callback)
    local frame = Instance.new("Frame", tab)
    frame.Size = UDim2.new(0.9, 0, 0, 35)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    
    local state = false
    local tBtn = Instance.new("TextButton", frame)
    tBtn.Size = UDim2.new(0, 40, 0, 20)
    tBtn.Position = UDim2.new(0.8, 0, 0.2, 0)
    tBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    tBtn.Text = ""
    Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 10)
    
    tBtn.MouseButton1Click:Connect(function()
        state = not state
        tBtn.BackgroundColor3 = state and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 70)
        callback(state)
    end)
end

-- === НАПОЛНЕНИЕ ВКЛАДОК НАШИМИ ФУНКЦИЯМИ ===

-- Вкладка: Main
local InfoLabel = Instance.new("TextLabel", MainTab)
InfoLabel.Size = UDim2.new(0.9, 0, 0, 40)
InfoLabel.Text = "Добро пожаловать, Дамир!\nСкрипт v12 готов к работе."
InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextSize = 12
InfoLabel.BackgroundTransparency = 1

-- Вкладка: Auto Farm (Car Crushers 2 Логика)
local function getBestCrusher()
    local cFolder = workspace:FindFirstChild("Crushers")
    if not cFolder then return nil end
    for _, v in pairs(cFolder:GetChildren()) do
        if v:FindFirstChild("Status") and (v.Status.Value == "Frenzy" or v.Status.Value == "Bonus") then
            return v:FindFirstChild("Base")
        end
    end
    return cFolder:GetChildren()[1]:FindFirstChild("Base")
end

local AutoEverything = false
AddToggle(FarmTab, "Автофарм Всего (Frenzy/Bonus)", function(state)
    AutoEverything = state
    if AutoEverything then
        task.spawn(function()
            while AutoEverything do
                local seat = lp.Character and lp.Character:FindFirstChild("Humanoid") and lp.Character.Humanoid.SeatPart
                if not seat then
                    pcall(function() game:GetService("ReplicatedStorage").NetworkRemote.SpawnVehicle:InvokeServer(1) end)
                else
                    local car = seat.Parent
                    local target = getBestCrusher()
                    if target then
                        car:MoveTo(target.Position)
                        task.wait(1.5)
                        car.PrimaryPart.CFrame = target.CFrame + Vector3.new(0, 5, 0)
                    end
                end
                task.wait(2)
            end
        end)
    end
end)

-- Вкладка: Misc (Универсальные настройки из Speedhub, не привязанные к играм)
AddToggle(MiscTab, "Performance Mode (Оптимизация)", function(state)
    -- Отключаем лишние тени и эффекты для FPS
    game:GetService("Lighting").GlobalShadows = not state
end)

AddButton(MiscTab, "Server Hop (Смена Сервера)", function()
    local x = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for _, v in pairs(x.data) do
        if v.playing < v.maxPlayers then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id, lp)
            break
        end
    end
end)

AddToggle(MiscTab, "Player ESP (Подсветка игроков)", function(state)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            if state then
                local box = Instance.new("BoxHandleAdornment", p.Character.HumanoidRootPart)
                box.Name = "DamirESP"
                box.Size = Vector3.new(2, 4, 1)
                box.Color3 = Color3.fromRGB(255, 0, 0)
                box.AlwaysOnTop = true
                box.ZIndex = 5
                box.Adornee = p.Character.HumanoidRootPart
            else
                if p.Character.HumanoidRootPart:FindFirstChild("DamirESP") then
                    p.Character.HumanoidRootPart.DamirESP:Destroy()
                end
            end
        end
    end
end)

-- Вкладка: Settings
local Signature = Instance.new("TextLabel", SettingsTab)
Signature.Size = UDim2.new(0.9, 0, 0, 30)
Signature.Text = "by DAMIR_DRUN67"
Signature.TextColor3 = Color3.fromRGB(120, 120, 130)
Signature.Font = Enum.Font.GothamBold
Signature.TextSize = 13
Signature.BackgroundTransparency = 1

-- Логика скрытия интерфейса (Кот)
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    CatBtn.Visible = true
end)

CatBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    CatBtn.Visible = false
end)
