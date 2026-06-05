-- ============================================================
-- CC2 AUTOFARM - SpeedHub Style GUI + CAT BUTTON
-- Репозиторий: github.com/Vodi509/DAMIR_DRUN67_SCRIPT
-- Файл: cc2.lua
-- Версия: 4.0 Cat Button Final
-- ============================================================

-- Ждём загрузки
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer.Character
repeat task.wait() until workspace:FindFirstChild("Vehicles")

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ==================== УВЕДОМЛЕНИЯ ====================
local function Notify(title, text, dur)
    dur = dur or 3
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = tostring(title),
            Text = tostring(text),
            Duration = dur,
            Icon = "rbxassetid://2541869220"
        })
    end)
end

-- ==================== БИБЛИОТЕКА GUI ====================
local Library = {}

function Library:CreateWindow(title)
    local screen = Instance.new("ScreenGui")
    screen.Name = "CC2_Farm_GUI"
    screen.ResetOnSpawn = false
    screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screen.Parent = playerGui

    -- ====== КНОПКА-КОТ (СВОРАЧИВАНИЕ) ======
    local catBtn = Instance.new("ImageButton")
    catBtn.Name = "CatBtn"
    catBtn.Size = UDim2.new(0, 55, 0, 55)
    catBtn.Position = UDim2.new(0.03, 0, 0.15, 0)
    catBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    catBtn.Image = "rbxassetid://18314115147"
    catBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)
    catBtn.ScaleType = Enum.ScaleType.Fit
    catBtn.ZIndex = 100
    catBtn.Visible = false  -- Изначально скрыта
    catBtn.Active = true
    catBtn.Draggable = true  -- Можно перетаскивать по экрану
    catBtn.Parent = screen

    local catCorner = Instance.new("UICorner")
    catCorner.CornerRadius = UDim.new(1, 0)
    catCorner.Parent = catBtn

    -- Обводка кота
    local catStroke = Instance.new("UIStroke")
    catStroke.Color = Color3.fromRGB(70, 130, 255)
    catStroke.Thickness = 2
    catStroke.Parent = catBtn

    -- Подсказка при наведении
    local catTooltip = Instance.new("TextLabel")
    catTooltip.Size = UDim2.new(0, 120, 0, 20)
    catTooltip.Position = UDim2.new(1.1, 0, 0.3, 0)
    catTooltip.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    catTooltip.Text = "🐱 Развернуть"
    catTooltip.TextColor3 = Color3.fromRGB(255, 255, 255)
    catTooltip.TextSize = 12
    catTooltip.Font = Enum.Font.Gotham
    catTooltip.Visible = false
    catTooltip.Parent = catBtn

    local tooltipCorner = Instance.new("UICorner")
    tooltipCorner.CornerRadius = UDim.new(0, 4)
    tooltipCorner.Parent = catTooltip

    catBtn.MouseEnter:Connect(function()
        catTooltip.Visible = true
        catBtn.Size = UDim2.new(0, 60, 0, 60)
    end)

    catBtn.MouseLeave:Connect(function()
        catTooltip.Visible = false
        catBtn.Size = UDim2.new(0, 55, 0, 55)
    end)

    -- ====== ГЛАВНОЕ ОКНО ======
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 600, 0, 420)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -210)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.ZIndex = 50
    mainFrame.Visible = true
    mainFrame.Parent = screen

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = mainFrame

    -- Заголовок
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = titleBar

    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -100, 1, 0)
    titleText.Position = UDim2.new(0, 15, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = title
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.TextSize = 18
    titleText.Font = Enum.Font.GothamBold
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar

    -- Кнопка "Кот" на заголовке (индикатор)
    local catIndicator = Instance.new("ImageLabel")
    catIndicator.Size = UDim2.new(0, 24, 0, 24)
    catIndicator.Position = UDim2.new(1, -70, 0, 8)
    catIndicator.BackgroundTransparency = 1
    catIndicator.Image = "rbxassetid://18314115147"
    catIndicator.ImageColor3 = Color3.fromRGB(255, 200, 100)
    catIndicator.ScaleType = Enum.ScaleType.Fit
    catIndicator.Parent = titleBar

    -- Кнопка сворачивания (превращает окно в кота)
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    minimizeBtn.Position = UDim2.new(1, -40, 0, 5)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
    minimizeBtn.Text = "—"
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.TextSize = 18
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.Parent = titleBar

    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 15)
    minCorner.Parent = minimizeBtn

    minimizeBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        catBtn.Visible = true
        Notify("🐱", "Окно свёрнуто. Нажмите на кота чтобы развернуть.", 3)
    end)

    -- Кнопка закрытия (полное выключение)
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -75, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 16
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = titleBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 15)
    closeCorner.Parent = closeBtn

    closeBtn.MouseButton1Click:Connect(function()
        screen:Destroy()
        Notify("CC2 Farm", "Скрипт полностью выключен.", 3)
    end)

    -- Обратное действие: клик по коту разворачивает окно
    catBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = true
        catBtn.Visible = false
        Notify("🐱", "Окно развёрнуто!", 2)
    end)

    -- Вкладки (Tab Bar)
    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(0, 140, 1, -50)
    tabBar.Position = UDim2.new(0, 10, 0, 50)
    tabBar.BackgroundTransparency = 1
    tabBar.Parent = mainFrame

    local tabList = Instance.new("UIListLayout")
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabList.Padding = UDim.new(0, 5)
    tabList.Parent = tabBar

    -- Контейнер контента
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -160, 1, -60)
    content.Position = UDim2.new(0, 155, 0, 55)
    content.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    content.BorderSizePixel = 0
    content.Parent = mainFrame

    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 6)
    contentCorner.Parent = content

    local tabs = {}

    local self = {
        screen = screen,
        mainFrame = mainFrame,
        catBtn = catBtn,
        content = content,
        tabs = tabs
    }

    function self:AddTab(name)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 35)
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        btn.TextSize = 14
        btn.Font = Enum.Font.GothamSemibold
        btn.BorderSizePixel = 0
        btn.Parent = tabBar

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn

        local page = Instance.new("ScrollingFrame")
        page.Size = UDim2.new(1, -20, 1, -20)
        page.Position = UDim2.new(0, 10, 0, 10)
        page.BackgroundTransparency = 1
        page.ScrollBarThickness = 4
        page.Visible = false
        page.Parent = content

        local pageLayout = Instance.new("UIListLayout")
        pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        pageLayout.Padding = UDim.new(0, 8)
        pageLayout.Parent = page

        table.insert(tabs, {button = btn, page = page})

        btn.MouseButton1Click:Connect(function()
            for _, t in pairs(tabs) do
                t.button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                t.page.Visible = false
            end
            btn.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
            page.Visible = true
        end)

        return page
    end

    if #tabs > 0 then
        tabs[1].button.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
        tabs[1].page.Visible = true
    end

    return self
