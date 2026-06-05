-- [[ DAMIR_DRUN67 ULTIMATE DELTA-STYLE v11 ]] --
-- Исправленная навигация, Автофарм "Все", Delta-интерфейс

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DamirSpeedhackGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Создание Delta-стиля
local function createRounded(parent, size, pos, color)
    local frame = Instance.new("Frame", parent)
    frame.Size = size
    frame.Position = pos
    frame.BackgroundColor3 = color
    frame.BorderSizePixel = 0
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 8)
    return frame
end

local MainFrame = createRounded(ScreenGui, UDim2.new(0, 200, 0, 250), UDim2.new(0.02, 0, 0.2, 0), Color3.fromRGB(30, 30, 35))
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "DAMIR v11"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.BackgroundTransparency = 1

-- Кот-сворачиватель (круглый)
local CatBtn = Instance.new("ImageButton", ScreenGui)
CatBtn.Size = UDim2.new(0, 50, 0, 50)
CatBtn.Position = UDim2.new(0.02, 0, 0.05, 0)
CatBtn.Image = "rbxassetid://18314115147" -- Твоя иконка
CatBtn.Visible = false
CatBtn.BorderSizePixel = 0
local CatCorner = Instance.new("UICorner", CatBtn)
CatCorner.CornerRadius = UDim.new(1, 0)

-- Логика навигации
local function getBestCrusher()
    local cFolder = workspace:FindFirstChild("Crushers")
    if not cFolder then return nil end
    for _, v in pairs(cFolder:GetChildren()) do
        if v:FindFirstChild("Status") and (v.Status.Value == "Frenzy" or v.Status.Value == "Bonus") then
            return v:FindFirstChild("Base")
        end
    end
    return cFolder:GetChildren()[1]:FindFirstChild("Base")
end

-- Автофарм всего (кроме квестов)
local AutoEverything = false
local function AutoFarmLoop()
    task.spawn(function()
        while AutoEverything do
            local lp = game.Players.LocalPlayer
            local seat = lp.Character and lp.Character:FindFirstChild("Humanoid") and lp.Character.Humanoid.SeatPart
            
            if not seat then
                pcall(function() game:GetService("ReplicatedStorage").NetworkRemote.SpawnVehicle:InvokeServer(1) end)
            else
                local car = seat.Parent
                local target = getBestCrusher()
                if target then
                    car:MoveTo(target.Position)
                    task.wait(1.5)
                    car.PrimaryPart.CFrame = target.CFrame + Vector3.new(0, 5, 0)
                end
            end
            task.wait(2)
        end
    end)
end

-- Кнопка Фарм
local FarmBtn = Instance.new("TextButton", MainFrame)
FarmBtn.Size = UDim2.new(0.9, 0, 0, 40)
FarmBtn.Position = UDim2.new(0.05, 0, 0.3, 0)
FarmBtn.Text = "АВТОФАРМ ВСЕГО"
FarmBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
FarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", FarmBtn).CornerRadius = UDim.new(0, 6)

FarmBtn.MouseButton1Click:Connect(function()
    AutoEverything = not AutoEverything
    FarmBtn.BackgroundColor3 = AutoEverything and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(50, 50, 60)
    if AutoEverything then AutoFarmLoop() end
end)

-- Сворачивание
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(0.85, 0, 0, 0)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    CatBtn.Visible = true
end)

CatBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    CatBtn.Visible = false
end)

-- Подпись
local Signature = Instance.new("TextLabel", MainFrame)
Signature.Size = UDim2.new(1, 0, 0, 20)
Signature.Position = UDim2.new(0, 0, 0.85, 0)
Signature.Text = "by DAMIR_DRUN67"
Signature.TextColor3 = Color3.fromRGB(100, 100, 100)
Signature.BackgroundTransparency = 1
