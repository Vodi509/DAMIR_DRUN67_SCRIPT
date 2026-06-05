-- CC2 AUTOFARM v6.0 - Умный бот с крашерами и спавном
-- Для Delta Executor
-- GitHub: github.com/Vodi509/DAMIR_DRUN67_SCRIPT

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Очистка старого GUI
for _, v in pairs(playerGui:GetChildren()) do
    if v.Name == "CC2_Farm" then v:Destroy() end
end

-- ==================== GUI ====================
local screen = Instance.new("ScreenGui")
screen.Name = "CC2_Farm"
screen.ResetOnSpawn = false
screen.Parent = playerGui

local main = Instance.new("Frame", screen)
main.Size = UDim2.new(0, 340, 0, 320)
main.Position = UDim2.new(0.5, -170, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 6)

local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 6)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🐱 CC2 Farm v6.0"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 15
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 25, 0, 25)
minBtn.Position = UDim2.new(1, -55, 0, 5)
minBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextSize = 18
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 12)

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -28, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 12)

-- Кот
local catBtn = Instance.new("ImageButton")
catBtn.Name = "CatBtn"
catBtn.Size = UDim2.new(0, 50, 0, 50)
catBtn.Position = UDim2.new(0.03, 0, 0.15, 0)
catBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
catBtn.Image = "rbxassetid://18314115147"
catBtn.ScaleType = Enum.ScaleType.Fit
catBtn.ZIndex = 100
catBtn.Visible = false
catBtn.Active = true
catBtn.Draggable = true
catBtn.Parent = screen
Instance.new("UICorner", catBtn).CornerRadius = UDim.new(1, 0)

minBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    catBtn.Visible = true
end)
catBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    catBtn.Visible = false
end)
closeBtn.MouseButton1Click:Connect(function()
    screen:Destroy()
end)

-- Статус
local status = Instance.new("TextLabel", main)
status.Size = UDim2.new(1, -20, 0, 30)
status.Position = UDim2.new(0, 10, 0, 45)
status.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
status.Text = "Готов"
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.TextSize = 13
status.Font = Enum.Font.GothamBold
Instance.new("UICorner", status).CornerRadius = UDim.new(0, 4)

local startBtn = Instance.new("TextButton", main)
startBtn.Size = UDim2.new(1, -20, 0, 40)
startBtn.Position = UDim2.new(0, 10, 0, 85)
startBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
startBtn.Text = "▶ ЗАПУСТИТЬ"
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.TextSize = 16
startBtn.Font = Enum.Font.GothamBold
startBtn.BorderSizePixel = 0
Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 6)

local stopBtn = Instance.new("TextButton", main)
stopBtn.Size = UDim2.new(1, -20, 0, 40)
stopBtn.Position = UDim2.new(0, 10, 0, 135)
stopBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
stopBtn.Text = "■ ОСТАНОВИТЬ"
stopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stopBtn.TextSize = 16
stopBtn.Font = Enum.Font.GothamBold
stopBtn.BorderSizePixel = 0
Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 6)

local counter = Instance.new("TextLabel", main)
counter.Size = UDim2.new(1, -20, 0, 25)
counter.Position = UDim2.new(0, 10, 0, 185)
counter.BackgroundTransparency = 1
counter.Text = "Уничтожено: 0 | Ошибок: 0"
counter.TextColor3 = Color3.fromRGB(180, 180, 180)
counter.TextSize = 12
counter.Font = Enum.Font.Gotham
counter.TextXAlignment = Enum.TextXAlignment.Left

local timerLabel = Instance.new("TextLabel", main)
timerLabel.Size = UDim2.new(1, -20, 0, 20)
timerLabel.Position = UDim2.new(0, 10, 0, 215)
timerLabel.BackgroundTransparency = 1
timerLabel.Text = "Время: 00:00"
timerLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
timerLabel.TextSize = 11
timerLabel.Font = Enum.Font.Gotham
timerLabel.TextXAlignment = Enum.TextXAlignment.Left

local debugInfo = Instance.new("TextLabel", main)
debugInfo.Size = UDim2.new(1, -20, 0, 70)
debugInfo.Position = UDim2.new(0, 10, 0, 240)
debugInfo.BackgroundTransparency = 1
debugInfo.Text = ""
debugInfo.TextColor3 = Color3.fromRGB(255, 200, 100)
debugInfo.TextSize = 10
debugInfo.Font = Enum.Font.Gotham
debugInfo.TextWrapped = true

