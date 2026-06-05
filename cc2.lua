-- [[ DAMIR_DRUN67 MEGA ULTRA HUB v15.0 - ANTIBUG EDITION ]] --
-- Содержит исправления для всех известных багов физики, текстур и серверов CC2

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

if CoreGui:FindFirstChild("DamirUltimateHub") then
    CoreGui.DamirUltimateHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DamirUltimateHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999

local function createRoundedFrame(parent, size, pos, color)
    local frame = Instance.new("Frame", parent)
    frame.Size = size
    frame.Position = pos
    frame.BackgroundColor3 = color
    frame.BorderSizePixel = 0
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 9)
    return frame
end

local MainFrame = createRoundedFrame(ScreenGui, UDim2.new(0, 440, 0, 280), UDim2.new(0.25, 0, 0.25, 0), Color3.fromRGB(22, 22, 28))
MainFrame.Active = true
MainFrame.Draggable = true

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 9)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0.04, 0, 0, 0)
Title.Text = "DAMIR HUB v15.0 | Total Bug Override"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(0.91, 0, 0, 0)
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.fromRGB(240, 90, 90)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextSize = 14

local CatBtn = Instance.new("ImageButton", ScreenGui)
CatBtn.Size = UDim2.new(0, 60, 0, 60)
CatBtn.Position = UDim2.new(0.03, 0, 0.15, 0)
CatBtn.Image = "rbxassetid://18314115147"
CatBtn.Visible = false
CatBtn.BorderSizePixel = 0
CatBtn.ZIndex = 100
Instance.new("UICorner", CatBtn).CornerRadius = UDim.new(1, 0)

local SideBar = Instance.new("Frame", MainFrame)
SideBar.Size = UDim2.new(0, 120, 0, 245)
SideBar.Position = UDim2.new(0, 0, 0, 35)
SideBar.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
SideBar.BorderSizePixel = 0

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(0, 310, 0, 235)
ContentFrame.Position = UDim2.new(0, 125, 0, 40)
ContentFrame.BackgroundTransparency = 1

local Tabs = {}
local TabButtons = {}

local function CreateTab(name, isDefault)
    local tabContainer = Instance.new("ScrollingFrame", ContentFrame)
    tabContainer.Size = UDim2.new(1, 0, 1, 0)
    tabContainer.BackgroundTransparency = 1
    tabContainer.CanvasSize = UDim2.new(0, 0, 2.5, 0)
    tabContainer.ScrollBarThickness = 3
    tabContainer.Visible = isDefault or false
    
    local layout = Instance.new("UIListLayout", tabContainer)
    layout.Padding = UDim.new(0, 8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    Tabs[name] = tabContainer
    local count = 0 for _ in pairs(Tabs) do count = count + 1 end
    
    local TabBtn = Instance.new("TextButton", SideBar)
    TabBtn.Size = UDim2.new(0.9, 0, 0, 34)
    TabBtn.Position = UDim2.new(0.05, 0, 0, (count - 1) * 40 + 12)
    TabBtn.Text = name
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.TextSize = 11
    TabBtn.TextColor3 = isDefault and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 170)
    TabBtn.BackgroundColor3 = isDefault and Color3.fromRGB(40, 40, 52) or Color3.fromRGB(24, 24, 32)
    TabBtn.BorderSizePixel = 0
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 5)
    
    TabButtons[name] = TabBtn
    TabBtn.MouseButton1Click:Connect(function()
        for k, t in pairs(Tabs) do 
            t.Visible = false 
            TabButtons[k].BackgroundColor3 = Color3.fromRGB(24, 24, 32)
            TabButtons[k].TextColor3 = Color3.fromRGB(160, 160, 170)
        end
        tabContainer.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return tabContainer
end

local MainTab = CreateTab("🏠 Информация", true)
local FarmTab = CreateTab("⚡ Авто Фарм", false)

local function AddToggle(tab, text, default, callback)
    local frame = Instance.new("Frame", tab)
    frame.Size = UDim2.new(0.96, 0, 0, 42)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(240, 240, 245)
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    
    local state = default
    local tBtn = Instance.new("TextButton", frame)
    tBtn.Size = UDim2.new(0, 46, 0, 22)
    tBtn.Position = UDim2.new(0.8, 0, 0.24, 0)
    tBtn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(55, 55, 65)
    tBtn.Text = ""
    Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 11)
    
    tBtn.MouseButton1Click:Connect(function()
        state = not state
        tBtn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(55, 55, 65)
        callback(state)
    end)
end

-- === УЛЬТРА СИСТЕМА ОБХОДА БАГОВ ===
local brokenCrusher = nil

local function getBestCrusher()
    local cFolder = workspace:FindFirstChild("Crushers")
    if not cFolder then return nil end
    local children = cFolder:GetChildren()
    
    for _, v in pairs(children) do
        if v ~= brokenCrusher and v:FindFirstChild("Status") and (v.Status.Value == "Frenzy" or v.Status.Value == "Bonus") then
            return v
        end
    end
    for _, v in pairs(children) do
        if v ~= brokenCrusher and v.Name ~= "Spawns" then
            return v
        end
    end
    return children[1]
end

local lastVehicleId = 1
local function autoBuyNextVehicle()
    pcall(function()
        local nextId = lastVehicleId + 1
        local success = ReplicatedStorage.NetworkRemote.BuyVehicle:InvokeServer(nextId)
        if success then lastVehicleId = nextId end
    end)
