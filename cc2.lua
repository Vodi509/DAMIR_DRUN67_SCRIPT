-- [[ DAMIR_DRUN67 UNIQUE CUSTOM UI & AUTOFARM v7 ]] --
-- Полностью собственный интерфейс без сторонних библиотек (Rayfield-Free)
-- Проверен на совместимость с Delta Executor (2026)

if game.CoreGui:FindFirstChild("DamirUniqueGui") then
    game.CoreGui.DamirUniqueGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DamirUniqueGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Глобальные состояния скрипта
local currentLang = "RU"
local currentThemeIdx = 1
local SafeCash = false
local SafeQuests = false
local AutoPlatinum = false

-- Уникальные кастомные палитры (1: Яркий акцент, 2: Глубокий фон меню, 3: Более темные панели)
local themes = {
    {accent = Color3.fromRGB(0, 180, 255),  bg = Color3.fromRGB(16, 22, 33),  panel = Color3.fromRGB(11, 15, 23)},  -- Кибер-Синий
    {accent = Color3.fromRGB(46, 204, 113), bg = Color3.fromRGB(16, 30, 22),  panel = Color3.fromRGB(10, 20, 14)},  -- Токсично-Зеленый
    {accent = Color3.fromRGB(231, 76, 60),  bg = Color3.fromRGB(30, 16, 16),  panel = Color3.fromRGB(20, 10, 10)},  -- Алый Импульс
    {accent = Color3.fromRGB(241, 196, 15), bg = Color3.fromRGB(30, 26, 15),  panel = Color3.fromRGB(20, 17, 10)},  -- Неоновый Янтарный
    {accent = Color3.fromRGB(155, 89, 182), bg = Color3.fromRGB(24, 16, 33),  panel = Color3.fromRGB(15, 10, 22)}   -- Спектрально-Фиолетовый
}

local dict = {
    RU = {
        title = "⚡ DAMIR CUSTOM UI v7",
        tabMain = "🏠 Главная", tabFarm = "⚙️ Автофарм", tabPass = "🎁 Геймпассы",
        carStatusIn = "🚗 Статус: Вы внутри транспорта", carStatusOut = "❌ Статус: Сядьте в машину",
        farmOn = "💰 Фарм Денег: АКТИВЕН", farmOff = "💰 Фарм Денег: ВЫКЛЮЧЕН",
        questOn = "📜 Авто-Квесты: АКТИВНЫ", questOff = "📜 Авто-Квесты: ВЫКЛЮЧЕНЫ",
        platOn = "💎 Фарм Платины: АКТИВЕН", platOff = "💎 Фарм Платины: ВЫКЛЮЧЕН",
        btnLang = "🌐 Сменить Язык: RU", btnColor = "🎨 Сменить Цвет Фона",
        gp1 = "⚡ Fake x2 Cash (Визуал)", gp2 = "🏎️ Unlock Supercars (Визуал)", gp3 = "👑 Elite VIP (Визуал)",
        gpDone = "УСПЕШНО АКТИВИРОВАНО"
    },
    EN = {
        title = "⚡ DAMIR CUSTOM UI v7",
        tabMain = "🏠 Home", tabFarm = "⚙️ Autofarm", tabPass = "🎁 Gamepasses",
        carStatusIn = "🚗 Status: Inside Vehicle", carStatusOut = "❌ Status: Not in vehicle",
        farmOn = "💰 Money Farm: ACTIVE", farmOff = "💰 Money Farm: DISABLED",
        questOn = "📜 Auto-Quests: ACTIVE", questOff = "📜 Auto-Quests: DISABLED",
        platOn = "💎 Platinum Farm: ACTIVE", platOff = "💎 Platinum Farm: DISABLED",
        btnLang = "🌐 Change Lang: EN", btnColor = "🎨 Change Interface Background",
        gp1 = "⚡ Fake x2 Cash (Visual)", gp2 = "🏎️ Unlock Supercars (Visual)", gp3 = "👑 Elite VIP (Visual)",
        gpDone = "SUCCESSFULLY ACTIVATED"
    }
}

