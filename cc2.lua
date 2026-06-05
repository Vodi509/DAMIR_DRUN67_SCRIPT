-- [[ DAMIR_DRUN67 SPEEDHACK UI & INTELLIGENT AUTOFARM v8 ]] --
-- Умный обход обучения, авто-определение крашеров и сворачивание в кота "1000032855.jpg"

if game.CoreGui:FindFirstChild("DamirSpeedhackGui") then
    game.CoreGui.DamirSpeedhackGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DamirSpeedhackGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Глобальные переменные
local currentLang = "RU"
local currentThemeIdx = 1
local SafeCash = false
local SafeQuests = false
local AutoPlatinum = false

-- Изображение кота из файла 1000032855.jpg (Загружено в Roblox как Asset ID для корректного отображения)
local CatImageId = "rbxassetid://18314115147" -- Кастомный ассет-декаль с этим котом

-- Цветовые схемы в стиле SPEEDHACK (Черные рамки контролируются отдельно)
local themes = {
    {accent = Color3.fromRGB(0, 255, 136), bg = Color3.fromRGB(10, 12, 11), panel = Color3.fromRGB(18, 22, 20)},  -- Acid Green
    {accent = Color3.fromRGB(0, 213, 255), bg = Color3.fromRGB(9, 11, 14),  panel = Color3.fromRGB(15, 19, 24)},  -- Neon Cyan
    {accent = Color3.fromRGB(255, 0, 85),  bg = Color3.fromRGB(14, 9, 10),  panel = Color3.fromRGB(24, 15, 17)},  -- Cyber Pink
    {accent = Color3.fromRGB(255, 170, 0), bg = Color3.fromRGB(12, 11, 9),  panel = Color3.fromRGB(22, 19, 15)}   -- Overdrive Orange
}

local dict = {
    RU = {
        title = "⚡ SPEEDHACK CC2 MULTIHACK v8",
        statusChecking = "🔍 Оценка вашего профиля...",
        statusTutorial = "⚠️ Пропускаем обучение CC2...",
        statusNewbie = "🔰 Режим: Новичок (Доступен Пресс №1)",
        statusPro = "🔥 Режим: Профи (Доступны все Крашеры)",
        farmOn = "💰 КИБЕР-ФАРМ: АКТИВЕН", farmOff = "💰 КИБЕР-ФАРМ: ВЫКЛЮЧЕН",
        questOn = "📜 КВЕСТ-ХАК: АКТИВЕН", questOff = "📜 КВЕСТ-ХАК: ВЫКЛЮЧЕН",
        platOn = "💎 ПЛАТИНА-ФАРМ: АКТИВЕН", platOff = "💎 ПЛАТИНА-ФАРМ: ВЫКЛЮЧЕН",
        btnLang = "🌐 ЯЗЫК: RU", btnColor = "🎨 СМЕНИТЬ НЕОН",
        gpActive = "ОБХОД ВЫПОЛНЕН"
    },
    EN = {
        title = "⚡ SPEEDHACK CC2 MULTIHACK v8",
        statusChecking = "🔍 Evaluating your profile...",
        statusTutorial = "⚠️ Skipping CC2 Tutorial...",
        statusNewbie = "🔰 Mode: Newbie (Crusher #1 Only)",
        statusPro = "🔥 Mode: Pro (All Crushers Unlocked)",
        farmOn = "💰 CYBER-FARM: ACTIVE", farmOff = "💰 CYBER-FARM: DISABLED",
        questOn = "📜 QUEST-HACK: ACTIVE", questOff = "📜 QUEST-HACK: DISABLED",
        platOn = "💎 PLATINUM-FARM: ACTIVE", platOff = "💎 PLATINUM-FARM: DISABLED",
        btnLang = "🌐 LANG: EN", btnColor = "🎨 SHIFT NEON COLOR",
        gpActive = "BYPASS SUCCESS"
    }
}

-- ГЛАВНОЕ ОКНО ИНТЕРФЕЙСА
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 440, 0, 310)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0) -- Черная обводка SPEEDHACK

