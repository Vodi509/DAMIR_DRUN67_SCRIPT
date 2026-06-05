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
m.Size = UDim2.new(0, 480, 0, 320)
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

-- Боковая панель
local sb = Instance.new("Frame", m)
sb.Size = UDim2.new(0, 120, 1, -36)
sb.Position = UDim2.new(0, 0, 0, 36)
sb.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
sb.BorderSizePixel = 0

local ll = Instance.new("TextLabel", sb)
ll.Size = UDim2.new(1, 0, 0, 40)
ll.BackgroundTransparency = 1
ll.Text = "DAMIR HUB"
ll.TextColor3 = Color3.fromRGB(255, 46, 92)
ll.Font = Enum.Font.GothamBold
ll.TextSize = 14

-- Контейнер
local co = Instance.new("Frame", m)
co.Position = UDim2.new(0, 130, 0, 46)
co.Size = UDim2.new(1, -140, 1, -56)
co.BackgroundTransparency = 1

-- Вкладки
local tabs = {}

local function createTab(name)
    local tf = Instance.new("ScrollingFrame", co)
    tf.Size = UDim2.new(1, 0, 1, 0)
    tf.BackgroundTransparency = 1
    tf.CanvasSize = UDim2.new(0, 0, 2, 0)
    tf.ScrollBarThickness = 2
    tf.Visible = false
    Instance.new("UIListLayout", tf).Padding = UDim.new(0, 8)
    
    local tb = Instance.new("TextButton", sb)
    tb.Size = UDim2.new(1, -16, 0, 32)
    tb.Position = UDim2.new(0, 8, 0, 45 + (#tabs * 38))
    tb.BackgroundColor3 = Color3.fromRGB(30, 33, 45)
    tb.Text = name
    tb.TextColor3 = Color3.new(1, 1, 1)
    tb.Font = Enum.Font.GothamBold
    tb.TextSize = 11
    tb.BorderSizePixel = 0
    Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 5)
    
    tb.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.Visible = false end
        tf.Visible = true
    end)
    
    table.insert(tabs, tf)
    return tf
end

local farmTab = createTab("🚀 Авто Фарм")
local funTab = createTab("🤡 Fun Zone")
tabs[1].Visible = true

-- ====== ФАРМ ======
local fT = Instance.new("TextLabel", farmTab)
fT.Size = UDim2.new(1, 0, 0, 20)
fT.BackgroundTransparency = 1
fT.Text = "ПРОГРАММА «МОЛОТ»"
fT.TextColor3 = Color3.new(1, 1, 1)
fT.Font = Enum.Font.GothamBold
fT.TextSize = 12
fT.TextXAlignment = Enum.TextXAlignment.Left

local cf = Instance.new("Frame", farmTab)
cf.Size = UDim2.new(1, 0, 0, 35)
cf.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
Instance.new("UICorner", cf).CornerRadius = UDim.new(0, 6)

local cl = Instance.new("TextLabel", cf)
cl.Size = UDim2.new(1, -20, 1, 0)
cl.Position = UDim2.new(0, 10, 0, 0)
cl.BackgroundTransparency = 1
cl.Text = "🚗 Ищу машину..."
cl.TextColor3 = Color3.fromRGB(125, 131, 150)
cl.Font = Enum.Font.GothamBold
cl.TextSize = 11
cl.TextXAlignment = Enum.TextXAlignment.Left

local sl = Instance.new("TextLabel", farmTab)
sl.Size = UDim2.new(1, 0, 0, 18)
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

-- Молот
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

local hb = Instance.new("TextButton", farmTab)
hb.Size = UDim2.new(1, 0, 0, 40)
hb.BackgroundColor3 = Color3.fromRGB(30, 33, 45)
hb.Text = "🔨 ВКЛЮЧИТЬ МОЛОТ"
hb.TextColor3 = Color3.fromRGB(255, 46, 92)
hb.Font = Enum.Font.GothamBold
hb.TextSize = 12
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

local ab = Instance.new("TextButton", farmTab)
ab.Size = UDim2.new(1, 0, 0, 40)
ab.BackgroundColor3 = Color3.fromRGB(30, 33, 45)
ab.Text = "🤖 АВТО-ФАРМ"
ab.TextColor3 = Color3.fromRGB(125, 131, 150)
ab.Font = Enum.Font.GothamBold
ab.TextSize = 12
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

-- ====== FUN ZONE ======
local fuT = Instance.new("TextLabel", funTab)
fuT.Size = UDim2.new(1, 0, 0, 20)
fuT.BackgroundTransparency = 1
fuT.Text = "💎 AURA GENERATOR"
fuT.TextColor3 = Color3.new(1, 1, 1)
fuT.Font = Enum.Font.GothamBold
fuT.TextSize = 12
fuT.TextXAlignment = Enum.TextXAlignment.Left

local aura = 0
local al = Instance.new("TextLabel", funTab)
al.Size = UDim2.new(1, 0, 0, 28)
al.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
al.Text = "💎 Аура: 0"
al.TextColor3 = Color3.fromRGB(0, 200, 255)
al.Font = Enum.Font.GothamBold
al.TextSize = 13
Instance.new("UICorner", al).CornerRadius = UDim.new(0, 6)

local aa2 = Instance.new("TextButton", funTab)
aa2.Size = UDim2.new(1, 0, 0, 42)
aa2.BackgroundColor3 = Color3.fromRGB(30, 33, 45)
aa2.Text = "✨ +1 000 000 AURA"
aa2.TextColor3 = Color3.fromRGB(255, 215, 0)
aa2.Font = Enum.Font.GothamBold
aa2.TextSize = 13
aa2.BorderSizePixel = 0
Instance.new("UICorner", aa2).CornerRadius = UDim.new(0, 6)

aa2.MouseButton1Click:Connect(function()
    aura = aura + 1000000
    al.Text = "💎 Аура: " .. aura
end)

local memes = {
    "rbxthumb://type=Asset&id=18314115147&w=150&h=150",
    "rbxthumb://type=Asset&id=6072171427&w=150&h=150",
    "rbxthumb://type=Asset&id=6072166311&w=150&h=150",
    "rbxthumb://type=Asset&id=6072153923&w=150&h=150"
}

local meI = Instance.new("ImageLabel", funTab)
meI.Size = UDim2.new(0, 140, 0, 140)
meI.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
meI.Image = memes[1]
Instance.new("UICorner", meI).CornerRadius = UDim.new(0, 6)

local meB = Instance.new("TextButton", funTab)
meB.Size = UDim2.new(1, 0, 0, 35)
meB.BackgroundColor3 = Color3.fromRGB(30, 33, 45)
meB.Text = "СЛЕДУЮЩИЙ МЕМ"
meB.TextColor3 = Color3.fromRGB(125, 131, 150)
meB.Font = Enum.Font.GothamBold
meB.TextSize = 11
meB.BorderSizePixel = 0
Instance.new("UICorner", meB).CornerRadius = UDim.new(0, 6)

meB.MouseButton1Click:Connect(function()
    meI.Image = memes[math.random(1, #memes)]
end)
