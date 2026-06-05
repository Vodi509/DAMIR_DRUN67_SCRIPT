-- ============================================================
-- CC2 AUTOFARM - ВСЁ В ОДНОМ ФАЙЛЕ
-- Для Delta Executor: просто скопировать и нажать Execute
-- Версия: 1.0 Standalone
-- ============================================================

-- ==================== НАСТРОЙКИ ====================
local CONFIG = {
    TELEPORT_HEIGHT = 15,        -- Высота подброса машины над дробилкой
    CRUSH_TIMEOUT = 20,          -- Максимальное ожидание уничтожения (сек)
    CYCLE_DELAY = 3,             -- Задержка между циклами (сек)
    USE_ANTI_DETECT = true,      -- Включить обход анти-чита
    DEBUG_MODE = true            -- Выводить отладочные сообщения
}

-- ==================== УВЕДОМЛЕНИЯ ====================
local function Notify(title, text, duration)
    duration = duration or 3
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = title or "CC2 Farm",
            Text = text or "",
            Duration = duration,
            Icon = "rbxassetid://2541869220"
        })
    end)
end

local function Debug(msg)
    if CONFIG.DEBUG_MODE then
        print("[CC2 DEBUG]", msg)
        pcall(function()
            game.StarterGui:SetCore("SendNotification", {
                Title = "DEBUG",
                Text = msg,
                Duration = 2
            })
        end)
    end
end

-- ==================== АНТИ-ДЕТЕКТ ====================
local function setupAntiDetect()
    if not CONFIG.USE_ANTI_DETECT then return end
    
    local mt = getrawmetatable(game)
    if not mt then return end
    
    local old = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "FireServer" then
            task.wait(0.03)
        end
        return old(self, ...)
    end)
    
    setreadonly(mt, true)
    
    -- Анти-АФК
    spawn(function()
        while task.wait(20) do
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then hum:Move(Vector3.zero, true) end
                end
            end)
        end
    end)
    
    Debug("Анти-детект активирован")
end

-- ==================== СКАНЕР ====================
local Scanner = {
    events = {},
    crusherParts = {},
    crushEvent = nil,
    crusherTarget = nil
}

