-- [[ DAMIR_DRUN67 HUB v6.2 - SPEEDHUB NO SCROLL ]] --

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- ==================== ТЕМА ====================
local Theme = {
    MainBg = Color3.fromRGB(15, 16, 22),
    InnerBg = Color3.fromRGB(22, 24, 33),
    StrokeDefault = Color3.fromRGB(38, 42, 56),
    StatusOnline = Color3.fromRGB(0, 255, 163),
    StatusOffline = Color3.fromRGB(255, 46, 92),
    BtnBg = Color3.fromRGB(30, 33, 45),
    TextMain = Color3.fromRGB(255, 255, 255),
    TextSub = Color3.fromRGB(125, 131, 150),
    AccentGlow = Color3.fromRGB(0, 200, 255),
    Purple = Color3.fromRGB(160, 100, 255)
}

-- ==================== ПОИСК МАШИНЫ ====================
local function getMyCar()
    local char = localPlayer.Character
    if not char then return nil end
    if char:FindFirstChild("Humanoid") and char.Humanoid.SeatPart then
        local seat = char.Humanoid.SeatPart
        if seat:IsA("VehicleSeat") then
            local current = seat
            while current do
                if current:IsA("Model") and current.Name ~= "Body" then
                    return current
                elseif current:IsA("Model") and current.Name == "Body" then
                    local parent = current.Parent
                    if parent and parent:IsA("Model") and parent.Name ~= "Body" then
                        return parent
                    end
                    current = current.Parent
                else
                    current = current.Parent
                end
            end
        end
    end
    local folders = {workspace:FindFirstChild("Vehicles"), workspace}
    for _, folder in pairs(folders) do
        if folder then
            for _, v in pairs(folder:GetChildren()) do
                if v:IsA("Model") then
                    local owner = v:FindFirstChild("Owner")
                    if (owner and owner.Value == localPlayer) then return v end
                end
            end
        end
    end
    return nil
end

-- ==================== РЕСПАВН ====================
local function findSpawn()
    local pg = localPlayer:WaitForChild("PlayerGui")
    for _, g in pairs(pg:GetChildren()) do
        if g:IsA("ScreenGui") then
            for _, o in pairs(g:GetDescendants()) do
                if (o:IsA("TextButton") or o:IsA("ImageButton")) and o.Visible and o.Active then
                    local t = o:IsA("TextButton") and o.Text or ""
                    local n = o.Name:lower()
                    if n:find("spawn") or n:find("get") or n:find("vehicle") or n:find("car") or
                       t:lower():find("spawn") or t:lower():find("car") or t:lower():find("get") or
                       t:lower():find("free") or t:lower():find("бесплат") or t:lower():find("спавн") or t:lower():find("машин") then
                        if not t:lower():find("vip") and not t:lower():find("pass") and not t:lower():find("premium") then
                            return o
                        end
                    end
                end
            end
        end
    end
    return nil
end

local function clickSpawn()
    local btn = findSpawn()
    if not btn then return false end
    local OX, OY = 35, 35
    if firesignal and btn.MouseButton1Click then
        pcall(function() firesignal(btn.MouseButton1Click) end)
    end
    pcall(function()
        local vim = game:GetService("VirtualInputManager")
        local pos = btn.AbsolutePosition + btn.AbsoluteSize / 2
        pos = Vector2.new(pos.X + OX, pos.Y + OY)
        vim:SendMouseButtonEvent(pos.X, pos.Y, 0, true, game, 1)
        wait(0.05)
        vim:SendMouseButtonEvent(pos.X, pos.Y, 0, false, game, 1)
    end)
    return true
end

-- ==================== GUI ====================
local g = localPlayer:WaitForChild("PlayerGui")
for _, v in pairs(g:GetChildren()) do
    if v.Name == "SpeedHub" or v.Name == "MiniHub" then v:Destroy() end
end

local screenGui = Instance.new("ScreenGui", g)
screenGui.Name = "SpeedHub"
screenGui.ResetOnSpawn = false

-- Мини-панель
local miniFrame = Instance.new("Frame", screenGui)
miniFrame.Name = "MiniHub"
miniFrame.Size = UDim2.new(0, 130, 0, 28)
miniFrame.Position = UDim2.new(0.02, 0, 0.1, 0)
miniFrame.BackgroundColor3 = Theme.InnerBg
miniFrame.BorderSizePixel = 0
miniFrame.Visible = false
miniFrame.Active = true
miniFrame.Draggable = true
miniFrame.ZIndex = 99
Instance.new("UICorner", miniFrame).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", miniFrame).Thickness = 1
Instance.new("UIStroke", miniFrame).Color = Theme.Purple