-- ==================== СКАНЕР КРАШЕРОВ ====================
local function getAvailableCrushers()
    local crushers = {}
    -- Ищем все детали с ProximityPrompt (кнопка активации крашера)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") and obj.Enabled then
            local parent = obj.Parent
            if parent and parent:IsA("BasePart") then
                -- Ищем родительскую модель (зона крашера)
                local model = parent.Parent
                if model and model:IsA("Model") then
                    -- Проверяем, не занят ли крашер другой машиной (простая проверка: нет ли рядом машин)
                    local occupied = false
                    for _, v in pairs(workspace.Vehicles:GetChildren()) do
                        if v:IsA("Model") and v.PrimaryPart then
                            if (v.PrimaryPart.Position - parent.Position).Magnitude < 15 then
                                occupied = true
                                break
                            end
                        end
                    end
                    if not occupied then
                        table.insert(crushers, {
                            prompt = obj,
                            part = parent,
                            model = model,
                            position = parent.Position
                        })
                    end
                end
            end
        end
    end
    -- Если не нашли ProximityPrompt, ищем по имени детали "Button" или "Activate"
    if #crushers == 0 then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name:lower():find("button") or obj.Name:lower():find("activate")) then
                local model = obj.Parent
                if model and model:IsA("Model") then
                    table.insert(crushers, {
                        prompt = nil,
                        part = obj,
                        model = model,
                        position = obj.Position
                    })
                end
            end
        end
    end
    return crushers
end

-- ==================== СКАНЕР ДОСТУПНЫХ МАШИН ====================
local function findAvailableVehicleGUI()
    -- Ищем GUI спавна машин (обычно ScreenGui с кнопками)
    for _, gui in pairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Name:lower():find("spawn") or gui.Name:lower():find("vehicle") then
            for _, obj in pairs(gui:GetDescendants()) do
                if obj:IsA("TextButton") or obj:IsA("ImageButton") then
                    -- Проверяем, не заблокирована ли кнопка (по цвету, тексту, наличию замка)
                    local text = obj:IsA("TextButton") and obj.Text or ""
                    local parent = obj.Parent
                    local locked = false
                    -- Проверка на VIP/Gamepass (часто серый цвет или иконка)
                    if obj.BackgroundColor3 and obj.BackgroundColor3.r < 0.5 and obj.BackgroundColor3.g < 0.5 and obj.BackgroundColor3.b < 0.5 then
                        locked = true
                    end
                    if text:lower():find("vip") or text:lower():find("gamepass") or text:lower():find("pass") then
                        locked = true
                    end
                    -- Ищем замок по детям
                    for _, child in pairs(obj:GetChildren()) do
                        if child:IsA("ImageLabel") and child.Image:lower():find("lock") then
                            locked = true
                            break
                        end
                    end
                    if not locked and obj.Visible and obj.Active then
                        return obj -- первая доступная кнопка
                    end
                end
            end
        end
    end
    -- Запасной вариант: ищем кнопку "Spawn" в любом GUI
    for _, gui in pairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            for _, obj in pairs(gui:GetDescendants()) do
                if (obj:IsA("TextButton") or obj:IsA("ImageButton")) and obj.Active and obj.Visible then
                    local text = obj:IsA("TextButton") and obj.Text or ""
                    if text:lower():find("spawn") or text:lower():find("car") then
                        return obj
                    end
                end
            end
        end
    end
    return nil
end

-- ==================== ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ ====================
local function getCurrentVehicle()
    local char = player.Character
    if not char then return nil end
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
    if not torso then return nil end
    -- Ищем модель, в которой находится Torso
    for _, model in pairs(workspace:GetDescendants()) do
        if model:IsA("Model") and model.PrimaryPart and torso:IsDescendantOf(model) then
            return model
        end
    end
    -- Ближайшая модель с VehicleSeat
    local nearest, minDist = nil, 20
    for _, model in pairs(workspace:GetDescendants()) do
        if model:IsA("Model") and model:FindFirstChildWhichIsA("VehicleSeat") then
            local dist = (model.PrimaryPart.Position - torso.Position).Magnitude
            if dist < minDist then
                minDist = dist
                nearest = model
            end
        end
    end
    return nearest
end

local function clickButton(button)
    if not button then return end
    -- Симулируем клик
    if button:IsA("TextButton") or button:IsA("ImageButton") then
        pcall(function()
            button:Invoke() -- для некоторых GUI
        end)
        pcall(function()
            -- Эмуляция нажатия мыши
            local mouse = player:GetMouse()
            local pos = button.AbsolutePosition + button.AbsoluteSize / 2
            mouse.X, mouse.Y = pos.X, pos.Y
            task.wait(0.05)
            mouse1click()
        end)
        -- Альтернативный метод
        firesignal(button.MouseButton1Click)
    end
end

