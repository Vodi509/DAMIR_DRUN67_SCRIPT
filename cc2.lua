-- [[ DAMIR_DRUN67 SCRIPT v4 - ADVANCED MOBILE EDITION ]] --

if game.CoreGui:FindFirstChild("DamirScriptGui") then
    game.CoreGui.DamirScriptGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DamirScriptGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Настройки языков (Локализация)
local currentLang = "RU" -- По умолчанию Русский
local translations = {
    RU = {
        title = "🛡️ DAMIR_DRUN67 SCRIPT v4",
        inCar = "🚗 Вы в машине",
        notInCar = "❌ Вы не в машине",
        checking = "Проверка...",
        farmOn = "💰 Авто-Фарм Денег: ВКЛ",
        farmOff = "💰 Авто-Фарм Денег: ВЫКЛ",
        questOn = "📜 Авто-Квесты: ВКЛ",
        questOff = "📜 Авто-Квесты: ВЫКЛ",
        langBtn = "🌐 Язык: RU",
        colorBtn = "🎨 Сменить цвет темы"
    },
    EN = {
        title = "🛡️ DAMIR_DRUN67 SCRIPT v4",
        inCar = "🚗 You in the car",
        notInCar = "❌ You not in the car",
        checking = "Checking...",
        farmOn = "💰 Auto-Farm Cash: ON",
        farmOff = "💰 Auto-Farm Cash: OFF",
        questOn = "📜 Auto-Quests: ON",
        questOff = "📜 Auto-Quests: OFF",
        langBtn = "🌐 Lang: EN",
        colorBtn = "🎨 Change GUI Color"
    }
}

-- Палитра цветов для смены тем (Neon Cyan, Emerald Green, Ruby Red, Gold Amber)
local colorThemes = {
    Color3.fromRGB(0, 170, 255),
    Color3.fromRGB(46, 204, 113),
    Color3.fromRGB(231, 76, 60),
    Color3.fromRGB(241, 196, 15)
}
local currentThemeIdx = 1

-- Создание элементов интерфейса
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")
local ToggleCashBtn = Instance.new("TextButton")
local ToggleQuestBtn = Instance.new("TextButton")
local ChangeLangBtn = Instance.new("TextButton")
local ChangeColorBtn = Instance.new("TextButton")

-- Главное окно
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 340, 0, 310)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = colorThemes[currentThemeIdx]

-- Скругление углов для красоты
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Заголовок
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.SourceSansBold
Title.Text = translations[currentLang].title
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

-- Кнопка закрытия
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
CloseBtn.Position = UDim2.new(0.86, 0, 0, 7)
CloseBtn.Size = UDim2.new(0, 35, 0, 25)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Статус бар
StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
StatusLabel.Position = UDim2.new(0.05, 0, 0.16, 0)
StatusLabel.Size = UDim2.new(0.9, 0, 0, 35)
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.Text = translations[currentLang].checking
StatusLabel.TextColor3 = Color3.fromRGB(241, 196, 15)
StatusLabel.TextSize = 16
local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 6)
StatusCorner.Parent = StatusLabel

-- Функции обновления текстов интерфейса
local SafeCash = false
local SafeQuests = false

local function UpdateLocalization()
    Title.Text = translations[currentLang].title
    ChangeLangBtn.Text = translations[currentLang].langBtn
    ChangeColorBtn.Text = translations[currentLang].colorBtn
    
    if SafeCash then
        ToggleCashBtn.Text = translations[currentLang].farmOn
    else
        ToggleCashBtn.Text = translations[currentLang].farmOff
    end
    
    if SafeQuests then
        ToggleQuestBtn.Text = translations[currentLang].questOn
    else
        ToggleQuestBtn.Text = translations[currentLang].questOff
    end
end

-- Кнопки управления (Автофарм, Квесты)
local function CreateStyledButton(btn, pos, text, color)
    btn.Parent = MainFrame
    btn.BackgroundColor3 = color
    btn.Position = pos
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 15
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
end

CreateStyledButton(ToggleCashBtn, UDim2.new(0.05, 0, 0.32, 0), translations[currentLang].farmOff, Color3.fromRGB(50, 50, 50))
CreateStyledButton(ToggleQuestBtn, UDim2.new(0.05, 0, 0.48, 0), translations[currentLang].questOff, Color3.fromRGB(50, 50, 50))
CreateStyledButton(ChangeLangBtn, UDim2.new(0.05, 0, 0.64, 0), translations[currentLang].langBtn, Color3.fromRGB(45, 52, 54))
CreateStyledButton(ChangeColorBtn, UDim2.new(0.05, 0, 0.80, 0), translations[currentLang].colorBtn, Color3.fromRGB(45, 52, 54))

-- Переключение Языка
ChangeLangBtn.MouseButton1Click:Connect(function()
    currentLang = (currentLang == "RU") and "EN" or "RU"
    UpdateLocalization()
end)

-- Переключение Цвета Рамки (Тема)
ChangeColorBtn.MouseButton1Click:Connect(function()
    currentThemeIdx = currentThemeIdx + 1
    if currentThemeIdx > #colorThemes then currentThemeIdx = 1 end
    MainFrame.BorderColor3 = colorThemes[currentThemeIdx]
end)

-- Проверка нахождения персонажа в машине
local function IsInCar()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        if character.Humanoid.SeatPart and character.Humanoid.SeatPart:IsA("VehicleSeat") then
            return true
        end
    end
    return false
end

-- Фоновое отслеживание машины
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

-- Работа автофарма денег
ToggleCashBtn.MouseButton1Click:Connect(function()
    SafeCash = not SafeCash
    if SafeCash then
        ToggleCashBtn.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
    else
        ToggleCashBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
    UpdateLocalization()
    
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

-- Работа автофарма квестов
ToggleQuestBtn.MouseButton1Click:Connect(function()
    SafeQuests = not SafeQuests
    if SafeQuests then
        ToggleQuestBtn.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
    else
        ToggleQuestBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
    UpdateLocalization()
    
    if SafeQuests then
        task.spawn(function()
            while SafeQuests do
                pcall(function()
                    game:GetService("ReplicatedStorage").NetworkRemote:Get("ClaimQuestReward"):FireServer()
                end)
                task.wait(math.random(14, 24))
            end
        end)
    end
end)
