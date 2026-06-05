local p = game.Players.LocalPlayer
local g = p:WaitForChild("PlayerGui")
for _, v in pairs(g:GetChildren()) do if v.Name == "Hub" then v:Destroy() end end

local s = Instance.new("ScreenGui", g)
s.Name = "Hub"

-- Кот
local cat = Instance.new("ImageButton", s)
cat.Size = UDim2.new(0, 48, 0, 48)
cat.Position = UDim2.new(0.02, 0, 0.1, 0)
cat.Image = "rbxassetid://18314115147"
cat.Visible = false
Instance.new("UICorner", cat).CornerRadius = UDim.new(1, 0)

-- Окно
local m = Instance.new("Frame", s)
m.Size = UDim2.new(0, 250, 0, 180)
m.Position = UDim2.new(0.5, -125, 0.35, 0)
m.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
m.Active = true
m.Draggable = true
Instance.new("UICorner", m).CornerRadius = UDim.new(0, 8)

-- Заголовок
local h = Instance.new("TextLabel", m)
h.Size = UDim2.new(1, -40, 0, 30)
h.Position = UDim2.new(0, 10, 0, 8)
h.Text = "DAMIR HUB"
h.TextColor3 = Color3.new(1, 1, 1)
h.Font = Enum.Font.GothamBold
h.TextSize = 14

-- Свернуть
local minb = Instance.new("TextButton", m)
minb.Size = UDim2.new(0, 24, 0, 24)
minb.Position = UDim2.new(1, -30, 0, 8)
minb.Text = "_"
minb.TextColor3 = Color3.new(1, 1, 1)
minb.BackgroundColor3 = Color3.fromRGB(160, 100, 255)
Instance.new("UICorner", minb).CornerRadius = UDim.new(0, 12)

minb.MouseButton1Click:Connect(function() m.Visible = false cat.Visible = true end)
cat.MouseButton1Click:Connect(function() m.Visible = true cat.Visible = false end)

-- Статус
local st = Instance.new("TextLabel", m)
st.Size = UDim2.new(1, -20, 0, 28)
st.Position = UDim2.new(0, 10, 0, 45)
st.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
st.Text = "Готов"
st.TextColor3 = Color3.new(1, 1, 1)
st.Font = Enum.Font.GothamBold
st.TextSize = 12
Instance.new("UICorner", st).CornerRadius = UDim.new(0, 4)

-- Кнопка Молот
local ha = false
local hb = Instance.new("TextButton", m)
hb.Size = UDim2.new(1, -20, 0, 36)
hb.Position = UDim2.new(0, 10, 0, 82)
hb.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
hb.Text = "MOLOT"
hb.TextColor3 = Color3.fromRGB(255, 60, 60)
hb.Font = Enum.Font.GothamBold
hb.TextSize = 14
Instance.new("UICorner", hb).CornerRadius = UDim.new(0, 5)

-- Кнопка Авто
local aa = false
local ab = Instance.new("TextButton", m)
ab.Size = UDim2.new(1, -20, 0, 36)
ab.Position = UDim2.new(0, 10, 0, 126)
ab.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
ab.Text = "AUTO"
ab.TextColor3 = Color3.fromRGB(255, 150, 30)
ab.Font = Enum.Font.GothamBold
ab.TextSize = 14
Instance.new("UICorner", ab).CornerRadius = UDim.new(0, 5)

-- Функции
local function getCar()
    local c = p.Character
    if not c then return nil end
    local hum = c:FindFirstChildOfClass("Humanoid")
    if hum and hum.SeatPart then
        local s = hum.SeatPart
        while s do
            if s:IsA("Model") and s ~= c then return s end
            s = s.Parent
        end
    end
    return nil
end

local function hit()
    local c = getCar()
    if not c then return end
    local r = c.PrimaryPart or c:FindFirstChildWhichIsA("BasePart")
    if not r then return end
    r.Velocity = Vector3.zero
    r.CFrame = CFrame.new(r.Position.X, 80, r.Position.Z)
    task.wait(0.1)
    r.Velocity = Vector3.new(0, -500, 0)
    task.wait(0.8)
end

-- Молот
hb.MouseButton1Click:Connect(function()
    ha = not ha
    if ha then
        aa = false
        ab.Text = "AUTO"
        ab.TextColor3 = Color3.fromRGB(255, 150, 30)
        hb.Text = "MOLOT ON"
        hb.TextColor3 = Color3.fromRGB(0, 255, 150)
        spawn(function() while ha do hit() st.Text = getCar() and "Бью..." or "Нет машины" task.wait(0.3) end end)
    else
        hb.Text = "MOLOT"
        hb.TextColor3 = Color3.fromRGB(255, 60, 60)
    end
end)

-- Авто
ab.MouseButton1Click:Connect(function()
    aa = not aa
    if aa then
        ha = false
        hb.Text = "MOLOT"
        hb.TextColor3 = Color3.fromRGB(255, 60, 60)
        ab.Text = "AUTO ON"
        ab.TextColor3 = Color3.fromRGB(0, 255, 150)
        spawn(function()
            while aa do
                if not getCar() then
                    st.Text = "Нет машины"
                    task.wait(2)
                else
                    for i = 1, 20 do
                        if not aa then break end
                        hit()
                        st.Text = "Удар " .. i
                        if not getCar() then st.Text = "Сломана!" task.wait(1) break end
                        task.wait(0.2)
                    end
                end
            end
        end)
    else
        ab.Text = "AUTO"
        ab.TextColor3 = Color3.fromRGB(255, 150, 30)
    end
end)
