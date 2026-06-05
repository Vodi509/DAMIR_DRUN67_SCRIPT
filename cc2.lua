-- [[ DAMIR_DRUN67 ULTIMATE RESILIENT UI v10 ]] --
-- Защита от пропажи кнопок, конфликтов фармов и блокировок телепорта.

if game.CoreGui:FindFirstChild("DamirSpeedhackGui") then
    game.CoreGui.DamirSpeedhackGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DamirSpeedhackGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Состояния (Флаги)
local currentLang = "RU"
local currentThemeIdx = 1
local SafeCash = false
local SafeQuests = false
local AutoPlatinum = false
local isNewbie = true

local CatImageId = "rbxassetid://18314115147" -- Картинка кота

-- Стабильные цветовые схемы
local themes = {
    {accent = Color3.fromRGB(0, 255, 136), bg = Color3.fromRGB(15, 15, 15), panel = Color3.fromRGB(25, 25, 25)},
    {accent = Color3.fromRGB(0, 213, 255), bg = Color3.fromRGB(12, 15, 20), panel = Color3.fromRGB(22, 26, 35)}
}

local dict = {
    RU = {
        title = "⚡ DAMIR MULTIHACK v10",
        statusChecking = "🔍 Сканирование уровня...",
        statusNewbie = "🔰 Режим: Новичок (Пресс №1)",
        statusPro = "🔥 Режим: Профи (Макс. Крашер)",
        farmOn = "💰 ФАРМ ДЕНЕГ: [ВКЛ]", farmOff = "💰 ФАРМ ДЕНЕГ: ВЫКЛ",
        questOn = "📜 КВЕСТЫ: [ВКЛ]", questOff = "📜 КВЕСТЫ: ВЫКЛ",
        platOn = "💎 ПЛАТИНА: [ВКЛ]", platOff = "💎 ПЛАТИНА: ВЫКЛ",
        btnColor = "🎨 СМЕНИТЬ СТИЛЬ"
    },
    EN = {
        title = "⚡ DAMIR MULTIHACK v10",
        statusChecking = "🔍 Checking Level...",
        statusNewbie = "🔰 Mode: Newbie (Crusher #1)",
        statusPro = "🔥 Mode: Pro (Max Crusher)",
        farmOn = "💰 CASH FARM: [ON]", farmOff = "💰 CASH FARM: OFF",
        questOn = "📜 QUESTS: [ON]", questOff = "📜 QUESTS: OFF",
        platOn = "💎 PLATINUM: [ON]", platOff = "💎 PLATINUM: OFF",
        btnColor = "🎨 SHIFT COLOR"
    }
}

-- ГЛАВНОЕ ОКНО (Адаптивное, не ломает рендеринг)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 380, 0, 290)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)

-- Шапка
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BorderSizePixel = 1
Header.BorderColor3 = Color3.fromRGB(0, 0, 0)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = Header
TitleLabel.Size = UDim2.new(0.8, 0, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.Font = Enum.Font.Code
TitleLabel.Text = dict[currentLang].title
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.BackgroundTransparency = 1

-- Кнопка Свернуть
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = Header
MinimizeBtn.Position = UDim2.new(1, -32, 0, 5)
MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.BorderSizePixel = 1
MinimizeBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)

-- Аватарка Кота (Разворот)
local CatShortcut = Instance.new("ImageButton")
CatShortcut.Name = "CatShortcut"
CatShortcut.Parent = ScreenGui
CatShortcut.Size = UDim2.new(0, 65, 0, 95)
CatShortcut.Position = UDim2.new(0.02, 0, 0.4, 0)
CatShortcut.Image = CatImageId
CatShortcut.BorderSizePixel = 2
CatShortcut.Visible = false
CatShortcut.Active = true
CatShortcut.Draggable = true

