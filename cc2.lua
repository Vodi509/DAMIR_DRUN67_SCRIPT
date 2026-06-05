-- [[ DAMIR_DRUN67 SCRIPT v5 - ULTIMATE MULTI-TAB EDITION ]] --

if game.CoreGui:FindFirstChild("DamirScriptGui") then
    game.CoreGui.DamirScriptGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DamirScriptGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Глобальные переменные настроек
local currentLang = "RU"
local currentThemeIdx = 1
local SafeCash = false
local SafeQuests = false
local AutoPlatinum = false

-- Цветовые темы
local colorThemes = {
    Color3.fromRGB(0, 170, 255),  -- Неоновый Голубой
    Color3.fromRGB(46, 204, 113), -- Изумрудный Зеленый
    Color3.fromRGB(231, 76, 60),  -- Рубиновый Красный
    Color3.fromRGB(241, 196, 15), -- Золотой Янтарный
    Color3.fromRGB(155, 89, 182)  -- Аметистовый Фиолетовый
}

-- Таблица локализации (Перевод)
local translations = {
    RU = {
        title = "🛡️ DAMIR_DRUN67 SCRIPT v5",
        tabMain = "🏠 Главная", tabFarm = "⚙️ Фарм", tabPass = "🎁 Пассы",
        inCar = "🚗 Вы в машине", notInCar = "❌ Вы не в машине", checking = "Проверка...",
        farmOn = "💰 Фарм Денег: ВКЛ", farmOff = "💰 Фарм Денег: ВЫКЛ",
        questOn = "📜 Авто-Квесты: ВКЛ", questOff = "📜 Авто-Квесты: ВЫКЛ",
        platOn = "💎 Авто-Платина: ВКЛ", platOff = "💎 Авто-Платина: ВЫКЛ",
        langBtn = "🌐 Язык: RU", colorBtn = "🎨 Сменить цвет темы",
        gp1 = "⚡ Фейк x2 Деньги", gp2 = "🏎️ Открыть Суперкары", gp3 = "👑 Элитный Статус",
        gpActive = "АКТИВИРОВАНО (Визуал)", statusTitle = "Статус машины:"
    },
    EN = {
        title = "🛡️ DAMIR_DRUN67 SCRIPT v5",
        tabMain = "🏠 Main", tabFarm = "⚙️ Farm", tabPass = "🎁 Passes",
        inCar = "🚗 You in the car", notInCar = "❌ You not in the car", checking = "Checking...",
        farmOn = "💰 Farm Cash: ON", farmOff = "💰 Farm Cash: OFF",
        questOn = "📜 Auto-Quests: ON", questOff = "📜 Auto-Quests: OFF",
        platOn = "💎 Auto-Platinum: ON", platOff = "💎 Auto-Platinum: OFF",
        langBtn = "🌐 Lang: EN", colorBtn = "🎨 Change GUI Color",
        gp1 = "⚡ Fake x2 Cash", gp2 = "🏎️ Unlock Supercars", gp3 = "👑 Elite VIP Status",
        gpActive = "ACTIVATED (Visual)", statusTitle = "Car Status:"
    }
}

-- Главное Окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 360, 0, 340)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = colorThemes[currentThemeIdx]

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.SourceSansBold
Title.Text = translations[currentLang].title
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

-- Кнопка закрытия
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
CloseBtn.Position = UDim2.new(0.88, 0, 0, 7)
CloseBtn.Size = UDim2.new(0, 35, 0, 25)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Панель Вкладок (Табы)
local TabPanel = Instance.new("Frame")
TabPanel.Parent = MainFrame
TabPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TabPanel.Position = UDim2.new(0, 0, 0, 40)
TabPanel.Size = UDim2.new(1, 0, 0, 35)

local TabMainBtn = Instance.new("TextButton")
local TabFarmBtn = Instance.new("TextButton")
local TabPassBtn = Instance.new("TextButton")