local restoreBtn = Instance.new("TextButton", miniFrame)
restoreBtn.Size = UDim2.new(1, 0, 1, 0)
restoreBtn.BackgroundTransparency = 1
restoreBtn.Text = "⚡ DAMIR HUB"
restoreBtn.TextColor3 = Theme.StatusOffline
restoreBtn.Font = Enum.Font.GothamBold
restoreBtn.TextSize = 12

-- Главное окно
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.4, 0)
mainFrame.Size = UDim2.new(0, 480, 0, 280)
mainFrame.BackgroundColor3 = Theme.MainBg
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true
mainFrame.ZIndex = 100
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", mainFrame).Thickness = 1
Instance.new("UIStroke", mainFrame).Color = Theme.StrokeDefault

-- Заголовок
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundColor3 = Theme.InnerBg
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)

local titleText = Instance.new("TextLabel", titleBar)
titleText.Size = UDim2.new(1, -50, 1, 0)
titleText.Position = UDim2.new(0, 14, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "🐱 DAMIR HUB v6.2"
titleText.TextColor3 = Theme.TextMain
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 13
titleText.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -30, 0, 7)
closeBtn.BackgroundColor3 = Theme.StatusOffline
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 11)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Боковая панель
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 120, 1, -36)
sidebar.Position = UDim2.new(0, 0, 0, 36)
sidebar.BackgroundColor3 = Theme.InnerBg
sidebar.BorderSizePixel = 0
Instance.new("UIStroke", sidebar).Thickness = 1
Instance.new("UIStroke", sidebar).Color = Theme.StrokeDefault

local logoLabel = Instance.new("TextButton", sidebar)
logoLabel.Size = UDim2.new(1, 0, 0, 40)
logoLabel.BackgroundTransparency = 1
logoLabel.Text = "DAMIR HUB"
logoLabel.TextColor3 = Theme.StatusOffline
logoLabel.Font = Enum.Font.GothamBold
logoLabel.TextSize = 14

logoLabel.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    miniFrame.Visible = true
end)
restoreBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    miniFrame.Visible = false
end)

local farmTabBtn = Instance.new("TextButton", sidebar)
farmTabBtn.Size = UDim2.new(0, 100, 0, 30)
farmTabBtn.Position = UDim2.new(0, 10, 0, 50)
farmTabBtn.BackgroundColor3 = Theme.Purple
farmTabBtn.Text = "🚀 Авто Фарм"
farmTabBtn.TextColor3 = Theme.TextMain
farmTabBtn.Font = Enum.Font.GothamBold
farmTabBtn.TextSize = 11
Instance.new("UICorner", farmTabBtn).CornerRadius = UDim.new(0, 4)

-- Контент (простой Frame, без ScrollingFrame)
local content = Instance.new("Frame", mainFrame)
content.Position = UDim2.new(0, 130, 0, 46)
content.Size = UDim2.new(1, -140, 1, -56)
content.BackgroundTransparency = 1

-- ====== ФАРМ ======
local farmTitle = Instance.new("TextLabel", content)
farmTitle.Size = UDim2.new(1, 0, 0, 20)
farmTitle.BackgroundTransparency = 1
farmTitle.Text = "ПРОГРАММА «МОЛОТ» v6.2"
farmTitle.TextColor3 = Theme.TextMain
farmTitle.Font = Enum.Font.GothamBold
farmTitle.TextSize = 12
farmTitle.TextXAlignment = Enum.TextXAlignment.Left

local carFrame = Instance.new("Frame", content)
carFrame.Size = UDim2.new(1, 0, 0, 32)
carFrame.Position = UDim2.new(0, 0, 0, 24)
carFrame.BackgroundColor3 = Theme.InnerBg
Instance.new("UICorner", carFrame).CornerRadius = UDim.new(0, 5)

local carLabel = Instance.new("TextLabel", carFrame)
carLabel.Size = UDim2.new(1, -16, 1, 0)
carLabel.Position = UDim2.new(0, 8, 0, 0)
carLabel.BackgroundTransparency = 1
carLabel.Text = "🚗 Ищу машину..."
carLabel.TextColor3 = Theme.TextSub
carLabel.Font = Enum.Font.GothamBold
carLabel.TextSize = 11
carLabel.TextXAlignment = Enum.TextXAlignment.Left

local statsLabel = Instance.new("TextLabel", content)
statsLabel.Size = UDim2.new(1, 0, 0, 18)
statsLabel.Position = UDim2.new(0, 0, 0, 60)
statsLabel.BackgroundTransparency = 1
statsLabel.Text = "Ударов: 0 | Сломано: 0 | Авто: 0"
statsLabel.TextColor3 = Theme.TextSub
statsLabel.Font = Enum.Font.Gotham
statsLabel.TextSize = 10
statsLabel.TextXAlignment = Enum.TextXAlignment.Left

