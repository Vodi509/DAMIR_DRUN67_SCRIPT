-- [[ DAMIR_DRUN67 HUB v4.0 - ULTIMATE EDITION ]] --

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local localPlayer = Players.LocalPlayer

-- === СТРОГАЯ ДИЗАЙН-СИСТЕМА ===
local Theme = {
    MainBg = Color3.fromRGB(15, 16, 22),
    InnerBg = Color3.fromRGB(22, 24, 33),
    StrokeDefault = Color3.fromRGB(38, 42, 56),
    StatusOnline = Color3.fromRGB(0, 255, 163),
    StatusOffline = Color3.fromRGB(255, 46, 92),
    BtnBg = Color3.fromRGB(30, 33, 45),
    AccentGlow = Color3.fromRGB(0, 200, 255)
}

-- === ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ ===
local function getMyCar()
    local char = localPlayer.Character
    if char and char:FindFirstChild("Humanoid") and char.Humanoid.SeatPart then
        local seat = char.Humanoid.SeatPart
        if seat:IsA("VehicleSeat") then
            local car = seat:FindFirstAncestorOfClass("Model")
            if car then return car end
        end
    end
    return nil
end

-- === ИНТЕРФЕЙС ===
local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
screenGui.Name = "SpeedHubDamir"

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 480, 0, 300)
mainFrame.Position = UDim2.new(0.5, -240, 0.4, -150)
mainFrame.BackgroundColor3 = Theme.MainBg
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", mainFrame).Color = Theme.StrokeDefault

-- === СЕКРЕТНАЯ ПАСХАЛКА (АУРА) ===
local auraPopup = Instance.new("ImageLabel", screenGui)
auraPopup.Size = UDim2.new(0, 250, 0, 250)
auraPopup.Position = UDim2.new(0.5, -125, 0.5, -125)
auraPopup.Image = "rbxassetid://18314115147"
auraPopup.BackgroundTransparency = 1
auraPopup.ImageTransparency = 1
auraPopup.ZIndex = 999

local auraText = Instance.new("TextLabel", auraPopup)
auraText.Size = UDim2.new(1, 0, 0, 50)
auraText.Position = UDim2.new(0, 0, 1, 0)
auraText.Text = "+10000000 AURA"
auraText.TextColor3 = Color3.fromRGB(255, 215, 0)
auraText.Font = Enum.Font.GothamBold
auraText.TextSize = 30
auraText.BackgroundTransparency = 1
auraText.TextTransparency = 1

-- === ВКЛАДКИ (РАЗВЕРНУТЫЙ КОД) ===
local container = Instance.new("Frame", mainFrame)
container.Size = UDim2.new(1, -120, 1, 0)
container.Position = UDim2.new(0, 120, 0, 0)
container.BackgroundTransparency = 1

local farmTab = Instance.new("ScrollingFrame", container)
farmTab.Size = UDim2.new(1, 0, 1, 0)
farmTab.BackgroundTransparency = 1
Instance.new("UIListLayout", farmTab).Padding = UDim.new(0, 10)

local funTab = Instance.new("ScrollingFrame", container)
funTab.Size = UDim2.new(1, 0, 1, 0)
funTab.BackgroundTransparency = 1
funTab.Visible = false
Instance.new("UIListLayout", funTab).Padding = UDim.new(0, 10)

-- === РАЗДЕЛ ФАРМА ===
local toggleBtn = Instance.new("TextButton", farmTab)
toggleBtn.Size = UDim2.new(0, 440, 0, 50)
toggleBtn.BackgroundColor3 = Theme.BtnBg
toggleBtn.Text = "ВКЛЮЧИТЬ МОЛОТ"
toggleBtn.TextColor3 = Theme.StatusOffline
toggleBtn.Font = Enum.Font.GothamBold
local hammerActive = false

toggleBtn.MouseButton1Click:Connect(function()
    hammerActive = not hammerActive
    toggleBtn.Text = hammerActive and "МОЛОТ РАБОТАЕТ (АВТО)" or "ВКЛЮЧИТЬ МОЛОТ"
    if hammerActive then
        task.spawn(function()
            while hammerActive do
                pcall(function()
                    local car = getMyCar()
                    if car and car:FindFirstChild("PrimaryPart") then
                        car.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        car.PrimaryPart.CFrame = CFrame.new(car.PrimaryPart.Position.X, 650, car.PrimaryPart.Position.Z)
                        task.wait(0.2)
                        car.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, -6000, 0)
                        task.wait(1.5)
                        game:GetService("ReplicatedStorage").NetworkRemote.SpawnVehicle:InvokeServer()
                    end
                end)
                task.wait(0.5)
            end
        end)
    end
end)

-- === РАЗДЕЛ FUN ZONE ===
local secretBtn = Instance.new("TextButton", funTab)
secretBtn.Size = UDim2.new(0, 440, 0, 50)
secretBtn.Text = "⚠️ СЕКРЕТНАЯ КНОПКА ДАМИРА"
secretBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
secretBtn.MouseButton1Click:Connect(function()
    TweenService:Create(auraPopup, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
    TweenService:Create(auraText, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    task.wait(1)
    TweenService:Create(auraPopup, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
    TweenService:Create(auraText, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
end)

-- (Добавь код вкладок/переключения сайдбара по аналогии, если нужно)