function Scanner.scan()
    -- Ищем RemoteEvents
    local rs = game:GetService("ReplicatedStorage")
    for _, obj in pairs(rs:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            table.insert(Scanner.events, {
                name = obj.Name,
                object = obj
            })
        end
    end
    
    -- Ищем дробилку
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local n = obj.Name:lower()
            if n:find("crusher") or n:find("press") or n:find("crush") then
                table.insert(Scanner.crusherParts, obj)
            end
        end
    end
    
    -- Находим CrushEvent
    for _, ev in pairs(Scanner.events) do
        if ev.name:lower():find("crush") then
            Scanner.crushEvent = ev.object
            break
        end
    end
    
    -- Если не нашли CrushEvent, пробуем другие
    if not Scanner.crushEvent then
        for _, ev in pairs(Scanner.events) do
            if ev.name:lower():find("press") or ev.name:lower():find("activate") then
                Scanner.crushEvent = ev.object
                break
            end
        end
    end
    
    -- Находим самую большую часть дробилки
    if #Scanner.crusherParts > 0 then
        table.sort(Scanner.crusherParts, function(a, b)
            return a.Size.Magnitude > b.Size.Magnitude
        end)
        Scanner.crusherTarget = Scanner.crusherParts[1]
    end
    
    Debug(string.format("Сканер: %d ивентов, %d частей дробилки", 
        #Scanner.events, #Scanner.crusherParts))
    
    if Scanner.crushEvent then
        Debug("CrushEvent найден: " .. Scanner.crushEvent.Name)
    else
        Debug("ВНИМАНИЕ: CrushEvent не найден!")
    end
    
    if Scanner.crusherTarget then
        Debug("Дробилка: " .. Scanner.crusherTarget.Name)
    else
        Debug("ВНИМАНИЕ: Дробилка не найдена!")
    end
end

-- ==================== РАБОТА С МАШИНАМИ ====================
local Vehicle = {}

function Vehicle.getMyVehicles()
    local list = {}
    local folder = workspace:FindFirstChild("Vehicles")
    if not folder then return list end
    
    local player = game.Players.LocalPlayer
    
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

function Vehicle.getRoot(model)
    return model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
end

function Vehicle.teleportTo(model, targetCFrame)
    local root = Vehicle.getRoot(model)
    if not root then return false end
    
    root.CFrame = targetCFrame
    root.Velocity = Vector3.zero
    root.RotVelocity = Vector3.zero
    task.wait(0.1)
    root.Velocity = Vector3.new(0, -10, 0)
    
    return true
end

function Vehicle.exists(model)
    return model ~= nil and model.Parent ~= nil
end

function Vehicle.waitForDestroy(model, timeout)
    timeout = timeout or CONFIG.CRUSH_TIMEOUT
    local elapsed = 0
    
    while elapsed < timeout do
        if not Vehicle.exists(model) then
            return true
        end
        task.wait(1)
        elapsed = elapsed + 1
    end
    
    return false
end

function Vehicle.sitInSeat(model)
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char then return false end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    
    local seat = model:FindFirstChildWhichIsA("VehicleSeat")
    if not seat then return false end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = seat.CFrame + Vector3.new(0, 5, 0)
        task.wait(0.5)
    end
    
    pcall(function() seat:Sit(humanoid) end)
    return true
end

-- ==================== АКТИВАЦИЯ КРАША ====================
local function activateCrusher(car)
    if not Scanner.crushEvent then
        -- Пробуем ВСЕ ивенты подряд
        Debug("Пробую все RemoteEvent подряд...")
        for _, ev in pairs(Scanner.events) do
            pcall(function() ev.object:FireServer(car) end)
            pcall(function() ev.object:FireServer("Crush", car) end)
            pcall(function() ev.object:FireServer("Activate", car) end)
            task.wait(0.1)
        end
        return true -- Предполагаем, что сработало
    end
    
    -- Пробуем разные комбинации аргументов
    local argSets = {
        {car},
        {"Crush", car},
        {"Activate", car},
        {"CrushVehicle", car},
        {"StartCrushing", car},
        {car, "Crush"},
        {car, true},
        {game.Players.LocalPlayer, car},
    }
    
    for _, args in pairs(argSets) do
        local ok = pcall(function()
            Scanner.crushEvent:FireServer(unpack(args))
        end)
        if ok then
            Debug("FireServer отправлен: " .. table.concat(args, ", "))
        end
        task.wait(0.2)
    end
    
    return true
end

-- ==================== ОСНОВНОЙ ЦИКЛ ====================
local Farm = {
    running = false,
    totalCrushes = 0,
    fails = 0
}

function Farm.start()
    if Farm.running then return end
    Farm.running = true
    
    -- Проверки
    if not Scanner.crusherTarget then
        Notify("ОШИБКА", "Дробилка не найдена! Встаньте рядом с дробилкой и перезапустите скрипт.", 10)
        Farm.running = false
        return
    end
    
    if not Scanner.crushEvent then
        Notify("ВНИМАНИЕ", "RemoteEvent краша не найден. Будем пробовать все ивенты подряд.", 5)
    end
    
    Notify("ФАРМ ЗАПУЩЕН", "Начинаю цикл...", 5)
    
    -- Главный цикл
    while Farm.running do
        local cycleOk = pcall(function()
            local player = game.Players.LocalPlayer
            
            -- Проверка игрока
            if not player then
                Debug("Игрок не найден")
                task.wait(5)
                return
            end
            
            -- Проверка персонажа
            local char = player.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then
                Debug("Персонаж не загружен, жду респавн...")
                task.wait(5)
                return
            end
            
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health <= 0 then
                Debug("Персонаж мёртв, жду респавн...")
                task.wait(5)
                return
            end
            
            -- Получаем машины
            local myCars = Vehicle.getMyVehicles()
            
            if #myCars == 0 then
                Notify("НЕТ МАШИН", "Купите машину через меню игры или телепортируйте её на карту.", 5)
                task.wait(10)
                return
            end
            
            -- Берём первую машину
            local car = myCars[1]
            local carName = car.Name
            
            Farm.totalCrushes = Farm.totalCrushes + 1
            Notify("ЦИКЛ #" .. Farm.totalCrushes, "Машина: " .. carName, 3)
            
            -- Телепорт в дробилку
            local crushPos = Scanner.crusherTarget.Position
            local targetCFrame = CFrame.new(crushPos + Vector3.new(0, CONFIG.TELEPORT_HEIGHT, 0))
            
            Debug("Телепорт " .. carName .. " в дробилку...")
            Vehicle.teleportTo(car, targetCFrame)
            
            -- Ждём падения
            task.wait(3)
            
            -- Пробуем сесть в машину
            Debug("Посадка в машину...")
            Vehicle.sitInSeat(car)
            task.wait(1)
            
            -- Активируем краш
            Debug("Активация дробилки...")
            activateCrusher(car)
            
            -- Ждём уничтожения
            Notify("ОЖИДАНИЕ", "Жду уничтожения " .. carName .. "...", 3)
            local destroyed = Vehicle.waitForDestroy(car)
            
            if destroyed then
                Farm.fails = 0
                Notify("УСПЕХ!", "Машина уничтожена! Всего: " .. Farm.totalCrushes, 5)
            else
                Farm.fails = Farm.fails + 1
                Notify("ТАЙМАУТ", "Машина не уничтожена за " .. CONFIG.CRUSH_TIMEOUT .. " сек. Пропускаю.", 5)
                
                -- Если много ошибок подряд - пауза
                if Farm.fails >= 5 then
                    Notify("ПАУЗА", "Слишком много ошибок. Жду 30 секунд...", 5)
                    task.wait(30)
                    Farm.fails = 0
                end
            end
            
            -- Задержка между циклами
            task.wait(CONFIG.CYCLE_DELAY)
        end)
        
        if not cycleOk then
            Debug("Критическая ошибка цикла, перезапуск через 5 сек...")
            task.wait(5)
        end
    end
end

function Farm.stop()
    Farm.running = false
    Notify("СТОП", "Фарм остановлен. Всего уничтожено: " .. Farm.totalCrushes, 5)
end

-- ==================== ЗАПУСК ====================
Notify("CC2 AUTOFARM", "Загрузка... Жду мир.", 5)

-- Ждём загрузки
repeat task.wait(0.5) until game:IsLoaded()
repeat task.wait(0.5) until workspace:FindFirstChild("Vehicles")
repeat task.wait(0.5) until game.Players.LocalPlayer.Character

Notify("CC2 AUTOFARM", "Мир загружен. Инициализация...", 3)

-- Анти-детект
setupAntiDetect()

-- Сканирование
Scanner.scan()

-- Запуск фарма
Farm.start()

-- Вывод информации
print("========================================")
print("CC2 AUTOFARM STANDALONE v1.0")
print("RemoteEvent найдено:", #Scanner.events)
print("CrushEvent:", Scanner.crushEvent and Scanner.crushEvent.Name or "НЕ НАЙДЕН")
print("Дробилка:", Scanner.crusherTarget and Scanner.crusherTarget.Name or "НЕ НАЙДЕНА")
print("Машин у игрока:", #Vehicle.getMyVehicles())
print("Статус:", Farm.running and "ЗАПУЩЕН" or "ОСТАНОВЛЕН")
print("========================================")
