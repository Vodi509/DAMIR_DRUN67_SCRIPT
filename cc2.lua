-- [[ DAMIR_DRUN67 HUB - STABLE VERSION ]] --
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- === GUI SETUP ===
local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Active = true
mainFrame.Draggable = true

-- === МОЛОТ-ЛОГИКА (УПРОЩЕННАЯ) ===
local hammerActive = false
local hammerBtn = Instance.new("TextButton", mainFrame)
hammerBtn.Size = UDim2.new(0, 280, 0, 50)
hammerBtn.Position = UDim2.new(0, 10, 0, 10)
hammerBtn.Text = "ЗАПУСТИТЬ МОЛОТ"

hammerBtn.MouseButton1Click:Connect(function()
    hammerActive = not hammerActive
    hammerBtn.Text = hammerActive and "МОЛОТ ВКЛЮЧЕН" or "ЗАПУСТИТЬ МОЛОТ"
    
    if hammerActive then
        task.spawn(function()
            while hammerActive do
                -- Прямой поиск машины в рабочем пространстве
                local myCar = nil
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Model") and (v.Name == localPlayer.Name or (v:FindFirstChild("Owner") and v.Owner.Value == localPlayer)) then
                        myCar = v
                        break
                    end
                end
                
                if myCar and myCar:FindFirstChild("PrimaryPart") then
                    local root = myCar.PrimaryPart
                    -- Телепорт в небо
                    root.CFrame = CFrame.new(root.Position.X, 700, root.Position.Z)
                    task.wait(0.5)
                    -- Удар
                    root.AssemblyLinearVelocity = Vector3.new(0, -7000, 0)
                    task.wait(2)
                    -- Респавн
                    pcall(function() ReplicatedStorage.NetworkRemote.SpawnVehicle:InvokeServer() end)
                end
                task.wait(1)
            end
        end)
    end
end)