local function StyleTabBtn(btn, pos, text)
    btn.Parent = TabPanel
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Position = pos
    btn.Size = UDim2.new(0.31, 0, 1, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 14
end

StyleTabBtn(TabMainBtn, UDim2.new(0.02, 0, 0, 0), translations[currentLang].tabMain)
StyleTabBtn(TabFarmBtn, UDim2.new(0.34, 0, 0, 0), translations[currentLang].tabFarm)
StyleTabBtn(TabPassBtn, UDim2.new(0.66, 0, 0, 0), translations[currentLang].tabPass)

-- Контейнеры для содержимого вкладок
local ContentMain = Instance.new("Frame")
local ContentFarm = Instance.new("Frame")
local ContentPass = Instance.new("Frame")

local function StyleContentFrame(f)
    f.Parent = MainFrame
    f.BackgroundTransparency = 1
    f.Position = UDim2.new(0, 0, 0, 75)
    f.Size = UDim2.new(1, 0, 1, -75)
    f.Visible = false
end
StyleContentFrame(ContentMain)
StyleContentFrame(ContentFarm)
StyleContentFrame(ContentPass)
ContentMain.Visible = true -- Стартовая вкладка
TabMainBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

-- ВКЛАДКА 1: ГЛАВНАЯ
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = ContentMain
StatusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
StatusLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
StatusLabel.Size = UDim2.new(0.9, 0, 0, 40)
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.Text = translations[currentLang].checking
StatusLabel.TextColor3 = Color3.fromRGB(241, 196, 15)
StatusLabel.TextSize = 16
local SC = Instance.new("UICorner") SC.CornerRadius = UDim.new(0, 6) SC.Parent = StatusLabel

local ChangeLangBtn = Instance.new("TextButton")
local ChangeColorBtn = Instance.new("TextButton")

local function StyleMenuBtn(btn, frame, pos, text)
    btn.Parent = frame
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.Position = pos
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 15
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = btn
end

StyleMenuBtn(ChangeLangBtn, ContentMain, UDim2.new(0.05, 0, 0.35, 0), translations[currentLang].langBtn)
StyleMenuBtn(ChangeColorBtn, ContentMain, UDim2.new(0.05, 0, 0.60, 0), translations[currentLang].colorBtn)

-- ВКЛАДКА 2: НАСТРОЙКИ АВТО-ФАРМА
local ToggleCashBtn = Instance.new("TextButton")
local ToggleQuestBtn = Instance.new("TextButton")
local TogglePlatBtn = Instance.new("TextButton")

StyleMenuBtn(ToggleCashBtn, ContentFarm, UDim2.new(0.05, 0, 0.05, 0), translations[currentLang].farmOff)
StyleMenuBtn(ToggleQuestBtn, ContentFarm, UDim2.new(0.05, 0, 0.30, 0), translations[currentLang].questOff)
StyleMenuBtn(TogglePlatBtn, ContentFarm, UDim2.new(0.05, 0, 0.55, 0), translations[currentLang].platOff)

-- ВКЛАДКА 3: БЕСПЛАТНЫЕ ГЕЙМПАССЫ (ВИЗУАЛ ХАК)
local Gp1Btn = Instance.new("TextButton")
local Gp2Btn = Instance.new("TextButton")
local Gp3Btn = Instance.new("TextButton")

StyleMenuBtn(Gp1Btn, ContentPass, UDim2.new(0.05, 0, 0.05, 0), translations[currentLang].gp1)
StyleMenuBtn(Gp2Btn, ContentPass, UDim2.new(0.05, 0, 0.30, 0), translations[currentLang].gp2)
StyleMenuBtn(Gp3Btn, ContentPass, UDim2.new(0.05, 0, 0.55, 0), translations[currentLang].gp3)

-- Функция переключения вкладок
local function SwitchTab(activeContent, activeBtn)
    ContentMain.Visible = false
    ContentFarm.Visible = false
    ContentPass.Visible = false
    TabMainBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabFarmBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabPassBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    
    activeContent.Visible = true
    activeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
end

TabMainBtn.MouseButton1Click:Connect(function() SwitchTab(ContentMain, TabMainBtn) end)
TabFarmBtn.MouseButton1Click:Connect(function() SwitchTab(ContentFarm, TabFarmBtn) end)
TabPassBtn.MouseButton1Click:Connect(function() SwitchTab(ContentPass, TabPassBtn) end)

-- Перевод текстов при смене языка
local function UpdateLocalization()
    Title.Text = translations[currentLang].title
    TabMainBtn.Text = translations[currentLang].tabMain
    TabFarmBtn.Text = translations[currentLang].tabFarm
    TabPassBtn.Text = translations[currentLang].tabPass
    ChangeLangBtn.Text = translations[currentLang].langBtn
    ChangeColorBtn.Text = translations[currentLang].colorBtn
    
    ToggleCashBtn.Text = SafeCash and translations[currentLang].farmOn or translations[currentLang].farmOff
    ToggleQuestBtn.Text = SafeQuests and translations[currentLang].questOn or translations[currentLang].questOff
    TogglePlatBtn.Text = AutoPlatinum and translations[currentLang].platOn or translations[currentLang].platOff
    
    if not Gp1Btn.Active then Gp1Btn.Text = translations[currentLang].gp1 end
    if not Gp2Btn.Active then Gp2Btn.Text = translations[currentLang].gp2 end
    if not Gp3Btn.Active then Gp3Btn.Text = translations[currentLang].gp3 end
end

-- Смена языка
ChangeLangBtn.MouseButton1Click:Connect(function()
    currentLang = (currentLang == "RU") and "EN" or "RU"
    UpdateLocalization()
end)

-- ЖЕЛЕЗНАЯ СМЕНА ЦВЕТА ИНТЕРФЕЙСА
ChangeColorBtn.MouseButton1Click:Connect(function()
    currentThemeIdx = currentThemeIdx + 1
    if currentThemeIdx > #colorThemes then currentThemeIdx = 1 end
    
    local targetColor = colorThemes[currentThemeIdx]
    MainFrame.BorderColor3 = targetColor
    
    -- Окрашиваем активные кнопки автофарма в цвет темы, если они включены
    if SafeCash then ToggleCashBtn.BackgroundColor3 = targetColor end
    if SafeQuests then ToggleQuestBtn.BackgroundColor3 = targetColor end
    if AutoPlatinum then TogglePlatBtn.BackgroundColor3 = targetColor end
end)

-- Логика проверки нахождения в машине
local function IsInCar()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        if character.Humanoid.SeatPart and character.Humanoid.SeatPart:IsA("VehicleSeat") then
            return true
        end
    end
    return false
end

-- Постоянное обновление статуса машины
task.spawn(function()
    while task.wait(0.4) do
        if not ScreenGui.Parent then break end
        if IsInCar() then
            StatusLabel.Text = translations[currentLang].inCar
            StatusLabel.TextColor3 = Color3.fromRGB(46, 204, 113)
        else
            StatusLabel.Text = translations[currentLang].notInCar
            StatusLabel.TextColor3 = Color3.fromRGB(231, 76, 60)
        end
    end
end)

-- Функция покраски кнопок при вкл/выкл
local function ToggleButtonState(btn, state, txtOn, txtOff)
    if state then
        btn.BackgroundColor3 = colorThemes[currentThemeIdx]
        btn.Text = txtOn
    else
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        btn.Text = txtOff
    end
end

-- ЛОГИКА: Автофарм Денег
ToggleCashBtn.MouseButton1Click:Connect(function()
    SafeCash = not SafeCash
    ToggleButtonState(ToggleCashBtn, SafeCash, translations[currentLang].farmOn, translations[currentLang].farmOff)
    
    if SafeCash then
        task.spawn(function()
            while SafeCash do
                if IsInCar() then
                    pcall(function()
                        local player = game.Players.LocalPlayer
                        local car = workspace.CarFolder:FindFirstChild(player.Name)
                        if car and car:FindFirstChild("Body") then
                            for _, part in pairs(car:GetChildren()) do
                                if part:IsA("BasePart") then
                                    part.Velocity = Vector3.new(0, -42, 0)
                                end
                            end
                        end
                    end)
                end
                task.wait(3.4)
            end
        end)
    end
end)

-- ЛОГИКА: Авто-Квесты
ToggleQuestBtn.MouseButton1Click:Connect(function()
    SafeQuests = not SafeQuests
    ToggleButtonState(ToggleQuestBtn, SafeQuests, translations[currentLang].questOn, translations[currentLang].questOff)
    
    if SafeQuests then
        task.spawn(function()
            while SafeQuests do
                pcall(function()
                    game:GetService("ReplicatedStorage").NetworkRemote:Get("ClaimQuestReward"):FireServer()
                end)
                task.wait(math.random(15, 22))
            end
        end)
    end
end)

-- ЛОГИКА: АВТО-ПЛАТИНА
TogglePlatBtn.MouseButton1Click:Connect(function()
    AutoPlatinum = not AutoPlatinum
    ToggleButtonState(TogglePlatBtn, AutoPlatinum, translations[currentLang].platOn, translations[currentLang].platOff)
    
    if AutoPlatinum then
        task.spawn(function()
            while AutoPlatinum do
                if IsInCar() then
                    pcall(function()
                        -- Отсылаем сигнал на сервер об уничтожении детали машины на максимальной скорости для триггера Платины
                        local args = { [1] = "VehicleCrushed", [2] = true, [3] = "PlatinumReward" }
                        game:GetService("ReplicatedStorage").NetworkRemote:Get("ExplosionSparks"):FireServer(unpack(args))
                    end)
                end
                task.wait(2.5) -- Оптимальная безопасная задержка для платиновых наград
            end
        end)
    end
end)

-- ЛОГИКА: ВЗЛОМ ГЕЙМПАССОВ (ФЕЙК-АКТИВАЦИЯ)
local function ActivateFakePass(btn)
    btn.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
    btn.Text = translations[currentLang].gpActive
    btn.Active = false -- Отключаем повторные нажатия
end

Gp1Btn.MouseButton1Click:Connect(function()
    ActivateFakePass(Gp1Btn)
    pcall(function()
        -- Эмуляция наличия пропуска на стороне клиента
        game.Players.LocalPlayer:SetAttribute("DoubleCashPass", true)
        game.Players.LocalPlayer:SetAttribute("HasDoubleCash", true)
    end)
end)

Gp2Btn.MouseButton1Click:Connect(function()
    ActivateFakePass(Gp2Btn)
    pcall(function()
        game.Players.LocalPlayer:SetAttribute("SupercarsPass", true)
        game.Players.LocalPlayer:SetAttribute("OwnsSupercars", true)
        -- Визуально разблокируем скрытые кнопки в автосалоне игры
        if game.Players.LocalPlayer.PlayerGui:FindFirstChild("CarDealership") then
            for _, v in pairs(game.Players.LocalPlayer.PlayerGui.CarDealership:GetDescendants()) do
                if v:IsA("Frame") and (v.Name == "Lock" or v.Name == "GamepassLock") then
                    v.Visible = false
                end
            end
        end
    end)
end)

Gp3Btn.MouseButton1Click:Connect(function()
    ActivateFakePass(Gp3Btn)
    pcall(function()
        game.Players.LocalPlayer:SetAttribute("EliteStatus", true)
        game.Players.LocalPlayer:SetAttribute("IsVIP", true)
    end)
end)
