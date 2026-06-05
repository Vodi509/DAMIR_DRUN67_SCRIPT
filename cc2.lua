-- [[ DAMIR_DRUN67 HUB v4.24 - FINAL STABLE ]] --

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "Hub"
gui.ResetOnSpawn = false

-- Кот
local cat = Instance.new("ImageButton", gui)
cat.Size = UDim2.new(0,50,0,50)
cat.Position = UDim2.new(0.02,0,0.1,0)
cat.BackgroundColor3 = Color3.fromRGB(25,25,35)
cat.Image = "rbxassetid://18314115147"
cat.ScaleType = Enum.ScaleType.Fit
cat.ZIndex = 999
cat.Visible = false
Instance.new("UICorner", cat).CornerRadius = UDim.new(1,0)
Instance.new("UIStroke", cat).Color = Color3.fromRGB(160,100,255)

-- Окно
local win = Instance.new("Frame", gui)
win.Size = UDim2.new(0,280,0,210)
win.Position = UDim2.new(0.5,-140,0.3,0)
win.BackgroundColor3 = Color3.fromRGB(15,15,22)
win.BorderSizePixel = 0
win.Active = true
win.Draggable = true
win.ZIndex = 100
Instance.new("UICorner", win).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke", win).Color = Color3.fromRGB(40,40,55)

-- Заголовок
local hdr = Instance.new("Frame", win)
hdr.Size = UDim2.new(1,0,0,35)
hdr.BackgroundColor3 = Color3.fromRGB(20,20,30)
hdr.BorderSizePixel = 0
Instance.new("UICorner", hdr).CornerRadius = UDim.new(0,8)

local ttl = Instance.new("TextLabel", hdr)
ttl.Size = UDim2.new(1,-50,1,0)
ttl.Position = UDim2.new(0,12,0,0)
ttl.BackgroundTransparency = 1
ttl.Text = "DAMIR HUB v4.24"
ttl.TextColor3 = Color3.new(1,1,1)
ttl.Font = Enum.Font.GothamBold
ttl.TextSize = 14
ttl.TextXAlignment = Enum.TextXAlignment.Left

local minb = Instance.new("TextButton", hdr)
minb.Size = UDim2.new(0,28,0,28)
minb.Position = UDim2.new(1,-35,0,4)
minb.BackgroundColor3 = Color3.fromRGB(150,90,255)
minb.Text = "_"
minb.TextColor3 = Color3.new(1,1,1)
minb.Font = Enum.Font.GothamBold
minb.TextSize = 16
minb.BorderSizePixel = 0
Instance.new("UICorner", minb).CornerRadius = UDim.new(0,14)

minb.MouseButton1Click:Connect(function()
    win.Visible = false
    cat.Visible = true
end)
cat.MouseButton1Click:Connect(function()
    win.Visible = true
    cat.Visible = false
end)

-- Статус
local st = Instance.new("TextLabel", win)
st.Size = UDim2.new(1,-24,0,28)
st.Position = UDim2.new(0,12,0,45)
st.BackgroundColor3 = Color3.fromRGB(25,25,35)
st.Text = "Ready"
st.TextColor3 = Color3.new(1,1,1)
st.Font = Enum.Font.GothamBold
st.TextSize = 12
Instance.new("UICorner", st).CornerRadius = UDim.new(0,5)

-- Кнопка Молот
local active = false
local hmr = Instance.new("TextButton", win)
hmr.Size = UDim2.new(1,-24,0,38)
hmr.Position = UDim2.new(0,12,0,83)
hmr.BackgroundColor3 = Color3.fromRGB(30,30,42)
hmr.Text = "MOLOT"
hmr.TextColor3 = Color3.fromRGB(255,60,60)
hmr.Font = Enum.Font.GothamBold
hmr.TextSize = 14
hmr.BorderSizePixel = 0
Instance.new("UICorner", hmr).CornerRadius = UDim.new(0,5)

-- Кнопка Автофарм
local af = false
local abtn = Instance.new("TextButton", win)
abtn.Size = UDim2.new(1,-24,0,38)
abtn.Position = UDim2.new(0,12,0,131)
abtn.BackgroundColor3 = Color3.fromRGB(30,30,42)
abtn.Text = "AUTO FARM + RESPAWN"
abtn.TextColor3 = Color3.fromRGB(255,150,30)
abtn.Font = Enum.Font.GothamBold
abtn.TextSize = 13
abtn.BorderSizePixel = 0
Instance.new("UICorner", abtn).CornerRadius = UDim.new(0,5)