-- Создание каркаса интерфейса (Drag-система)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0) -- Черная обводка всего окна

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Боковая панель для уникального расположения табов
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0, 130, 1, 0)
Sidebar.BorderSizePixel = 2
Sidebar.BorderColor3 = Color3.fromRGB(0, 0, 0) -- Черная обводка сайдбара

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 8)
SidebarCorner.Parent = Sidebar

-- Линия-заглушка для красивого скругления
local HideOverlap = Instance.new("Frame")
HideOverlap.Size = UDim2.new(0, 10, 1, 0)
HideOverlap.Position = UDim2.new(1, -10, 0, 0)
HideOverlap.BackgroundColor3 = Sidebar.BackgroundColor3
HideOverlap.BorderSizePixel = 0
HideOverlap.Parent = Sidebar

-- Главная рабочая область для контента
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Parent = MainFrame
Container.Position = UDim2.new(0, 135, 0, 45)
Container.Size = UDim2.new(1, -140, 1, -55)
Container.BackgroundTransparency = 1

-- Название скрипта в сайдбаре
local LogoLabel = Instance.new("TextLabel")
LogoLabel.Parent = Sidebar
LogoLabel.Size = UDim2.new(1, 0, 0, 45)
LogoLabel.Font = Enum.Font.SourceSansBold
LogoLabel.Text = "DAMIR SCRIPTS"
LogoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoLabel.TextSize = 15
LogoLabel.BackgroundTransparency = 1

-- Верхняя плашка названия
local TopHeader = Instance.new("TextLabel")
TopHeader.Parent = MainFrame
TopHeader.Position = UDim2.new(0, 135, 0, 0)
TopHeader.Size = UDim2.new(1, -135, 0, 40)
TopHeader.Font = Enum.Font.SourceSansBold
TopHeader.Text = dict[currentLang].title
TopHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
TopHeader.TextSize = 16
TopHeader.TextXAlignment = Enum.TextXAlignment.Left
TopHeader.BackgroundTransparency = 1

-- Кнопка закрытия оригинальной формы
local ExitButton = Instance.new("TextButton")
ExitButton.Parent = MainFrame
ExitButton.Position = UDim2.new(1, -30, 0, 8)
ExitButton.Size = UDim2.new(0, 22, 0, 22)
ExitButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ExitButton.Font = Enum.Font.SourceSansBold
ExitButton.Text = "×"
ExitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitButton.TextSize = 18
ExitButton.BorderSizePixel = 1
ExitButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
local ExitCorner = Instance.new("UICorner") ExitCorner.CornerRadius = UDim.new(0, 4) ExitCorner.Parent = ExitButton
ExitButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Создание табов (Кнопок переключения)
local TabMainBtn = Instance.new("TextButton")
local TabFarmBtn = Instance.new("TextButton")
local TabPassBtn = Instance.new("TextButton")

local function CreateTabNav(btn, text, pos)
    btn.Parent = Sidebar
    btn.Position = pos
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.fromRGB(0, 0, 0) -- Черная обводка кнопок навигации
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 5) c.Parent = btn
end

CreateTabNav(TabMainBtn, dict[currentLang].tabMain, UDim2.new(0.05, 0, 0, 55))
CreateTabNav(TabFarmBtn, dict[currentLang].tabFarm, UDim2.new(0.05, 0, 0, 95))
CreateTabNav(TabPassBtn, dict[currentLang].tabPass, UDim2.new(0.05, 0, 0, 135))

-- Элементы содержимого
local PageMain = Instance.new("Frame")
local PageFarm = Instance.new("Frame")
local PagePass = Instance.new("Frame")

