-- [[ DAMIR_DRUN67 HUB v5.7 - NO CAT, NO IMAGES ]] --

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- ==================== ФУНКЦИИ ====================
local function getMyCar()
    local char = localPlayer.Character
    if not char then return nil end
    if char:FindFirstChild("Humanoid") and char.Humanoid.SeatPart then
        local seat = char.Humanoid.SeatPart
        if seat:IsA("VehicleSeat") then
            local car = seat:FindFirstAncestorOfClass("Model")
            if car then return car end
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

local function findSpawn()
    local pg = localPlayer:WaitForChild("PlayerGui")
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

local function clickSpawn()
    local b = findSpawn()
    if b then
        pcall(function()
            if firesignal and b.MouseButton1Click then
                firesignal(b.MouseButton1Click)
            end
        end)
        return true
    end
    return false
end

-- ==================== GUI ====================
local g = localPlayer:WaitForChild("PlayerGui")
for _, v in pairs(g:GetChildren()) do
    if v.Name == "FarmHub" then v:Destroy() end
end

local screenGui = Instance.new("ScreenGui", g)
screenGui.Name = "FarmHub"
screenGui.ResetOnSpawn = false

local main = Instance.new("Frame", screenGui)
main.Size = UDim2.new(0, 280, 0, 160)
main.Position = UDim2.new(0.5, -140, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
title.Text = "DAMIR HUB v5.7"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 8)

local status = Instance.new("TextLabel", main)
status.Size = UDim2.new(1, -20, 0, 24)
status.Position = UDim2.new(0, 10, 0, 38)
status.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
status.Text = "Готов"
status.TextColor3 = Color3.new(1, 1, 1)
status.Font = Enum.Font.GothamBold
status.TextSize = 12
Instance.new("UICorner", status).CornerRadius = UDim.new(0, 4)

local statsLabel = Instance.new("TextLabel", main)
statsLabel.Size = UDim2.new(1, -20, 0, 18)
statsLabel.Position = UDim2.new(0, 10, 0, 68)
statsLabel.BackgroundTransparency = 1
statsLabel.Text = "Ударов: 0 | Сломано: 0 | Авто: 0"
statsLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
statsLabel.Font = Enum.Font.Gotham
statsLabel.TextSize = 10
statsLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Переменные
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

local hammerBtn = Instance.new("TextButton", main)
hammerBtn.Size = UDim2.new(1, -20, 0, 34)
hammerBtn.Position = UDim2.new(0, 10, 0, 92)
hammerBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
hammerBtn.Text = "MOLOT"
hammerBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
hammerBtn.Font = Enum.Font.GothamBold
hammerBtn.TextSize = 14
Instance.new("UICorner", hammerBtn).CornerRadius = UDim.new(0, 5)

local autoBtn = Instance.new("TextButton", main)
autoBtn.Size = UDim2.new(1, -20, 0, 34)
autoBtn.Position = UDim2.new(0, 10, 0, 130)
autoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
autoBtn.Text = "AUTO"
autoBtn.TextColor3 = Color3.fromRGB(255, 150, 50)
autoBtn.Font = Enum.Font.GothamBold
autoBtn.TextSize = 14
Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0, 5)

-- Обновление статуса машины
spawn(function()
    while wait(0.5) do
        pcall(function()
            local c = getMyCar()
            if c then
                status.Text = "🚗 " .. c.Name
            else
                status.Text = "Нет машины"
            end
        end)
    end
end)

-- Молот
hammerBtn.MouseButton1Click:Connect(function()
    ha = not ha
    if ha then
        aa = false
        autoBtn.Text = "AUTO"
        autoBtn.TextColor3 = Color3.fromRGB(255, 150, 50)
        hammerBtn.Text = "MOLOT ON"
        hammerBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
        spawn(function()
            while ha do
                doHit()
                hh = hh + 1
                statsLabel.Text = "Ударов: " .. hh .. " | Сломано: " .. cd .. " | Авто: " .. afc
                wait(0.3)
            end
        end)
    else
        hammerBtn.Text = "MOLOT"
        hammerBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

-- Автофарм
autoBtn.MouseButton1Click:Connect(function()
    aa = not aa
    if aa then
        ha = false
        hammerBtn.Text = "MOLOT"
        hammerBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
        autoBtn.Text = "AUTO ON"
        autoBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
        spawn(function()
            while aa do
                local c = getMyCar()
                if not c then
                    status.Text = "Респавн..."
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
                        status.Text = "Сломана!"
                        wait(1)
                        status.Text = "Респавн..."
                        clickSpawn()
                        wait(3)
                    end
                end
            end
        end)
    else
        autoBtn.Text = "AUTO"
        autoBtn.TextColor3 = Color3.fromRGB(255, 150, 50)
    end
end)
