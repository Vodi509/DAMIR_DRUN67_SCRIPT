-- CC2 AUTOFARM v5.0 - Рабочий сканер машин
-- GitHub: github.com/Vodi509/DAMIR_DRUN67_SCRIPT

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Очистка
for _, v in pairs(playerGui:GetChildren()) do
    if v.Name == "CC2_Farm" then v:Destroy() end
end

-- ==================== GUI ====================
local screen = Instance.new("ScreenGui")
screen.Name = "CC2_Farm"
screen.ResetOnSpawn = false
screen.Parent = playerGui

local main = Instance.new("Frame", screen)
main.Size = UDim2.new(0, 300, 0, 280)
main.Position = UDim2.new(0.5, -150, 0.3, 0)
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
title.Text = "🐱 CC2 Farm v5.0"
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

-- Отладочная инфа
local debugInfo = Instance.new("TextLabel", main)
debugInfo.Size = UDim2.new(1, -20, 0, 30)
debugInfo.Position = UDim2.new(0, 10, 0, 240)
debugInfo.BackgroundTransparency = 1
debugInfo.Text = ""
debugInfo.TextColor3 = Color3.fromRGB(255, 200, 100)
debugInfo.TextSize = 10
debugInfo.Font = Enum.Font.Gotham
debugInfo.TextXAlignment = Enum.TextXAlignment.Left

-- ==================== СКАНЕР ====================
local function scanAllVehicles()
    local folder = workspace:FindFirstChild("Vehicles")
    if not folder then return {} end
    
    local all = {}
    for _, v in pairs(folder:GetChildren()) do
        if v:IsA("Model") and (v:FindFirstChildWhichIsA("VehicleSeat") or v:FindFirstChild("Owner")) then
            local owner = v:FindFirstChild("Owner")
            local ownerName = owner and owner.Value and owner.Value.Name or "???"
            table.insert(all, {
                model = v,
                ownerName = ownerName,
                name = v.Name,
                seat = v:FindFirstChildWhichIsA("VehicleSeat")
            })
        end
    end
    return all
end

local function findCrusher()
    local best = nil
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local n = v.Name:lower()
            if n:find("crusher") or n:find("press") or n:find("crush") then
                if not best or v.Size.Magnitude > best.Size.Magnitude then
                    best = v
                end
            end
        end
    end
    -- если не нашли, возьмём самую большую платформу с "Base" или "Floor" рядом со спавном
    if not best then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name:lower():find("base") or v.Name:lower():find("floor")) then
                if not best or v.Size.Magnitude > best.Size.Magnitude then
                    best = v
                end
            end
        end
    end
    return best
end

local function findCrushEvent()
    for _, v in pairs(game.ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("crush") then
            return v
        end
    end
    return nil
end

-- ==================== ЛОГИКА ====================
local farming = false
local crushes = 0
local errors = 0
local startTime = 0

startBtn.MouseButton1Click:Connect(function()
    if farming then return end
    
    -- Сканируем
    local vehicles = scanAllVehicles()
    local crusher = findCrusher()
    local crushEvent = findCrushEvent()
    
    -- Вывод отладки
    local msg = "Машин: " .. #vehicles .. " | Крашер: " .. (crusher and crusher.Name or "НЕТ")
    debugInfo.Text = msg
    print("[CC2] " .. msg)
    for i, v in ipairs(vehicles) do
        print("[CC2] Машина " .. i .. ": " .. v.name .. " | Владелец: " .. v.ownerName)
    end
    
    if not crusher then
        status.Text = "Крашер не найден!"
        status.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
        return
    end
    
    if #vehicles == 0 then
        status.Text = "Машин нет! Сядь в машину."
        status.BackgroundColor3 = Color3.fromRGB(180, 100, 0)
        return
    end
    
    farming = true
    crushes = 0
    errors = 0
    startTime = tick()
    startBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    status.Text = "Фарм запущен"
    status.BackgroundColor3 = Color3.fromRGB(0, 130, 50)
    
    spawn(function()
        while farming do
            local ok = pcall(function()
                local char = player.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then
                    status.Text = "Жду респавн..."
                    task.wait(3)
                    return
                end
                
                -- Выбираем машину: сначала ту в которой сидим, потом свою, потом любую
                local targetCar = nil
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.SeatPart then
                    -- игрок в машине, берём её
                    targetCar = hum.SeatPart.Parent
                    status.Text = "Машина: " .. targetCar.Name .. " (сидим)"
                else
                    -- ищем свои (с Owner = player)
                    for _, v in ipairs(vehicles) do
                        if v.ownerName == player.Name then
                            targetCar = v.model
                            break
                        end
                    end
                    if not targetCar then
                        -- берём первую попавшуюся
                        targetCar = vehicles[1].model
                        status.Text = "Машина: " .. targetCar.Name .. " (общая)"
                    end
                end
                
                local root = targetCar.PrimaryPart or targetCar:FindFirstChildWhichIsA("BasePart")
                if not root then return end
                
                -- Телепорт в крашер
                root.CFrame = CFrame.new(crusher.Position + Vector3.new(0, 12, 0))
                root.Velocity = Vector3.new(0, -15, 0)
                task.wait(2)
                
                -- Активация
                if crushEvent then
                    pcall(function() crushEvent:FireServer(targetCar) end)
                    pcall(function() crushEvent:FireServer("Crush", targetCar) end)
                end
                -- пробуем все ивенты
                for _, v in pairs(game.ReplicatedStorage:GetDescendants()) do
                    if v:IsA("RemoteEvent") then
                        pcall(function() v:FireServer(targetCar) end)
                    end
                end
                
                local waited = 0
                while waited < 15 and targetCar.Parent do
                    task.wait(1)
                    waited = waited + 1
                    status.Text = "Краш... " .. waited .. "/15с"
                end
                
                if not targetCar.Parent then
                    crushes = crushes + 1
                    status.Text = "Успех! +1"
                    status.BackgroundColor3 = Color3.fromRGB(0, 160, 60)
                else
                    errors = errors + 1
                    status.Text = "Таймаут"
                    status.BackgroundColor3 = Color3.fromRGB(180, 100, 0)
                end
                
                counter.Text = "Уничтожено: " .. crushes .. " | Ошибок: " .. errors
                local t = tick() - startTime
                timerLabel.Text = string.format("Время: %02d:%02d", math.floor(t/60), math.floor(t%60))
                
                -- обновим список машин (могла появиться новая)
                vehicles = scanAllVehicles()
                debugInfo.Text = "Машин: " .. #vehicles .. " | Крашер: " .. crusher.Name
                
                task.wait(2)
            end)
            if not ok then task.wait(3) end
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
local v = scanAllVehicles()
local c = findCrusher()
print("[CC2] Машин найдено: " .. #v)
print("[CC2] Крашер: " .. (c and c.Name or "нет"))
debugInfo.Text = "Машин: " .. #v .. " | Крашер: " .. (c and c.Name or "нет")