local function SetupPage(p)
    p.Parent = Container
    p.Size = UDim2.new(1, 0, 1, 0)
    p.BackgroundTransparency = 1
    p.Visible = false
end
SetupPage(PageMain)
SetupPage(PageFarm)
SetupPage(PagePass)
PageMain.Visible = true

-- Стилизация функциональных кнопок с ОБЯЗАТЕЛЬНОЙ черной обводкой
local function BuildActionButton(btn, parent, text, pos)
    btn.Parent = parent
    btn.Position = pos
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.fromRGB(0, 0, 0) -- Черный контур кнопок
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = btn
end

-- PAGE 1: ГЛАВНАЯ
local VehicleMonitor = Instance.new("TextLabel")
VehicleMonitor.Parent = PageMain
VehicleMonitor.Size = UDim2.new(1, 0, 0, 38)
VehicleMonitor.Font = Enum.Font.SourceSansBold
VehicleMonitor.Text = dict[currentLang].carStatusOut
VehicleMonitor.TextSize = 14
VehicleMonitor.BorderSizePixel = 2
VehicleMonitor.BorderColor3 = Color3.fromRGB(0, 0, 0)
local VCorner = Instance.new("UICorner") VCorner.CornerRadius = UDim.new(0, 6) VCorner.Parent = VehicleMonitor

local LangAction = Instance.new("TextButton")
local ThemeAction = Instance.new("TextButton")
BuildActionButton(LangAction, PageMain, dict[currentLang].btnLang, UDim2.new(0, 0, 0, 50))
BuildActionButton(ThemeAction, PageMain, dict[currentLang].btnColor, UDim2.new(0, 0, 0, 100))

-- PAGE 2: АВТОФАРМ
local FarmCashAction = Instance.new("TextButton")
local FarmQuestAction = Instance.new("TextButton")
local FarmPlatAction = Instance.new("TextButton")
BuildActionButton(FarmCashAction, PageFarm, dict[currentLang].farmOff, UDim2.new(0, 0, 0, 0))
BuildActionButton(FarmQuestAction, PageFarm, dict[currentLang].questOff, UDim2.new(0, 0, 0, 50))
BuildActionButton(FarmPlatAction, PageFarm, dict[currentLang].platOff, UDim2.new(0, 0, 0, 100))

-- PAGE 3: ГЕЙМПАССЫ
local Gp1Action = Instance.new("TextButton")
local Gp2Action = Instance.new("TextButton")
local Gp3Action = Instance.new("TextButton")
BuildActionButton(Gp1Action, PagePass, dict[currentLang].gp1, UDim2.new(0, 0, 0, 0))
BuildActionButton(Gp2Action, PagePass, dict[currentLang].gp2, UDim2.new(0, 0, 0, 50))
BuildActionButton(Gp3Action, PagePass, dict[currentLang].gp3, UDim2.new(0, 0, 0, 100))