end

-- ==================== СОЗДАЁМ GUI ====================
local Window = Library:CreateWindow("🐱 CC2 AUTOFARM v4.0")
local MainTab = Window:AddTab("🚗 Фарм")
local SettingsTab = Window:AddTab("⚙️ Настройки")
local InfoTab = Window:AddTab("📊 Статистика")

-- ==================== ЭЛЕМЕНТЫ GUI ====================

-- СТАТУС
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 40)
statusLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
statusLabel.Text = "⚪ Статус: Готов к работе"
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.TextSize = 16
statusLabel.Font = Enum.Font.GothamBold
statusLabel.Parent = MainTab

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 6)
statusCorner.Parent = statusLabel

-- КНОПКА СТАРТ
local startBtn = Instance.new("TextButton")
startBtn.Size = UDim2.new(1, 0, 0, 45)
startBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
startBtn.Text = "▶️ ЗАПУСТИТЬ ФАРМ"
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.TextSize = 18
startBtn.Font = Enum.Font.GothamBold
startBtn.Parent = MainTab

local startCorner = Instance.new("UICorner")
startCorner.CornerRadius = UDim.new(0, 8)
startCorner.Parent = startBtn

-- КНОПКА СТОП
local stopBtn = Instance.new("TextButton")
stopBtn.Size = UDim2.new(1, 0, 0, 45)
stopBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
stopBtn.Text = "⏹️ ОСТАНОВИТЬ"
stopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stopBtn.TextSize = 18
stopBtn.Font = Enum.Font.GothamBold
stopBtn.Parent = MainTab

local stopCorner = Instance.new("UICorner")
stopCorner.CornerRadius = UDim.new(0, 8)
stopCorner.Parent = stopBtn

-- ИНФО
local carLabel = Instance.new("TextLabel")
carLabel.Size = UDim2.new(1, 0, 0, 30)
carLabel.BackgroundTransparency = 1
carLabel.Text = "🚙 Машина: Нет"
carLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
carLabel.TextSize = 14
carLabel.Font = Enum.Font.Gotham
carLabel.TextXAlignment = Enum.TextXAlignment.Left
carLabel.Parent = MainTab