-- Стилизация под хакерский интерфейс (Тонкие неоновые внутренние линии)
local NeonGlow = Instance.new("UIStroke")
NeonGlow.Thickness = 1.5
NeonGlow.ApplyStrokeMode = Enum.StrokeMode.Border
NeonGlow.Parent = MainFrame

-- Заголовок
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BorderSizePixel = 1
Header.BorderColor3 = Color3.fromRGB(0, 0, 0)

local HeaderGlow = Instance.new("UIStroke")
HeaderGlow.Thickness = 1
HeaderGlow.Parent = Header

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = Header
TitleLabel.Size = UDim2.new(0.8, 0, 1, 0)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.Font = Enum.Font.RobotoMono
TitleLabel.Text = dict[currentLang].title
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.BackgroundTransparency = 1

-- Кнопка Свернуть (Превращается в кота 1000032855.jpg)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = Header
MinimizeBtn.Position = UDim2.new(1, -30, 0, 6)
MinimizeBtn.Size = UDim2.new(0, 22, 0, 22)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 14
MinimizeBtn.BorderSizePixel = 1
MinimizeBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)

-- ИКОНКА КОТА ДЛЯ РАЗВЕРТЫВАНИЯ (Из файла 1000032855.jpg)
local CatShortcut = Instance.new("ImageButton")
CatShortcut.Name = "CatShortcut"
CatShortcut.Parent = ScreenGui
CatShortcut.Size = UDim2.new(0, 75, 0, 115) -- Пропорции кота со стулом
CatShortcut.Position = UDim2.new(0.05, 0, 0.4, 0)
CatShortcut.Image = CatImageId
CatShortcut.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CatShortcut.BorderSizePixel = 2
CatShortcut.BorderColor3 = Color3.fromRGB(0, 0, 0) -- Черная обводка кота
CatShortcut.Visible = false
CatShortcut.Active = true
CatShortcut.Draggable = true -- Кота можно двигать по экрану!

local CatGlow = Instance.new("UIStroke")
CatGlow.Thickness = 2
CatGlow.Parent = CatShortcut

-- Контейнер контента
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.Position = UDim2.new(0, 10, 0, 45)
ContentFrame.Size = UDim2.new(1, -20, 1, -55)
ContentFrame.BackgroundTransparency = 1

-- Информационная панель статуса прокачки
local StatusPanel = Instance.new("TextLabel")
StatusPanel.Parent = ContentFrame
StatusPanel.Size = UDim2.new(1, 0, 0, 32)
StatusPanel.Font = Enum.Font.RobotoMono
StatusPanel.Text = dict[currentLang].statusChecking
StatusPanel.TextSize = 12
StatusPanel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusPanel.BorderSizePixel = 1
StatusPanel.BorderColor3 = Color3.fromRGB(0, 0, 0)

local StatusGlow = Instance.new("UIStroke")
StatusGlow.Thickness = 1
StatusGlow.Parent = StatusPanel

-- Функция для быстрой сборки кнопок в стиле хакерских утилит
local function AddSpeedButton(btn, text, pos)
    btn.Parent = ContentFrame
    btn.Position = pos
    btn.Size = UDim2.new(0.48, 0, 0, 42)
    btn.Font = Enum.Font.RobotoMono
    btn.Text = text
    btn.TextSize = 12
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.fromRGB(0, 0, 0) -- Обязательный черный контур
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Parent = btn
end

local BtnFarm = Instance.new("TextButton") AddSpeedButton(BtnFarm, dict[currentLang].farmOff, UDim2.new(0, 0, 0, 45))
local BtnQuest = Instance.new("TextButton") AddSpeedButton(BtnQuest, dict[currentLang].questOff, UDim2.new(0.52, 0, 0, 45))
local BtnPlat = Instance.new("TextButton") AddSpeedButton(BtnPlat, dict[currentLang].platOff, UDim2.new(0, 0, 0, 95))
local BtnLang = Instance.new("TextButton") AddSpeedButton(BtnLang, dict[currentLang].btnLang, UDim2.new(0.52, 0, 0, 95))
local BtnColor = Instance.new("TextButton") AddSpeedButton(BtnColor, dict[currentLang].btnColor, UDim2.new(0, 0, 0, 145))

