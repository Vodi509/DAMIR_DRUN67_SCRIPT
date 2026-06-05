-- CC2 AUTOFARM v4.1 - Delta Fixed
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

-- Главное окно
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 300, 0, 250)
main.Position = UDim2.new(0.5, -150, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screen

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 6)

-- Заголовок
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
header.BorderSizePixel = 0
header.Parent = main

Instance.new("UICorner", header).CornerRadius = UDim.new(0, 6)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🐱 CC2 Farm v4.1"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 15
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопка сворачивания
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

-- Кнопка закрытия
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

-- Кнопка-кот
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

-- Статус
local status = Instance.new("TextLabel", main)
status.Size = UDim2.new(1, -20, 0, 30)
status.Position = UDim2.new(0, 10, 0, 45)
status.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
status.Text = "Готов к работе"
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.TextSize = 13
status.Font = Enum.Font.GothamBold
Instance.new("UICorner", status).CornerRadius = UDim.new(0, 4)

-- Кнопка Старт
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

-- Кнопка Стоп
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

-- Счётчик
local counter = Instance.new("TextLabel", main)
counter.Size = UDim2.new(1, -20, 0, 25)
counter.Position = UDim2.new(0, 10, 0, 185)
counter.BackgroundTransparency = 1
counter.Text = "Уничтожено: 0 | Ошибок: 0"
counter.TextColor3 = Color3.fromRGB(180, 180, 180)
counter.TextSize = 12
counter.Font = Enum.Font.Gotham
counter.TextXAlignment = Enum.TextXAlignment.Left

-- Таймер
local timerLabel = Instance.new("TextLabel", main)
timerLabel.Size = UDim2.new(1, -20, 0, 20)
timerLabel.Position = UDim2.new(0, 10, 0, 215)
timerLabel.BackgroundTransparency = 1
timerLabel.Text = "Время: 00:00"
timerLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
timerLabel.TextSize = 11
timerLabel.Font = Enum.Font.Gotham
timerLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ==================== ЛОГИКА СВОРАЧИВАНИЯ ====================
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

-- ==================== ФАРМ ====================
local farming = false
local crushes = 0
local errors = 0
local startTime = 0

local function scan()
    local events = {}
    for _, v in pairs(game.ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") then table.insert(events, v) end
    end
    
    local crusher = nil
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local n = v.Name:lower()
            if n:find("crusher") or n:find("press") then
                if not crusher or v.Size.Magnitude > crusher.Size.Magnitude then
                    crusher = v
                end
            end
        end
    end
    
    local crushEvent = nil
    for _, v in pairs(events) do
        if v.Name:lower():find("crush") then crushEvent = v break end
    end
    
    return events, crusher, crushEvent
end

local function getCars()
    local list = {}
    local folder = workspace:FindFirstChild("Vehicles")
    if not folder then return list end
    for _, v in pairs(folder:GetChildren()) do
        if v:IsA("Model") then
            local o = v:FindFirstChild("Owner")
            if o and o:IsA("ObjectValue") and o.Value == player then
                table.insert(list, v)
            end
        end
    end
    return list
end

startBtn.MouseButton1Click:Connect(function()
    if farming then return end
    
    local events, crusher, crushEvent = scan()
    
    if not crusher then
        status.Text = "ОШИБКА: Дробилка не найдена!"
        status.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
        return
    end
    
    farming = true
    crushes = 0
    errors = 0
    startTime = tick()
    startBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    status.Text = "Фарм запущен!"
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
                
                local cars = getCars()
                if #cars == 0 then
                    status.Text = "Нет машин! Купите машину."
                    task.wait(5)
                    return
                end
                
                local car = cars[1]
                local root = car.PrimaryPart or car:FindFirstChildWhichIsA("BasePart")
                if not root then return end
                
                status.Text = "Телепорт: " .. car.Name
                
                root.CFrame = CFrame.new(crusher.Position + Vector3.new(0, 12, 0))
                root.Velocity = Vector3.new(0, -15, 0)
                task.wait(2)
                
                status.Text = "Активация краша..."
                
                if crushEvent then
                    pcall(function() crushEvent:FireServer(car) end)
                    pcall(function() crushEvent:FireServer("Crush", car) end)
                end
                for _, ev in pairs(events) do
                    pcall(function() ev:FireServer(car) end)
                end
                
                local waited = 0
                while waited < 15 and car.Parent do
                    task.wait(1)
                    waited = waited + 1
                    status.Text = "Краш... " .. waited .. "/15с"
                end
                
                if not car.Parent then
                    crushes = crushes + 1
                    status.Text = "Успех! +1"
                    status.BackgroundColor3 = Color3.fromRGB(0, 160, 60)
                else
                    errors = errors + 1
                    status.Text = "Таймаут, пропускаю"
                    status.BackgroundColor3 = Color3.fromRGB(180, 100, 0)
                end
                
                counter.Text = "Уничтожено: " .. crushes .. " | Ошибок: " .. errors
                local t = tick() - startTime
                timerLabel.Text = string.format("Время: %02d:%02d", math.floor(t/60), math.floor(t%60))
                
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