local countLabel = Instance.new("TextLabel")
countLabel.Size = UDim2.new(1, 0, 0, 30)
countLabel.BackgroundTransparency = 1
countLabel.Text = "💥 Уничтожено: 0"
countLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
countLabel.TextSize = 14
countLabel.Font = Enum.Font.Gotham
countLabel.TextXAlignment = Enum.TextXAlignment.Left
countLabel.Parent = MainTab

local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(1, 0, 0, 30)
timerLabel.BackgroundTransparency = 1
timerLabel.Text = "⏱️ Время работы: 00:00"
timerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
timerLabel.TextSize = 14
timerLabel.Font = Enum.Font.Gotham
timerLabel.TextXAlignment = Enum.TextXAlignment.Left
timerLabel.Parent = MainTab

-- ==================== ВКЛАДКА НАСТРОЕК ====================
local heightLabel = Instance.new("TextLabel")
heightLabel.Size = UDim2.new(1, 0, 0, 25)
heightLabel.BackgroundTransparency = 1
heightLabel.Text = "📏 Высота телепорта: 15"
heightLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
heightLabel.TextSize = 14
heightLabel.Font = Enum.Font.Gotham
heightLabel.TextXAlignment = Enum.TextXAlignment.Left
heightLabel.Parent = SettingsTab

local heightSlider = Instance.new("TextBox")
heightSlider.Size = UDim2.new(1, 0, 0, 35)
heightSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
heightSlider.Text = "15"
heightSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
heightSlider.TextSize = 16
heightSlider.Font = Enum.Font.Gotham
heightSlider.PlaceholderText = "Высота (5-50)"
heightSlider.Parent = SettingsTab

local heightCorner = Instance.new("UICorner")
heightCorner.CornerRadius = UDim.new(0, 6)
heightCorner.Parent = heightSlider

local timeoutLabel = Instance.new("TextLabel")
timeoutLabel.Size = UDim2.new(1, 0, 0, 25)
timeoutLabel.BackgroundTransparency = 1
timeoutLabel.Text = "⏰ Таймаут краша: 20 сек"
timeoutLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
timeoutLabel.TextSize = 14
timeoutLabel.Font = Enum.Font.Gotham
timeoutLabel.TextXAlignment = Enum.TextXAlignment.Left
timeoutLabel.Parent = SettingsTab

local timeoutSlider = Instance.new("TextBox")
timeoutSlider.Size = UDim2.new(1, 0, 0, 35)
timeoutSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
timeoutSlider.Text = "20"
timeoutSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
timeoutSlider.TextSize = 16
timeoutSlider.Font = Enum.Font.Gotham
timeoutSlider.PlaceholderText = "Таймаут (10-60)"
timeoutSlider.Parent = SettingsTab

local timeoutCorner = Instance.new("UICorner")
timeoutCorner.CornerRadius = UDim.new(0, 6)
timeoutCorner.Parent = timeoutSlider

local antiDetectToggle = Instance.new("TextButton")
antiDetectToggle.Size = UDim2.new(1, 0, 0, 40)
antiDetectToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
antiDetectToggle.Text = "🛡️ Анти-детект: ВКЛ"
antiDetectToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
antiDetectToggle.TextSize = 14
antiDetectToggle.Font = Enum.Font.GothamBold
antiDetectToggle.Parent = SettingsTab

local antiCorner = Instance.new("UICorner")
antiCorner.CornerRadius = UDim.new(0, 6)
antiCorner.Parent = antiDetectToggle

local antiDetectEnabled = true
antiDetectToggle.MouseButton1Click:Connect(function()
    antiDetectEnabled = not antiDetectEnabled
    if antiDetectEnabled then
        antiDetectToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        antiDetectToggle.Text = "🛡️ Анти-детект: ВКЛ"
    else
        antiDetectToggle.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        antiDetectToggle.Text = "🛡️ Анти-детект: ВЫКЛ"
    end
end)

-- ==================== ВКЛАДКА СТАТИСТИКИ ====================
local totalCrushesLabel = Instance.new("TextLabel")
totalCrushesLabel.Size = UDim2.new(1, 0, 0, 40)
totalCrushesLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
totalCrushesLabel.Text = "💥 Всего уничтожено: 0"
totalCrushesLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
totalCrushesLabel.TextSize = 18
totalCrushesLabel.Font = Enum.Font.GothamBold
totalCrushesLabel.Parent = InfoTab

