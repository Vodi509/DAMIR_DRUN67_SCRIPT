-- [[ DAMIR_DRUN67 HUB v6.12 - SPAWN 75/40 ]] --

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local T = {
    Main = Color3.fromRGB(15,16,22),
    Bg = Color3.fromRGB(22,24,33),
    Green = Color3.fromRGB(0,255,163),
    Red = Color3.fromRGB(255,46,92),
    Btn = Color3.fromRGB(30,33,45),
    White = Color3.new(1,1,1),
    Grey = Color3.fromRGB(125,131,150),
    Blue = Color3.fromRGB(0,200,255),
    Purple = Color3.fromRGB(160,100,255)
}

local function getMyCar()
    local c = localPlayer.Character
    if not c then return nil end
    local h = c:FindFirstChildOfClass("Humanoid")
    if not h or not h.SeatPart then return nil end
    local cur = h.SeatPart
    while cur do
        if cur:IsA("Model") and cur.Parent and cur.Parent.Name == "Vehicles" then return cur end
        if cur:IsA("Model") and cur.Name ~= "Body" and cur.Name ~= "Engine" and cur.Name ~= "Wheels" and cur ~= c then return cur end
        cur = cur.Parent
    end
    return nil
end

local function findSpawn()
    local pg = localPlayer:WaitForChild("PlayerGui")
    for _, g in pairs(pg:GetChildren()) do
        if g:IsA("ScreenGui") then
            for _, o in pairs(g:GetDescendants()) do
                if (o:IsA("TextButton") or o:IsA("ImageButton")) and o.Visible and o.Active then
                    local t = o:IsA("TextButton") and o.Text or ""
                    if o.Name:lower():find("spawn") or t:lower():find("spawn") or t:lower():find("car") or t:lower():find("free") or t:lower():find("бесплат") or t:lower():find("спавн") then
                        if not t:lower():find("vip") and not t:lower():find("pass") then return o end
                    end
                end
            end
        end
    end
    return nil
end

local function clickSpawn()
    local b = findSpawn()
    if not b then return false end
    if firesignal and b.MouseButton1Click then pcall(function() firesignal(b.MouseButton1Click) end) end
    pcall(function()
        local v = game:GetService("VirtualInputManager")
        local p = b.AbsolutePosition + b.AbsoluteSize/2
        p = Vector2.new(p.X+75, p.Y+40)
        v:SendMouseButtonEvent(p.X, p.Y, 0, true, game, 1)
        wait(0.05)
        v:SendMouseButtonEvent(p.X, p.Y, 0, false, game, 1)
    end)
    return true
end

-- GUI
local g = localPlayer:WaitForChild("PlayerGui")
for _, v in pairs(g:GetChildren()) do if v.Name == "SpeedHub" then v:Destroy() end end
local sg = Instance.new("ScreenGui", g) sg.Name = "SpeedHub" sg.ResetOnSpawn = false

local m = Instance.new("Frame", sg)
m.AnchorPoint = Vector2.new(0.5,0.5) m.Position = UDim2.new(0.5,0,0.4,0)
m.Size = UDim2.new(0,480,0,260) m.BackgroundColor3 = T.Main m.BorderSizePixel = 0 m.Active = true m.Draggable = true
Instance.new("UICorner", m).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke", m).Thickness = 1
Instance.new("UIStroke", m).Color = Color3.fromRGB(38,42,56)

local sb = Instance.new("Frame", m)
sb.Size = UDim2.new(0,120,1,0) sb.BackgroundColor3 = T.Bg sb.BorderSizePixel = 0
Instance.new("UIStroke", sb).Thickness = 1
Instance.new("UIStroke", sb).Color = Color3.fromRGB(38,42,56)

local logo = Instance.new("TextLabel", sb)
logo.Size = UDim2.new(1,0,0,40) logo.BackgroundTransparency = 1
logo.Text = "DAMIR HUB" logo.TextColor3 = T.Red logo.Font = Enum.Font.GothamBold logo.TextSize = 14

local tb = Instance.new("TextButton", sb)
tb.Size = UDim2.new(0,100,0,30) tb.Position = UDim2.new(0,10,0,50)
tb.BackgroundColor3 = T.Purple tb.Text = "🚀 Авто Фарм" tb.TextColor3 = T.White tb.Font = Enum.Font.GothamBold tb.TextSize = 11
Instance.new("UICorner", tb).CornerRadius = UDim.new(0,4)

local ct = Instance.new("Frame", m)
ct.Position = UDim2.new(0,130,0,10) ct.Size = UDim2.new(1,-140,1,-20) ct.BackgroundTransparency = 1

local ft = Instance.new("TextLabel", ct)
ft.Size = UDim2.new(1,0,0,20) ft.BackgroundTransparency = 1
ft.Text = "ПРОГРАММА «МОЛОТ» v6.12" ft.TextColor3 = T.White ft.Font = Enum.Font.GothamBold ft.TextSize = 12 ft.TextXAlignment = Enum.TextXAlignment.Left

local cf = Instance.new("Frame", ct)
cf.Size = UDim2.new(1,0,0,32) cf.Position = UDim2.new(0,0,0,24) cf.BackgroundColor3 = T.Bg
Instance.new("UICorner", cf).CornerRadius = UDim.new(0,5)