-- Счётчик
local cnt = Instance.new("TextLabel", win)
cnt.Size = UDim2.new(1,-24,0,18)
cnt.Position = UDim2.new(0,12,0,179)
cnt.BackgroundTransparency = 1
cnt.Text = "Hits: 0 | Broken: 0"
cnt.TextColor3 = Color3.fromRGB(160,160,180)
cnt.Font = Enum.Font.Gotham
cnt.TextSize = 11
cnt.TextXAlignment = Enum.TextXAlignment.Left

local hits = 0
local broken = 0

-- ==================== ФУНКЦИИ ====================
local function getCar()
    local c = player.Character
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

local function smash()
    local car = getCar()
    if not car then return false end
    local r = car.PrimaryPart or car:FindFirstChildWhichIsA("BasePart")
    if not r then return false end
    r.Velocity = Vector3.zero
    r.CFrame = CFrame.new(r.Position.X, 70, r.Position.Z)
    task.wait(0.1)
    r.Velocity = Vector3.new(0, -500, 0)
    task.wait(0.9)
    if not car.Parent then
        broken = broken + 1
        return true
    end
    return false
end

local function findSpawn()
    local pg = player:WaitForChild("PlayerGui")
    for _, g in pairs(pg:GetChildren()) do
        if g:IsA("ScreenGui") then
            for _, o in pairs(g:GetDescendants()) do
                if (o:IsA("TextButton") or o:IsA("ImageButton")) and o.Visible and o.Active then
                    local t = o:IsA("TextButton") and o.Text or ""
                    if o.Name:lower():find("spawn") or t:lower():find("spawn") or t:lower():find("car") then
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

local function spawnCar()
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

-- ==================== КНОПКИ ====================
hmr.MouseButton1Click:Connect(function()
    active = not active
    if active then
        af = false
        abtn.Text = "AUTO FARM + RESPAWN"
        abtn.TextColor3 = Color3.fromRGB(255,150,30)
        abtn.BackgroundColor3 = Color3.fromRGB(30,30,42)
        hmr.Text = "MOLOT ON"
        hmr.TextColor3 = Color3.fromRGB(0,255,150)
        hmr.BackgroundColor3 = Color3.fromRGB(15,40,30)
        spawn(function()
            while active do
                smash()
                hits = hits + 1
                cnt.Text = "Hits: " .. hits .. " | Broken: " .. broken
                st.Text = getCar() and "Smashing..." or "No car"
                task.wait(0.3)
            end
        end)
    else
        hmr.Text = "MOLOT"
        hmr.TextColor3 = Color3.fromRGB(255,60,60)
        hmr.BackgroundColor3 = Color3.fromRGB(30,30,42)
    end
end)

abtn.MouseButton1Click:Connect(function()
    af = not af
    if af then
        active = false
        hmr.Text = "MOLOT"
        hmr.TextColor3 = Color3.fromRGB(255,60,60)
        hmr.BackgroundColor3 = Color3.fromRGB(30,30,42)
        abtn.Text = "AUTO ON"
        abtn.TextColor3 = Color3.fromRGB(0,255,150)
        abtn.BackgroundColor3 = Color3.fromRGB(30,25,15)
        spawn(function()
            while af do
                if not getCar() then
                    st.Text = "Respawning..."
                    spawnCar()
                    task.wait(3)
                else
                    st.Text = "Smashing..."
                    for i = 1, 20 do
                        if not af then break end
                        local ok = smash()
                        hits = hits + 1
                        cnt.Text = "Hits: " .. hits .. " | Broken: " .. broken
                        if ok then
                            st.Text = "DESTROYED!"
                            task.wait(1)
                            st.Text = "Respawning..."
                            spawnCar()
                            task.wait(3)
                            break
                        end
                        task.wait(0.2)
                    end
                end
            end
        end)
    else
        abtn.Text = "AUTO FARM + RESPAWN"
        abtn.TextColor3 = Color3.fromRGB(255,150,30)
        abtn.BackgroundColor3 = Color3.fromRGB(30,30,42)
    end
end)

st.Text = "Ready"