-- Монитор статуса
local StatusPanel = Instance.new("TextLabel")
StatusPanel.Parent = MainFrame
StatusPanel.Position = UDim2.new(0, 10, 0, 45)
StatusPanel.Size = UDim2.new(1, -20, 0, 30)
StatusPanel.Font = Enum.Font.Code
StatusPanel.Text = dict[currentLang].statusChecking
StatusPanel.TextSize = 12
StatusPanel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusPanel.BorderSizePixel = 1
StatusPanel.BorderColor3 = Color3.fromRGB(0, 0, 0)

-- ЗАЩИТА ОТ ПРОПАЖИ КНОПОК: Автоматическое выравнивание списком
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Parent = MainFrame
ButtonContainer.Position = UDim2.new(0, 10, 0, 85)
ButtonContainer.Size = UDim2.new(1, -20, 1, -95)
ButtonContainer.BackgroundTransparency = 1

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ButtonContainer
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6) -- Жесткий отступ, кнопки никогда не наползут друг на друга

local function CreateSafeButton(text, order)
    local btn = Instance.new("TextButton")
    btn.Parent = ButtonContainer
    btn.Size = UDim2.new(1, 0, 0, 36) -- Кнопка растягивается по ширине контейнера
    btn.Font = Enum.Font.Code
    btn.Text = text
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    btn.LayoutOrder = order
    return btn
end

local BtnFarm = CreateSafeButton(dict[currentLang].farmOff, 1)
local BtnPlat = CreateSafeButton(dict[currentLang].platOff, 2)
local BtnQuest = CreateSafeButton(dict[currentLang].questOff, 3)
local BtnColor = CreateSafeButton(dict[currentLang].btnColor, 4)

-- Обновление тем
local function ApplyTheme()
    local t = themes[currentThemeIdx]
    MainFrame.BackgroundColor3 = t.bg
    Header.BackgroundColor3 = t.panel
    StatusPanel.BackgroundColor3 = t.panel
    CatShortcut.BorderColor3 = t.accent
    
    local function Style(b, active)
        b.BackgroundColor3 = active and t.accent or t.panel
        b.TextColor3 = active and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
    end
    
    Style(BtnFarm, SafeCash)
    Style(BtnPlat, AutoPlatinum)
    Style(BtnQuest, SafeQuests)
    Style(BtnColor, false)
end

-- Логика переключения окон
MinimizeBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; CatShortcut.Visible = true end)
CatShortcut.MouseButton1Click:Connect(function() CatShortcut.Visible = false; MainFrame.Visible = true end)

-- Проверка игрока
local function UpdatePlayerStatus()
    pcall(function()
        local lp = game.Players.LocalPlayer
        local stats = lp:FindFirstChild("leaderstats")
        local lvl = stats and (stats:FindFirstChild("Level") or stats:FindFirstChild("Уровень"))
        if lvl and lvl.Value >= 4 then
            isNewbie = false
            StatusPanel.Text = dict[currentLang].statusPro
        else
            isNewbie = true
            StatusPanel.Text = dict[currentLang].statusNewbie
        end
    end)
end

local function UpdateButtonTexts()
    BtnFarm.Text = SafeCash and dict[currentLang].farmOn or dict[currentLang].farmOff
    BtnPlat.Text = AutoPlatinum and dict[currentLang].platOn or dict[currentLang].platOff
    BtnQuest.Text = SafeQuests and dict[currentLang].questOn or dict[currentLang].questOff
    UpdatePlayerStatus()
end

-- Ротация стилей
BtnColor.MouseButton1Click:Connect(function()
    currentThemeIdx = (currentThemeIdx == 1) and 2 or 1
    ApplyTheme()
end)

-- Поиск и авто-спавн машины (Перебор вариантов)
local function GuaranteeVehicle()
    local lp = game.Players.LocalPlayer
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        local seat = lp.Character.Humanoid.SeatPart
        if seat and seat:IsA("VehicleSeat") and seat.Parent then
            return seat.Parent
        end
    end
    
    -- Вариант: Попытка заспавнить машину через удаленный вызов
    pcall(function()
        local remote = game:GetService("ReplicatedStorage"):FindFirstChild("NetworkRemote")
        local spawnCar = remote and remote:FindFirstChild("SpawnVehicle")
        if spawnCar then
            -- Перебираем ID машин от 1 до 5 (если первая не открыта)
            for i = 1, 5 do
                spawnCar:InvokeServer(i)
                task.wait(0.1)
                if lp.Character.Humanoid.SeatPart then break end
            end
        end
    end)
    return nil