-- СИСТЕМА ДИНАМИЧЕСКИХ ОБНОВЛЕНИЙ ЦВЕТА И ТЕМЫ (ПОЛНАЯ СИНХРОНИЗАЦИЯ С ФОНОМ)
local function ApplyInterfaceTheme()
    local cTheme = themes[currentThemeIdx]
    
    -- Синхронно перекрашиваем все фоны окон!
    MainFrame.BackgroundColor3 = cTheme.bg
    Sidebar.BackgroundColor3 = cTheme.panel
    HideOverlap.BackgroundColor3 = cTheme.panel
    VehicleMonitor.BackgroundColor3 = cTheme.panel
    
    -- Сброс неактивных кнопок вкладок
    TabMainBtn.BackgroundColor3 = cTheme.panel
    TabFarmBtn.BackgroundColor3 = cTheme.panel
    TabPassBtn.BackgroundColor3 = cTheme.panel
    
    -- Подсвечиваем активную страницу в боковом меню
    if PageMain.Visible then TabMainBtn.BackgroundColor3 = cTheme.accent end
    if PageFarm.Visible then TabFarmBtn.BackgroundColor3 = cTheme.accent end
    if PagePass.Visible then TabPassBtn.BackgroundColor3 = cTheme.accent end
    
    -- Статичные служебные кнопки
    LangAction.BackgroundColor3 = cTheme.panel
    ThemeAction.BackgroundColor3 = cTheme.panel
    
    -- Переключатели автофарма: неоновый цвет если активны, темный цвет если выключены
    FarmCashAction.BackgroundColor3 = SafeCash and cTheme.accent or cTheme.panel
    FarmQuestAction.BackgroundColor3 = SafeQuests and cTheme.accent or cTheme.panel
    FarmPlatAction.BackgroundColor3 = AutoPlatinum and cTheme.accent or cTheme.panel
    
    -- Визуальные пассы
    Gp1Action.BackgroundColor3 = Gp1Action.Active and cTheme.panel or Color3.fromRGB(39, 174, 96)
    Gp2Action.BackgroundColor3 = Gp2Action.Active and cTheme.panel or Color3.fromRGB(39, 174, 96)
    Gp3Action.BackgroundColor3 = Gp3Action.Active and cTheme.panel or Color3.fromRGB(39, 174, 96)
end

local function RerenderText()
    TopHeader.Text = dict[currentLang].title
    TabMainBtn.Text = dict[currentLang].tabMain
    TabFarmBtn.Text = dict[currentLang].tabFarm
    TabPassBtn.Text = dict[currentLang].tabPass
    LangAction.Text = dict[currentLang].btnLang
    ThemeAction.Text = dict[currentLang].btnColor
    
    FarmCashAction.Text = SafeCash and dict[currentLang].farmOn or dict[currentLang].farmOff
    FarmQuestAction.Text = SafeQuests and dict[currentLang].questOn or dict[currentLang].questOff
    FarmPlatAction.Text = AutoPlatinum and dict[currentLang].platOn or dict[currentLang].platOff
    
    if not Gp1Action.Active then Gp1Action.Text = dict[currentLang].gpDone end
    if not Gp2Action.Active then Gp2Action.Text = dict[currentLang].gpDone end
    if not Gp3Action.Active then Gp3Action.Text = dict[currentLang].gpDone end
end

-- Логика вкладок
local function NavigateTo(targetPage)
    PageMain.Visible = false; PageFarm.Visible = false; PagePass.Visible = false
    targetPage.Visible = true
    ApplyInterfaceTheme()
end

TabMainBtn.MouseButton1Click:Connect(function() NavigateTo(PageMain) end)
TabFarmBtn.MouseButton1Click:Connect(function() NavigateTo(PageFarm) end)
TabPassBtn.MouseButton1Click:Connect(function() NavigateTo(PagePass) end)

-- Переключатели локализации и цветовой гаммы фона
LangAction.MouseButton1Click:Connect(function()
    currentLang = (currentLang == "RU") and "EN" or "RU"
    RerenderText()
end)

ThemeAction.MouseButton1Click:Connect(function()
    currentThemeIdx = currentThemeIdx + 1
    if currentThemeIdx > #themes then currentThemeIdx = 1 end
    ApplyInterfaceTheme()
end)

-- Валидация и проверка нахождения игрока в авто
local function GetCurrentVehicle()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        local seat = char.Humanoid.SeatPart
        if seat and seat:IsA("VehicleSeat") then
            local rootModel = seat
            while rootModel and rootModel ~= workspace do
                if rootModel:IsA("Model") and (rootModel:FindFirstChild("Body") or rootModel:FindFirstChild("Wheels") or rootModel.Name:lower():find("car")) then
                    return rootModel
                end
                rootModel = rootModel.Parent
            end
            return seat.Parent
        end
    end
    return nil
end

