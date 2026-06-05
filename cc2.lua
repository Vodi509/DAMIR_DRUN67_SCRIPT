local p = game.Players.LocalPlayer
local g = p:WaitForChild("PlayerGui")
for _, v in pairs(g:GetChildren()) do if v.Name == "SpeedHubDamir" then v:Destroy() end end

local s = Instance.new("ScreenGui", g)
s.Name = "SpeedHubDamir"
s.ResetOnSpawn = false

-- Кот
local cat = Instance.new("ImageButton", s)
cat.Size = UDim2.new(0, 48, 0, 48)
cat.Position = UDim2.new(0.02, 0, 0.12, 0)
cat.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
cat.Image = "rbxassetid://18314115147"
cat.ScaleType = Enum.ScaleType.Fit
cat.ZIndex = 200
cat.Visible = false
cat.Active = true
cat.Draggable = true
Instance.new("UICorner", cat).CornerRadius = UDim.new(1, 0)

-- Окно
local m = Instance.new("Frame", s)
m.AnchorPoint = Vector2.new(0.5, 0.5)
m.Position = UDim2.new(0.5, 0, 0.4, 0)
m.Size = UDim2.new(0, 480, 0, 250)
m.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
m.BorderSizePixel = 0
m.Active = true
m.Draggable = true
m.ZIndex = 100
Instance.new("UICorner", m).CornerRadius = UDim.new(0, 8)

-- Заголовок
local hdr = Instance.new("Frame", m)
hdr.Size = UDim2.new(1, 0, 0, 36)
hdr.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
hdr.BorderSizePixel = 0
Instance.new("UICorner", hdr).CornerRadius = UDim.new(0, 8)

local tt = Instance.new("TextLabel", hdr)
tt.Size = UDim2.new(1, -80, 1, 0)
tt.Position = UDim2.new(0, 14, 0, 0)
tt.BackgroundTransparency = 1
tt.Text = "🐱 DAMIR HUB"
tt.TextColor3 = Color3.new(1, 1, 1)
tt.Font = Enum.Font.GothamBold
tt.TextSize = 13
tt.TextXAlignment = Enum.TextXAlignment.Left

local minb = Instance.new("TextButton", hdr)
minb.Size = UDim2.new(0, 26, 0, 26)
minb.Position = UDim2.new(1, -35, 0, 5)
minb.BackgroundColor3 = Color3.fromRGB(160, 100, 255)
minb.Text = "—"
minb.TextColor3 = Color3.new(1, 1, 1)
minb.Font = Enum.Font.GothamBold
minb.TextSize = 16
minb.BorderSizePixel = 0
Instance.new("UICorner", minb).CornerRadius = UDim.new(0, 13)

minb.MouseButton1Click:Connect(function()
    m.Visible = false
    cat.Visible = true
end)
cat.MouseButton1Click:Connect(function()
    m.Visible = true
    cat.Visible = false
end)

-- Машина
local cl = Instance.new("TextLabel", m)
cl.Size = UDim2.new(1, -30, 0, 30)
cl.Position = UDim2.new(0, 15, 0, 50)
cl.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
cl.Text = "🚗 Ищу машину..."
cl.TextColor3 = Color3.fromRGB(125, 131, 150)
cl.Font = Enum.Font.GothamBold
cl.TextSize = 12
Instance.new("UICorner", cl).CornerRadius = UDim.new(0, 5)

-- Статистика
local sl = Instance.new("TextLabel", m)
sl.Size = UDim2.new(1, -30, 0, 20)
sl.Position = UDim2.new(0, 15, 0, 90)
sl.BackgroundTransparency = 1
sl.Text = "Ударов: 0 | Сломано: 0 | Авто: 0"
sl.TextColor3 = Color3.fromRGB(125, 131, 150)
sl.Font = Enum.Font.Gotham
sl.TextSize = 10
sl.TextXAlignment = Enum.TextXAlignment.Left

-- Поиск машины
local function getCar()
    local c = p.Character
    if not c then return nil end
    local h = c:FindFirstChildOfClass("Humanoid")
    if h and h.SeatPart then
        local s = h.SeatPart
        local m = s
        while m do
            if m:IsA("Model") and m ~= c then return m end
            m = m.Parent
        end
    end
    return nil
end

task.spawn(function()
    while task.wait(0.3) do
        pcall(function()
            local c = getCar()
            if c then
                cl.Text = "🚗 " .. c.Name
                cl.TextColor3 = Color3.fromRGB(0, 200, 255)
            else
                cl.Text = "🚗 Сядьте в машину!"
                cl.TextColor3 = Color3.fromRGB(255, 46, 92)
            end
        end)
    end
end)