spawn(function()
    while wait(0.3) do
        pcall(function()
            local c = getMyCar()
            if c then
                carLabel.Text = "🚗 " .. c.Name
                carLabel.TextColor3 = Theme.AccentGlow
            else
                carLabel.Text = "🚗 Сядьте в машину!"
                carLabel.TextColor3 = Theme.StatusOffline
            end
        end)
    end
end)

-- ====== МОЛОТ ======
local ha, aa, hh, cd, afc = false, false, 0, 0, 0

local function doHit()
    local c = getMyCar()
    if not c then return false end
    local r = c.PrimaryPart or c:FindFirstChildWhichIsA("BasePart")
    if not r then return false end
    r.Velocity = Vector3.new(0, 0, 0)
    r.CFrame = CFrame.new(r.Position.X, 200, r.Position.Z)
    wait(0.15)
    r.Velocity = Vector3.new(0, -1500, 0)
    wait(1.0)
    if not c.Parent then cd = cd + 1 return true end
    return false
end

local hammerBtn = Instance.new("TextButton", content)
hammerBtn.Size = UDim2.new(1, 0, 0, 38)
hammerBtn.Position = UDim2.new(0, 0, 0, 84)
hammerBtn.BackgroundColor3 = Theme.BtnBg
hammerBtn.Text = "🔨 ВКЛЮЧИТЬ МОЛОТ"
hammerBtn.TextColor3 = Theme.StatusOffline
hammerBtn.Font = Enum.Font.GothamBold
hammerBtn.TextSize = 12
hammerBtn.BorderSizePixel = 0
Instance.new("UICorner", hammerBtn).CornerRadius = UDim.new(0, 6)

hammerBtn.MouseButton1Click:Connect(function()
    ha = not ha
    if ha then
        aa = false
        autoBtn.Text = "🤖 АВТО-ФАРМ"
        autoBtn.TextColor3 = Theme.TextSub
        autoBtn.BackgroundColor3 = Theme.BtnBg
        hammerBtn.Text = "🔨 МОЛОТ РАБОТАЕТ"
        hammerBtn.TextColor3 = Theme.StatusOnline
        hammerBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 30)
        spawn(function()
            while ha do
                doHit()
                hh = hh + 1
                statsLabel.Text = "Ударов: " .. hh .. " | Сломано: " .. cd .. " | Авто: " .. afc
                wait(0.3)
            end
        end)
    else
        hammerBtn.Text = "🔨 ВКЛЮЧИТЬ МОЛОТ"
        hammerBtn.TextColor3 = Theme.StatusOffline
        hammerBtn.BackgroundColor3 = Theme.BtnBg
    end
end)

-- ====== АВТОФАРМ ======
local autoBtn = Instance.new("TextButton", content)
autoBtn.Size = UDim2.new(1, 0, 0, 38)
autoBtn.Position = UDim2.new(0, 0, 0, 130)
autoBtn.BackgroundColor3 = Theme.BtnBg
autoBtn.Text = "🤖 АВТО-ФАРМ"
autoBtn.TextColor3 = Theme.TextSub
autoBtn.Font = Enum.Font.GothamBold
autoBtn.TextSize = 12
autoBtn.BorderSizePixel = 0
Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0, 6)

autoBtn.MouseButton1Click:Connect(function()
    aa = not aa
    if aa then
        ha = false
        hammerBtn.Text = "🔨 ВКЛЮЧИТЬ МОЛОТ"
        hammerBtn.TextColor3 = Theme.StatusOffline
        hammerBtn.BackgroundColor3 = Theme.BtnBg
        autoBtn.Text = "🤖 АВТО-ФАРМ РАБОТАЕТ"
        autoBtn.TextColor3 = Theme.StatusOnline
        autoBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 10)
        spawn(function()
            while aa do
                local c = getMyCar()
                if not c then
                    carLabel.Text = "🚗 Респавн..."
                    clickSpawn()
                    wait(3)
                else
                    local d = false
                    for i = 1, 20 do
                        if not aa then break end
                        d = doHit()
                        hh = hh + 1
                        statsLabel.Text = "Ударов: " .. hh .. " | Сломано: " .. cd .. " | Авто: " .. afc
                        if d then break end
                        wait(0.2)
                    end
                    if d then
                        afc = afc + 1
                        statsLabel.Text = "Ударов: " .. hh .. " | Сломано: " .. cd .. " | Авто: " .. afc
                        carLabel.Text = "💀 Уничтожена!"
                        wait(1)
                        carLabel.Text = "🚗 Респавн..."
                        clickSpawn()
                        wait(3)
                    end
                end
            end
        end)
    else
        autoBtn.Text = "🤖 АВТО-ФАРМ"
        autoBtn.TextColor3 = Theme.TextSub
        autoBtn.BackgroundColor3 = Theme.BtnBg
    end
end)
