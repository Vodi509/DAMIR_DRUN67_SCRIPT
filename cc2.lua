-- [[ DAMIR_DRUN67 HUB v4.1 - RESTORED & STABILIZED ]] --

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer

local Theme = {
    MainBg = Color3.fromRGB(15, 16, 22),
    InnerBg = Color3.fromRGB(22, 24, 33),
    BtnBg = Color3.fromRGB(30, 33, 45),
    StatusOnline = Color3.fromRGB(0, 255, 163),
    StatusOffline = Color3.fromRGB(255, 46, 92),
    TextMain = Color3.fromRGB(255, 255, 255)
}

-- === ИНТЕРФЕЙС (SPEEDHUB STYLE) ===
local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 480, 0, 300)
mainFrame.Position = UDim2.new(0.5, -240, 0.5, -150)
mainFrame.BackgroundColor3 = Theme.MainBg
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

-- Вкладки
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

-- Сайдбар
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 120, 1, 0)
sidebar.BackgroundColor3 = Theme.InnerBg

local btn1 = Instance.new("TextButton", sidebar)
btn1.Size = UDim2.new(0, 100, 0, 30)
btn1.Position = UDim2.new(0, 10, 0, 50)
btn1.Text = "ФАРМ"
btn1.MouseButton1Click:Connect(function() farmTab.Visible = true; funTab.Visible = false end)

local btn2 = Instance.new("TextButton", sidebar)
btn2.Size = UDim2.new(0, 100, 0, 30)
btn2.Position = UDim2.new(0, 10, 0, 90)
btn2.Text = "FUN ZONE"
btn2.MouseButton1Click:Connect(function() farmTab.Visible = false; funTab.Visible = true end)

-- === ЛОГИКА ФАРМА ===
local hammerBtn = Instance.new("TextButton", farmTab)
hammerBtn.Size = UDim2.new(0, 340, 0, 50)
hammerBtn.Text = "ЗАПУСТИТЬ МОЛОТ"
local hammerActive = false

hammerBtn.MouseButton1Click:Connect(function()
    hammerActive = not hammerActive
    hammerBtn.Text = hammerActive and "МОЛОТ ВКЛЮЧЕН" or "ЗАПУСТИТЬ МОЛОТ"
    
    if hammerActive then
        task.spawn(function()
            while hammerActive do
                local char = lp.Character
                if char and char:FindFirstChild("Humanoid") and char.Humanoid.SeatPart then
                    local car = char.Humanoid.SeatPart:FindFirstAncestorOfClass("Model")
                    if car and car:FindFirstChild("PrimaryPart") then
                        local root = car.PrimaryPart
                        root.CFrame = root.CFrame + Vector3.new(0, 200, 0)
                        task.wait(0.5)
                        root.AssemblyLinearVelocity = Vector3.new(0, -5000, 0)
                        task.wait(2)
                        pcall(function() game:GetService("ReplicatedStorage").NetworkRemote.SpawnVehicle:InvokeServer() end)
                    end
                end
                task.wait(1)
            end
        end)
    end
end)

-- === FUN ZONE С КОТОМ ===
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

local secretBtn = Instance.new("TextButton", funTab)
secretBtn.Size = UDim2.new(0, 340, 0, 50)
secretBtn.Text = "⚠️ СЕКРЕТНАЯ КНОПКА ДАМИРА"
secretBtn.MouseButton1Click:Connect(function()
    TweenService:Create(auraPopup, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
    TweenService:Create(auraText, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    task.wait(1)
    TweenService:Create(auraPopup, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
    TweenService:Create(auraText, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
end)
