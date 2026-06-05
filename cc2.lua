-- [[ DAMIR_DRUN67 SCRIPT v3 - Status & Safety ]] --

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🛡️ DAMIR_DRUN67 SCRIPT v3",
   LoadingTitle = "Анализ состояния авто...",
   LoadingSubtitle = "by DAMIR_DRUN67",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

-- Переменная для отображения статуса
local StatusLabel = Window:CreateLabel("Статус: Проверка...")

-- Функция определения нахождения в машине
local function IsInCar()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        if character.Humanoid.SeatPart then
            return true
        end
    end
    return false
end

-- Обновление статуса в реальном времени
task.spawn(function()
    while true do
        if IsInCar() then
            StatusLabel:Set("Статус: 🚗 You in the car")
        else
            StatusLabel:Set("Статус: ❌ You not in the car")
        end
        task.wait(0.5) -- Обновляем статус каждые полсекунды
    end
end)

-- Основной Фарм с проверкой на машину
local FarmTab = Window:CreateTab("💰 Фарм", 4483362458)
local SafeCash = false

FarmTab:CreateToggle({
   Name = "Легитный автофарм (Работает только в машине)",
   CurrentValue = false,
   Callback = function(Value)
      SafeCash = Value
      if SafeCash then
          task.spawn(function()
              while SafeCash do
                  if IsInCar() then
                      -- Логика фарма здесь
                      local player = game.Players.LocalPlayer
                      local car = workspace.CarFolder:FindFirstChild(player.Name)
                      if car then
                          -- Безопасное воздействие на машину
                          pcall(function()
                             car.Body.Velocity = Vector3.new(0, -20, 0)
                          end)
                      end
                  else
                      warn("⚠️ Нельзя фармить без машины!")
                  end
                  task.wait(3.5)
              end
          end)
      end
   end,
})

Rayfield:Notify({
   Title = "Готово!",
   Content = "Скрипт v3 загружен. Статус отображается в меню.",
   Duration = 5,
})