-- ==================== ОСНОВНОЙ ЦИКЛ ====================
local farming = false
local crushes = 0
local errors = 0
local startTime = 0

local function spawnVehicle()
    local btn = findAvailableVehicleGUI()
    if btn then
        status.Text = "Спавн машины..."
        clickButton(btn)
        task.wait(3) -- ждём появления
    else
        status.Text = "Не нашёл кнопку спавна!"
        task.wait(5)
    end
end

local function activateCrusher(crusher)
    if crusher.prompt then
        pcall(function()
            crusher.prompt:InputHoldBegin()
            task.wait(1)
            crusher.prompt:InputHoldEnd()
        end)
    elseif crusher.part then
        -- Ищем ClickDetector
        local cd = crusher.part:FindFirstChildOfClass("ClickDetector")
        if cd then
            pcall(function()
                cd:Click()
            end)
        end
    end
end

local function moveToCrusher(vehicle, crusher)
    local root = vehicle.PrimaryPart or vehicle:FindFirstChildWhichIsA("BasePart")
    if not root then return false end
    -- Плавная телепортация над крашером
    local targetPos = crusher.position + Vector3.new(0, 8, 0)
    root.CFrame = CFrame.new(targetPos)
    root.Velocity = Vector3.new(0, -5, 0)
    task.wait(2)
    return true
end

startBtn.MouseButton1Click:Connect(function()
    if farming then return end
    farming = true
    crushes = 0
    errors = 0
    startTime = tick()
    startBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    status.Text = "Запуск..."
    status.BackgroundColor3 = Color3.fromRGB(0, 130, 50)

    spawn(function()
        while farming do
            local ok = pcall(function()
                -- 1. Получить список доступных крашеров
                local crushers = getAvailableCrushers()
                if #crushers == 0 then
                    status.Text = "Нет доступных крашеров"
                    debugInfo.Text = "Жду крашер..."
                    task.wait(5)
                    return
                end

                -- 2. Выбрать крашер (первый свободный)
                local targetCrusher = crushers[1]
                debugInfo.Text = "Крашеров: " .. #crushers .. "\nВыбран: " .. targetCrusher.model.Name

                -- 3. Получить или заспавнить машину
                local vehicle = getCurrentVehicle()
                if not vehicle then
                    status.Text = "Нет машины, спавню..."
                    spawnVehicle()
                    task.wait(3)
                    vehicle = getCurrentVehicle()
                    if not vehicle then
                        errors = errors + 1
                        status.Text = "Не удалось заспавнить!"
                        return
                    end
                end

                -- 4. Переместить машину в крашер
                status.Text = "Еду к крашеру..."
                moveToCrusher(vehicle, targetCrusher)

                -- 5. Активировать крашер
                status.Text = "Активация крашера..."
                activateCrusher(targetCrusher)

                -- 6. Ожидание уничтожения
                local waited = 0
                while waited < 15 and vehicle.Parent do
                    task.wait(1)
                    waited = waited + 1
                    status.Text = "Краш... " .. waited .. "/15с"
                end

                if not vehicle.Parent then
                    crushes = crushes + 1
                    status.Text = "Успех! +1"
                    status.BackgroundColor3 = Color3.fromRGB(0, 160, 60)
                else
                    -- Если не уничтожена, пробуем респавн
                    status.Text = "Не уничтожена, респавн..."
                    -- Удаляем машину (если возможно) или ждём
                    pcall(function() vehicle:Destroy() end)
                    task.wait(2)
                    errors = errors + 1
                    status.BackgroundColor3 = Color3.fromRGB(180, 100, 0)
                end

                counter.Text = "Уничтожено: " .. crushes .. " | Ошибок: " .. errors
                local t = tick() - startTime
                timerLabel.Text = string.format("Время: %02d:%02d", math.floor(t/60), math.floor(t%60))
                task.wait(2)
            end)
            if not ok then
                errors = errors + 1
                status.Text = "Ошибка цикла"
                task.wait(3)
            end
        end
    end)
end)

stopBtn.MouseButton1Click:Connect(function()
    farming = false
    status.Text = "Остановлен"
    status.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
    startBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
end)

-- Анти-АФК
spawn(function()
    while task.wait(20) do
        pcall(function()
            local c = player.Character
            if c then
                local h = c:FindFirstChildOfClass("Humanoid")
                if h then h:Move(Vector3.zero, true) end
            end
        end)
    end
end)

-- Первичный вывод
local crushers = getAvailableCrushers()
local vehicle = getCurrentVehicle()
print("CC2 v6.0: крашеров - " .. #crushers)
debugInfo.Text = "Крашеров: " .. #crushers .. "\nМашина: " .. (vehicle and vehicle.Name or "нет")