local cl = Instance.new("TextLabel", cf)
cl.Size = UDim2.new(1,-16,1,0) cl.Position = UDim2.new(0,8,0,0) cl.BackgroundTransparency = 1
cl.Text = "🚗 Ищу машину..." cl.TextColor3 = T.Grey cl.Font = Enum.Font.GothamBold cl.TextSize = 11 cl.TextXAlignment = Enum.TextXAlignment.Left

local sl = Instance.new("TextLabel", ct)
sl.Size = UDim2.new(1,0,0,18) sl.Position = UDim2.new(0,0,0,60) sl.BackgroundTransparency = 1
sl.Text = "Ударов: 0 | Сломано: 0 | Авто: 0" sl.TextColor3 = T.Grey sl.Font = Enum.Font.Gotham sl.TextSize = 10 sl.TextXAlignment = Enum.TextXAlignment.Left

spawn(function() while wait(0.3) do pcall(function()
    local c = getMyCar()
    if c then cl.Text = "🚗 " .. c.Name cl.TextColor3 = T.Blue else cl.Text = "🚗 Сядьте в машину!" cl.TextColor3 = T.Red end
end) end end)

-- ====== МОЛОТ ======
local hammerActive = false
local autoActive = false
local hammerHits = 0
local carsDestroyed = 0
local autoCycles = 0

local function doHit()
    local c = getMyCar()
    if not c then return false end
    local r = c.PrimaryPart or c:FindFirstChildWhichIsA("BasePart")
    if not r then return false end
    r.Velocity = Vector3.zero
    r.CFrame = CFrame.new(r.Position.X, 200, r.Position.Z)
    wait(0.15)
    r.Velocity = Vector3.new(0, -1500, 0)
    wait(1.0)
    if not c.Parent then carsDestroyed = carsDestroyed + 1 return true end
    return false
end

local function hammerLoop()
    while hammerActive do
        doHit()
        hammerHits = hammerHits + 1
        sl.Text = "Ударов: "..hammerHits.." | Сломано: "..carsDestroyed.." | Авто: "..autoCycles
        wait(0.3)
    end
end

local function autoLoop()
    while autoActive do
        local c = getMyCar()
        if not c then
            cl.Text = "🚗 Респавн..."
            clickSpawn()
            wait(3)
        else
            local destroyed = false
            for i = 1, 20 do
                if not autoActive then break end
                destroyed = doHit()
                hammerHits = hammerHits + 1
                sl.Text = "Ударов: "..hammerHits.." | Сломано: "..carsDestroyed.." | Авто: "..autoCycles
                if destroyed then break end
                wait(0.2)
            end
            if destroyed then
                autoCycles = autoCycles + 1
                sl.Text = "Ударов: "..hammerHits.." | Сломано: "..carsDestroyed.." | Авто: "..autoCycles
                cl.Text = "💀 Уничтожена!"
                wait(1)
                cl.Text = "🚗 Респавн..."
                clickSpawn()
                wait(3)
            end
        end
    end
end

local hb = Instance.new("TextButton", ct)
hb.Size = UDim2.new(1,0,0,38) hb.Position = UDim2.new(0,0,0,84) hb.BackgroundColor3 = T.Btn
hb.Text = "🔨 ВКЛЮЧИТЬ МОЛОТ" hb.TextColor3 = T.Red hb.Font = Enum.Font.GothamBold hb.TextSize = 12 hb.BorderSizePixel = 0
Instance.new("UICorner", hb).CornerRadius = UDim.new(0,6)

hb.MouseButton1Click:Connect(function()
    hammerActive = not hammerActive
    if hammerActive then
        if autoActive then autoActive = false ab.Text = "🤖 АВТО-ФАРМ" ab.TextColor3 = T.Grey ab.BackgroundColor3 = T.Btn end
        hb.Text = "🔨 МОЛОТ АКТИВИРОВАН" hb.TextColor3 = T.Green hb.BackgroundColor3 = Color3.fromRGB(20,35,30)
        coroutine.wrap(hammerLoop)()
    else
        hb.Text = "🔨 ВКЛЮЧИТЬ МОЛОТ" hb.TextColor3 = T.Red hb.BackgroundColor3 = T.Btn
    end
end)

local ab = Instance.new("TextButton", ct)
ab.Size = UDim2.new(1,0,0,38) ab.Position = UDim2.new(0,0,0,130) ab.BackgroundColor3 = T.Btn
ab.Text = "🤖 АВТО-ФАРМ" ab.TextColor3 = T.Grey ab.Font = Enum.Font.GothamBold ab.TextSize = 12 ab.BorderSizePixel = 0
Instance.new("UICorner", ab).CornerRadius = UDim.new(0,6)

ab.MouseButton1Click:Connect(function()
    autoActive = not autoActive
    if autoActive then
        if hammerActive then hammerActive = false hb.Text = "🔨 ВКЛЮЧИТЬ МОЛОТ" hb.TextColor3 = T.Red hb.BackgroundColor3 = T.Btn end
        ab.Text = "🤖 АВТО-ФАРМ АКТИВИРОВАН" ab.TextColor3 = T.Green ab.BackgroundColor3 = Color3.fromRGB(40,25,10)
        coroutine.wrap(autoLoop)()
    else
        ab.Text = "🤖 АВТО-ФАРМ" ab.TextColor3 = T.Grey ab.BackgroundColor3 = T.Btn
    end
end)