-- Спавн
local function findSpawn()
    local pg = p:WaitForChild("PlayerGui")
    for _, g in pairs(pg:GetChildren()) do
        if g:IsA("ScreenGui") then
            for _, o in pairs(g:GetDescendants()) do
                if (o:IsA("TextButton") or o:IsA("ImageButton")) and o.Visible and o.Active then
                    local t = o:IsA("TextButton") and o.Text or ""
                    if o.Name:lower():find("spawn") or t:lower():find("spawn") then
                        if not t:lower():find("vip") and not t:lower():find("pass") then
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
    local b = findSpawn()
    if b then
        pcall(function()
            if b.MouseButton1Click then
                firesignal(b.MouseButton1Click)
            end
        end)
        return true
    end
    return false
end

-- Переменные
local ha, aa, hh, cd, afc = false, false, 0, 0, 0

local function doHit()
    local c = getCar()
    if not c then return false end
    local r = c.PrimaryPart or c:FindFirstChildWhichIsA("BasePart")
    if not r then return false end
    r.Velocity = Vector3.zero
    r.CFrame = CFrame.new(r.Position.X, 80, r.Position.Z)
    task.wait(0.1)
    r.Velocity = Vector3.new(0, -500, 0)
    task.wait(0.8)
    if not c.Parent then
        cd = cd + 1
        return true
    end
    return false
end

-- Кнопка Молот
local hb = Instance.new("TextButton", m)
hb.Size = UDim2.new(1, -30, 0, 42)
hb.Position = UDim2.new(0, 15, 0, 120)
hb.BackgroundColor3 = Color3.fromRGB(30, 33, 45)
hb.Text = "🔨 ВКЛЮЧИТЬ МОЛОТ"
hb.TextColor3 = Color3.fromRGB(255, 46, 92)
hb.Font = Enum.Font.GothamBold
hb.TextSize = 13
hb.BorderSizePixel = 0
Instance.new("UICorner", hb).CornerRadius = UDim.new(0, 6)

hb.MouseButton1Click:Connect(function()
    ha = not ha
    if ha then
        aa = false
        ab.Text = "🤖 АВТО-ФАРМ"
        ab.TextColor3 = Color3.fromRGB(125, 131, 150)
        ab.BackgroundColor3 = Color3.fromRGB(30, 33, 45)
        hb.Text = "🔨 МОЛОТ РАБОТАЕТ"
        hb.TextColor3 = Color3.fromRGB(0, 255, 163)
        hb.BackgroundColor3 = Color3.fromRGB(20, 35, 30)
        task.spawn(function()
            while ha do
                doHit()
                hh = hh + 1
                sl.Text = "Ударов: " .. hh .. " | Сломано: " .. cd .. " | Авто: " .. afc
                task.wait(0.3)
            end
        end)
    else
        hb.Text = "🔨 ВКЛЮЧИТЬ МОЛОТ"
        hb.TextColor3 = Color3.fromRGB(255, 46, 92)
        hb.BackgroundColor3 = Color3.fromRGB(30, 33, 45)
    end
end)

-- Кнопка Автофарм
local ab = Instance.new("TextButton", m)
ab.Size = UDim2.new(1, -30, 0, 42)
ab.Position = UDim2.new(0, 15, 0, 172)
ab.BackgroundColor3 = Color3.fromRGB(30, 33, 45)
ab.Text = "🤖 АВТО-ФАРМ"
ab.TextColor3 = Color3.fromRGB(125, 131, 150)
ab.Font = Enum.Font.GothamBold
ab.TextSize = 13
ab.BorderSizePixel = 0
Instance.new("UICorner", ab).CornerRadius = UDim.new(0, 6)

ab.MouseButton1Click:Connect(function()
    aa = not aa
    if aa then
        ha = false
        hb.Text = "🔨 ВКЛЮЧИТЬ МОЛОТ"
        hb.TextColor3 = Color3.fromRGB(255, 46, 92)
        hb.BackgroundColor3 = Color3.fromRGB(30, 33, 45)
        ab.Text = "🤖 АВТО-ФАРМ РАБОТАЕТ"
        ab.TextColor3 = Color3.fromRGB(0, 255, 163)
        ab.BackgroundColor3 = Color3.fromRGB(40, 25, 10)
        task.spawn(function()
            while aa do
                local c = getCar()
                if not c then
                    cl.Text = "🚗 Респавн..."
                    clickSpawn()
                    task.wait(3)
                else
                    local d = false
                    for i = 1, 20 do
                        if not aa then break end
                        d = doHit()
                        hh = hh + 1
                        sl.Text = "Ударов: " .. hh .. " | Сломано: " .. cd .. " | Авто: " .. afc
                        if d then break end
                        task.wait(0.2)
                    end
                    if d then
                        afc = afc + 1
                        sl.Text = "Ударов: " .. hh .. " | Сломано: " .. cd .. " | Авто: " .. afc
                        cl.Text = "💀 Уничтожена!"
                        task.wait(1)
                        cl.Text = "🚗 Респавн..."
                        clickSpawn()
                        task.wait(3)
                    end
                end
            end
        end)
    else
        ab.Text = "🤖 АВТО-ФАРМ"
        ab.TextColor3 = Color3.fromRGB(125, 131, 150)
        ab.BackgroundColor3 = Color3.fromRGB(30, 33, 45)
    end
end)
