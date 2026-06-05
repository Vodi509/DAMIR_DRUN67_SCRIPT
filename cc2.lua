-- [[ DAMIR_DRUN67 HUB v1.0 - ORIGINAL BASE ]] --

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Функция поиска машины
local function getVehicle()
    for _, v in pairs(workspace.Vehicles:GetChildren()) do
        if v:FindFirstChild("Owner") and v.Owner.Value == lp then
            return v
        end
    end
    return nil
end

-- Основной цикл Фарма v1.0
local function startFarm()
    task.spawn(function()
        while true do
            task.wait(1)
            local car = getVehicle()
            
            -- Если машины нет - спавним
            if not car then
                pcall(function() ReplicatedStorage.NetworkRemote.SpawnVehicle:InvokeServer(1) end)
                task.wait(1)
            end
            
            -- Если машина есть - телепортируем в крашер и активируем
            if car and car:FindFirstChild("PrimaryPart") then
                local crusher = workspace.Crushers:FindFirstChildWhichIsA("Folder"):GetChildren()[1]
                if crusher then
                    car.PrimaryPart.CFrame = crusher.Base.CFrame + Vector3.new(0, 5, 0)
                    pcall(function() ReplicatedStorage.NetworkRemote.TriggerCrusher:FireServer(crusher) end)
                end
            end
        end
    end)
end

startFarm()