local statCorner = Instance.new("UICorner")
statCorner.CornerRadius = UDim.new(0, 6)
statCorner.Parent = totalCrushesLabel

local errorsLabel = Instance.new("TextLabel")
errorsLabel.Size = UDim2.new(1, 0, 0, 30)
errorsLabel.BackgroundTransparency = 1
errorsLabel.Text = "⚠️ Ошибок: 0"
errorsLabel.TextColor3 = Color3.fromRGB(255, 180, 50)
errorsLabel.TextSize = 14
errorsLabel.Font = Enum.Font.Gotham
errorsLabel.TextXAlignment = Enum.TextXAlignment.Left
errorsLabel.Parent = InfoTab

local uptimeLabel = Instance.new("TextLabel")
uptimeLabel.Size = UDim2.new(1, 0, 0, 30)
uptimeLabel.BackgroundTransparency = 1
uptimeLabel.Text = "⏱️ Аптайм: 00:00:00"
uptimeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
uptimeLabel.TextSize = 14
uptimeLabel.Font = Enum.Font.Gotham
uptimeLabel.TextXAlignment = Enum.TextXAlignment.Left
uptimeLabel.Parent = InfoTab

-- ==================== ЛОГИКА ФАРМА ====================
local Farming = {
    running = false,
    totalCrushes = 0,
    errors = 0,
    startTime = 0,
    currentCar = "Нет"
}

local crushEvent = nil
local crusherTarget = nil
local allEvents = {}

local function scanGame()
    allEvents = {}
    for _, obj in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            table.insert(allEvents, obj)
        end
    end

    local parts = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local n = obj.Name:lower()
            if n:find("crusher") or n:find("press") or n:find("crush") then
                table.insert(parts, obj)
            end
        end
    end

    if #parts > 0 then
        table.sort(parts, function(a, b) return a.Size.Magnitude > b.Size.Magnitude end)
        crusherTarget = parts[1]
    end

    crushEvent = nil
    for _, ev in pairs(allEvents) do
        if ev.Name:lower():find("crush") then
            crushEvent = ev
            break
        end
    end
end

local function getMyVehicles()
    local list = {}
    local folder = workspace:FindFirstChild("Vehicles")
    if not folder then return list end

    for _, v in pairs(folder:GetChildren()) do
        if v:IsA("Model") then
            local owner = v:FindFirstChild("Owner")
            if owner and owner:IsA("ObjectValue") and owner.Value == player then
                table.insert(list, v)
            end
        end
    end
    return list
end

local function getRoot(model)
    return model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
end

local function vehicleExists(model)
    return model ~= nil and model.Parent ~= nil
end

local function startFarming()
    if Farming.running then return end

    scanGame()

    if not crusherTarget then
        statusLabel.Text = "🔴 Ошибка: Дробилка не найдена!"
        statusLabel.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        Notify("❌ Ошибка", "Дробилка не найдена! Подойдите к дробилке и перезапустите скрипт.", 5)
        return
    end

    Farming.running = true
    Farming.startTime = tick()
    statusLabel.Text = "🟢 Статус: Фарм запущен"
    statusLabel.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
    startBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    Notify("🚀 Фарм", "Автофарм запущен! Можно свернуть окно на кота 🐱", 4)

    spawn(function()
        while Farming.running do
            local ok = pcall(function()
                local char = player.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then
                    statusLabel.Text = "🟡 Жду респавн..."
                    task.wait(3)
                    return
                end

                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health <= 0 then
                    statusLabel.Text = "💀 Персонаж мёртв, жду..."
                    task.wait(3)
                    return
                end

                local cars = getMyVehicles()
                if #cars == 0 then
                    statusLabel.Text = "🟡 Нет машин! Купите машину."
                    carLabel.Text = "🚙 Машина: Нет"
                    task.wait(5)
                    return
                end

                local car = cars[1]
                Farming.currentCar = car.Name
                carLabel.Text = "🚙 Машина: " .. car.Name
                statusLabel.Text = "🔵 Телепорт " .. car.Name .. "..."

                local height = tonumber(heightSlider.Text) or 15
                local pos = crusherTarget.Position + Vector3.new(0, height, 0)
                local root = getRoot(car)

                if root then
                    root.CFrame = CFrame.new(pos)
                    root.Velocity = Vector3.zero
                    root.RotVelocity = Vector3.zero
                    task.wait(0.1)
              