end

-- Функция тотального контроля коллизий (проезд сквозь текстуры/игроков)
local function disableVehicleCollision(vehicle)
    for _, part in pairs(vehicle:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

local function getVehicle()
    local char = lp.Character
    if not char or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then 
        task.wait(0.8) 
        return nil 
    end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    -- Лечение бага бесконечного лежания (Рэгдолл фикс)
    if char.Humanoid.PlatformStand then
        char.Humanoid.PlatformStand = false
        if hrp then hrp.Velocity = Vector3.new(0,0,0) end
    end
    
    for _, v in pairs(workspace.Vehicles:GetChildren()) do
        if v:FindFirstChild("Owner") and v.Owner.Value == lp then
            local hp = v:FindFirstChild("Health") and v.Health.Value or 100
            local root = v:FindFirstChild("PrimaryPart") or v:FindFirstChild("Body")
            local seat = v:FindFirstChildOfClass("VehicleSeat")
            
            if root then
                -- БАГ ФИКС: Если машина улетела в бездну или улетела в космос
                if root.Position.Y < -100 or root.Position.Y > 600 then
                    pcall(function() ReplicatedStorage.NetworkRemote.DestroyVehicle:FireServer(v) end)
                    task.wait(0.3)
                    return nil
                end
                
                -- БАГ ФИКС: Проезд сквозь застрявшие машины других игроков
                disableVehicleCollision(v)
            end
            
            -- Фикс вылета из сиденья (Анти-таран)
            if char.Humanoid.SeatPart == nil and root and hrp then
                if (hrp.Position - root.Position).Magnitude > 12 then
                    hrp.CFrame = root.CFrame + Vector3.new(0, 3, 0)
                end
                if seat then seat:Sit(char.Humanoid) end
                task.wait(0.1)
            end
            
            -- Авто-переворот
            if root and root.CFrame.UpVector.Y < 0.2 then
                pcall(function() ReplicatedStorage.NetworkRemote.FlipVehicle:FireServer(v) end)
            end
            
            -- Респавн при поломке
            if hp < 60 then
                pcall(function() ReplicatedStorage.NetworkRemote.DestroyVehicle:FireServer(v) end)
                task.wait(0.3)
                return nil
            end
            
            return v
        end
    end
    
    pcall(function() ReplicatedStorage.NetworkRemote.SpawnVehicle:InvokeServer(lastVehicleId) end)
    task.wait(0.5)
    return nil
end

local _G_SmartFarm = false

local Lb = Instance.new("TextLabel", MainTab)
Lb.Size = UDim2.new(0.95, 0, 0, 50)
Lb.Text = "Дамир Хаб v15.0.\nВнедрена защита Anti-Void, Anti-Stuck и No-Collide для машин!"
Lb.TextColor3 = Color3.fromRGB(180, 180, 190)
Lb.Font = Enum.Font.Gotham
Lb.TextSize = 11
Lb.BackgroundTransparency = 1

AddToggle(FarmTab, "НЕУЯЗВИМЫЙ АВТОФАРМ v15.0", false, function(state)
    _G_SmartFarm = state
    if state then
        task.spawn(function()
            local lastPosition = Vector3.new(0,0,0)
            local stuckTicks = 0
            local lastMoney = 0
            local moneyStuckTicks = 0
            
            while _G_SmartFarm do
                autoBuyNextVehicle()
                local car = getVehicle()
                local crusher = getBestCrusher()
                
                -- Детектор поломки начисления денег (Зависание пресса)
                local currentMoney = lp:FindFirstChild("leaderstats") and lp.leaderstats:FindFirstChild("Money") and lp.leaderstats.Money.Value or 0
                if currentMoney == lastMoney and currentMoney > 0 and car then
                    moneyStuckTicks = moneyStuckTicks + 1
                else
                    moneyStuckTicks = 0
                end
                lastMoney = currentMoney
                
                if moneyStuckTicks >= 3 then -- Если крашер заклинило
                    brokenCrusher = crusher
                    if car then pcall(function() ReplicatedStorage.NetworkRemote.DestroyVehicle:FireServer(car) end) end
                    moneyStuckTicks = 0
                    stuckTicks = 0
                    task.wait(0.4)
                    crusher = getBestCrusher()
                    brokenCrusher = nil
                end
                
                if car and crusher and crusher:FindFirstChild("Base") and car:FindFirstChild("PrimaryPart") then
                    local currentPos = car.PrimaryPart.Position
                    local targetPos = crusher.Base.CFrame + Vector3.new(0, 3, 0)
                    
                    if (currentPos - lastPosition).Magnitude < 1.5 then
                        stuckTicks = stuckTicks + 1
                    else
                        stuckTicks = 0
                    end
                    lastPosition = currentPos
                    
                    -- Если машина застряла в стене или заблокирована физикой — жесткий перенос
                    if stuckTicks >= 2 or (currentPos - crusher.Base.Position).Magnitude > 80 then
                        car.PrimaryPart.CFrame = targetPos
                        stuckTicks = 0
                    else
                        car.PrimaryPart.CFrame = targetPos
                    end
                    
                    pcall(function() ReplicatedStorage.NetworkRemote.TriggerCrusher:FireServer(crusher) end)
                end
                task.wait(1.6)
            end
        end)
    end
end)

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; CatBtn.Visible = true end)
CatBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true; CatBtn.Visible = false end)