-- СИСТЕМА ИЗМЕНЕНИЯ ЦВЕТА ИНТЕРФЕЙСА (ПОЛНАЯ СИНХРОНИЗАЦИЯ)
local function UpdateSpeedhackTheme()
    local t = themes[currentThemeIdx]
    
    -- Весь фон интерфейса меняется вместе с кнопками
    MainFrame.BackgroundColor3 = t.bg
    Header.BackgroundColor3 = t.panel
    StatusPanel.BackgroundColor3 = t.panel
    
    -- Обводки (Неоновое свечение элементов)
    NeonGlow.Color = t.accent
    HeaderGlow.Color = t.accent
    StatusGlow.Color = t.accent
    CatGlow.Color = t.accent
    
    -- Раскраска переключателей читов
    local function SetBtnTheme(b, state)
        b.BackgroundColor3 = state and t.accent or t.panel
        b.TextColor3 = state and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
        b:FindFirstChildOfClass("UIStroke").Color = state and Color3.fromRGB(0, 0, 0) or t.accent
    end
    
    SetBtnTheme(BtnFarm, SafeCash)
    SetBtnTheme(BtnQuest, SafeQuests)
    SetBtnTheme(BtnPlat, AutoPlatinum)
    SetBtnTheme(BtnLang, false)
    SetBtnTheme(BtnColor, false)
end

-- ЛОГИКА СВЕРТЫВАНИЯ В КОТА (1000032855.jpg)
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    CatShortcut.Visible = true -- Появляется кот на стуле!
end)

CatShortcut.MouseButton1Click:Connect(function()
    CatShortcut.Visible = false
    MainFrame.Visible = true -- Интерфейс возвращается!
end)

-- УМНЫЙ ДЕТЕКТОР ПРОГРЕССА (Обучение, Уровень, Крашеры)
local isNewbie = true
local function ScanPlayerProgress()
    local localPlayer = game.Players.LocalPlayer
    
    -- 1. Проверяем и пропускаем обучение (Tutorial Bypass)
    local tutorialGui = localPlayer.PlayerGui:FindFirstChild("TutorialGui") or localPlayer.PlayerGui:FindFirstChild("Tutorial")
    if tutorialGui and tutorialGui.Enabled then
        StatusPanel.Text = dict[currentLang].statusTutorial
        StatusPanel.TextColor3 = Color3.fromRGB(255, 170, 0)
        pcall(function()
            local remote = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") or game:GetService("ReplicatedStorage"):FindFirstChild("NetworkRemote")
            if remote then
                -- Отправляем серверу пакет об успешном завершении туториала
                local skipEvent = remote:FindFirstChild("SkipTutorial") or remote:FindFirstChild("CompleteTutorial")
                if skipEvent then skipEvent:FireServer() end
            end
            tutorialGui.Enabled = false
        end)
        task.wait(1)
    end

    -- 2. Считаем уровень и крашеры через лидерстатс
    local stats = localPlayer:FindFirstChild("leaderstats")
    if stats then
        local lvl = stats:FindFirstChild("Level") or stats:FindFirstChild("Уровень")
        if lvl and lvl.Value >= 5 then
            isNewbie = false
            StatusPanel.Text = dict[currentLang].statusPro
            StatusPanel.TextColor3 = Color3.fromRGB(0, 255, 136)
        else
            isNewbie = true
            StatusPanel.Text = dict[currentLang].statusNewbie
            StatusPanel.TextColor3 = Color3.fromRGB(0, 213, 255)
        end
    else
        StatusPanel.Text = dict[currentLang].statusNewbie
    end
end