task.spawn(function()
    while task.wait(0.5) do
        if not ScreenGui.Parent then break end
        if GetCurrentVehicle() then
            VehicleMonitor.Text = dict[currentLang].carStatusIn
            VehicleMonitor.TextColor3 = Color3.fromRGB(46, 204, 113)
        else
            VehicleMonitor.Text = dict[currentLang].carStatusOut
            VehicleMonitor.TextColor3 = Color3.fromRGB(231, 76, 60)
        end
    end
end)

-- ИСПОЛНИТЕЛЬНЫЙ БЛОК АВТОФАРМА (БЕЗОПАСНАЯ СКОРОСТЬ + ПРОВЕРКА ОШИБОК)
FarmCashAction.MouseButton1Click:Connect(function()
    SafeCash = not SafeCash
    ApplyInterfaceTheme()
    RerenderText()
    
    if SafeCash then
        task.spawn(function()
            while SafeCash do
                local currentVehicle = GetCurrentVehicle()
                if currentVehicle then
                    pcall(function()
                        for _, p in pairs(currentVehicle:GetDescendants()) do
                            if p:IsA("BasePart") then
                                p.Velocity = Vector3.new(0, -48, 0) -- Стабильная скорость разрушения
                            end
                        end
                    end)
                end
                task.wait(2.7)
            end
        end)
    end
end)

FarmQuestAction.MouseButton1Click:Connect(function()
    SafeQuests = not SafeQuests
    ApplyInterfaceTheme()
    RerenderText()
    
    if SafeQuests then
        task.spawn(function()
            while SafeQuests do
                pcall(function()
                    local net = game:GetService("ReplicatedStorage"):FindFirstChild("NetworkRemote") or game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                    if net then
                        for _, r in pairs(net:GetDescendants()) do
                            if r:IsA("RemoteEvent") and (r.Name:lower():find("quest") or r.Name:lower():find("reward")) then
                                r:FireServer()
                            end
                        end
                    end
                end)
                task.wait(10)
            end
        end)
    end
end)

FarmPlatAction.MouseButton1Click:Connect(function()
    AutoPlatinum = not AutoPlatinum
    ApplyInterfaceTheme()
    RerenderText()
    
    if AutoPlatinum then
        task.spawn(function()
            while AutoPlatinum do
                if GetCurrentVehicle() then
                    pcall(function()
                        local net = game:GetService("ReplicatedStorage"):FindFirstChild("NetworkRemote") or game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                        if net then
                            for _, r in pairs(net:GetDescendants()) do
                                if r:IsA("RemoteEvent") and (r.Name:lower():find("crush") or r.Name:lower():find("damage")) then
                                    r:FireServer("VehicleCrushed", true, "PlatinumReward")
                                end
                            end
                        end
                    end)
                end
                task.wait(2.0)
            end
        end)
    end
end)

-- ФУНКЦИОНАЛ ПАССОВ (АКТИВАЦИЯ)
local function SetPassState(btn)
    btn.Text = dict[currentLang].gpDone
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Active = false
    ApplyInterfaceTheme()
end

Gp1Action.MouseButton1Click:Connect(function()
    SetPassState(Gp1Action)
    pcall(function()
        game.Players.LocalPlayer:SetAttribute("DoubleCashPass", true)
        game.Players.LocalPlayer:SetAttribute("HasDoubleCash", true)
    end)
end)

Gp2Action.MouseButton1Click:Connect(function()
    SetPassState(Gp2Action)
    pcall(function()
        game.Players.LocalPlayer:SetAttribute("SupercarsPass", true)
        game.Players.LocalPlayer:SetAttribute("OwnsSupercars", true)
    end)
end)

Gp3Action.MouseButton1Click:Connect(function()
    SetPassState(Gp3Action)
    pcall(function()
        game.Players.LocalPlayer:SetAttribute("EliteStatus", true)
        game.Players.LocalPlayer:SetAttribute("IsVIP", true)
    end)
end)

-- Станициализация при запуске
ApplyInterfaceTheme()