end

-- ==========================================
-- УЛЬТИМАТИВНЫЙ ОДНОПОТОЧНЫЙ АВТОФАРМ (All-in-One)
-- ==========================================

-- Поток для Фарма Денег
task.spawn(function()
    while true do
        if SafeCash then
            local car = GuaranteeVehicle()
            if car and car:FindFirstChild("PrimaryPart") then
                pcall(function()
                    -- Точка назначения (Пресс)
                    local targetPos = CFrame.new(-222, 41, 1082)
                    if not isNewbie then
                        local cFolder = workspace:FindFirstChild("Crushers")
                        local best = cFolder and (cFolder:FindFirstChild("Grand Crusher") or cFolder:FindFirstChild("Super Blender"))
                        if best and best:FindFirstChild("Base") then targetPos = best.Base.CFrame + Vector3.new(0, 5, 0) end
                    end
                    
                    -- Метод 1: Прямой телепорт
                    car.PrimaryPart.CFrame = targetPos
                    
                    -- Метод 2: Импульс скорости вниз (симуляция падения)
                    for _, part in pairs(car:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.AssemblyLinearVelocity = Vector3.new(0, -100, 0)
                        end
                    end
                end)
            else
                -- Метод 3: Если физическая машина не создалась, шлем сетевой пакет уничтожения напрямую
                pcall(function()
                    local net = game:GetService("ReplicatedStorage"):FindFirstChild("NetworkRemote")
                    if net and net:FindFirstChild("VehicleCrushed") then net.VehicleCrushed:FireServer(true) end
                end)
            end
        end
        task.wait(2.5) -- Оптимальная задержка от античита
    end
end)

-- Поток для Фарма Платины
task.spawn(function()
    while true do
        if AutoPlatinum then
            local car = GuaranteeVehicle()
            pcall(function()
                local net = game:GetService("ReplicatedStorage"):FindFirstChild("NetworkRemote")
                if net and net:FindFirstChild("VehicleCrushed") then 
                    net.VehicleCrushed:FireServer(true, "PlatinumReward") 
                end
             pcall(function()
                if car and car:FindFirstChild("PrimaryPart") then
                    car.PrimaryPart.CFrame = CFrame.new(0, -200, 0) -- Сброс под карту для гарантии триггера
                end
             end)
            end)
        end
        task.wait(2.2)
    end
end)

-- ВЗАИМОИСКЛЮЧЕНИЕ РЕЖИМОВ (Приоритет активации)
BtnFarm.MouseButton1Click:Connect(function()
    SafeCash = not SafeCash
    if SafeCash then 
        AutoPlatinum = false -- Отключаем платину, если включили деньги!
    end
    ApplyTheme()
    UpdateButtonTexts()
end)

BtnPlat.MouseButton1Click:Connect(function()
    AutoPlatinum = not AutoPlatinum
    if AutoPlatinum then 
        SafeCash = false -- Отключаем деньги, если включили платину!
    end
    ApplyTheme()
    UpdateButtonTexts()
end)

-- Поток авто-сбора наград за квесты
BtnQuest.MouseButton1Click:Connect(function()
    SafeQuests = not SafeQuests
    ApplyTheme()
    UpdateButtonTexts()
end)

task.spawn(function()
    while true do
        if SafeQuests then
            pcall(function()
                local net = game:GetService("ReplicatedStorage"):FindFirstChild("NetworkRemote")
                if net and net:FindFirstChild("ClaimQuestReward") then net.ClaimQuestReward:FireServer() end
            end)
        end
        task.wait(5)
    end
end)

-- Инициализация
ApplyTheme()
UpdateButtonTexts()