-- Обновление текстов
local function UpdateUIFields()
    TitleLabel.Text = dict[currentLang].title
    BtnLang.Text = dict[currentLang].btnLang
    BtnColor.Text = dict[currentLang].btnColor
    BtnFarm.Text = SafeCash and dict[currentLang].farmOn or dict[currentLang].farmOff
    BtnQuest.Text = SafeQuests and dict[currentLang].questOn or dict[currentLang].questOff
    BtnPlat.Text = AutoPlatinum and dict[currentLang].platOn or dict[currentLang].platOff
    ScanPlayerProgress()
end

BtnLang.MouseButton1Click:Connect(function()
    currentLang = (currentLang == "RU") and "EN" or "RU"
    UpdateUIFields()
end)

BtnColor.MouseButton1Click:Connect(function()
    currentThemeIdx = currentThemeIdx + 1
    if currentThemeIdx > #themes then currentThemeIdx = 1 end
    UpdateSpeedhackTheme()
end)

-- ФУНКЦИЯ НАХОЖДЕНИЯ МАШИНЫ
local function GetVehicle()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") and char.Humanoid.SeatPart then
        local seat = char.Humanoid.SeatPart
        if seat:IsA("VehicleSeat") then
            return seat.Parent
        end
    end
    return nil
end

-- ИНТЕЛЛЕКТУАЛЬНЫЙ АВТОФАРМ CC2 (Телепортация в активные зоны вместо пинков)
BtnFarm.MouseButton1Click:Connect(function()
    SafeCash = not SafeCash
    UpdateSpeedhackTheme()
    UpdateUIFields()
    
    if SafeCash then
        task.spawn(function()
            while SafeCash do
                local car = GetVehicle()
                if car and car:FindFirstChild("PrimaryPart") then
                    pcall(function()
                        -- Точки крашеров в зависимости от уровня
                        local targetCFrame = CFrame.new(-220, 40, 1080) -- Базовый супер-пресс для новичков
                        
                        if not isNewbie then
                            -- Для профи: выбираем огромный уничтожитель или блендер, приносящий x5 денег
                            local crushers = workspace:FindFirstChild("Crushers")
                            if crushers then
                                local heavyCrusher = crushers:FindFirstChild("Grand Crusher") or crushers:FindFirstChild("Super Blender")
                                if heavyCrusher and heavyCrusher:FindFirstChild("Base") then
                                    targetCFrame = heavyCrusher.Base.CFrame + Vector3.new(0, 5, 0)
                                end
                            end
                        end
                        
                        -- Стабильный перенос машины в эпицентр крушения
                        car.PrimaryPart.CFrame = targetCFrame
                        for _, part in pairs(car:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.Velocity = Vector3.new(0, -100, 0) -- Принудительное сильное раздавливание
                            end
                        end
                    end)
                end
                task.wait(3.0) -- Оптимальное время ожидания восстановления на спавне
            end
        end)
    end
end)

-- АВТО-КВЕСТЫ И ПЛАТИНА
BtnQuest.MouseButton1Click:Connect(function()
    SafeQuests = not SafeQuests
    UpdateSpeedhackTheme()
    UpdateUIFields()
    if SafeQuests then
        task.spawn(function()
            while SafeQuests do
                pcall(function()
                    local net = game:GetService("ReplicatedStorage"):FindFirstChild("NetworkRemote")
                    if net then net:FindFirstChild("ClaimQuestReward"):FireServer() end
                end)
                task.wait(8)
            end
        end)
    end
end)

BtnPlat.MouseButton1Click:Connect(function()
    AutoPlatinum = not AutoPlatinum
    UpdateSpeedhackTheme()
    UpdateUIFields()
    if AutoPlatinum then
        task.spawn(function()
            while AutoPlatinum do
                if GetVehicle() then
                    pcall(function()
                        local net = game:GetService("ReplicatedStorage"):FindFirstChild("NetworkRemote")
                        if net then net:FindFirstChild("VehicleCrushed"):FireServer(true, "PlatinumReward") end
                    end)
                end
                task.wait(2.5)
            end
        end)
    end
end)

-- Первичная инициализация
UpdateSpeedhackTheme()
task.spawn(function()
    while task.wait(5) do
        if not ScreenGui.Parent then break end
        ScanPlayerProgress()
    end
end)
