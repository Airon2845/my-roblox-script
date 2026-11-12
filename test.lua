local Players = game:GetService("Players")
local player = Players.LocalPlayer

local oldGui = player.PlayerGui:FindFirstChild("MyCheatMenu")
if oldGui then oldGui:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyCheatMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

-- 3. Создаем само окно (Frame) - фон меню
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 600) -- Ширина 200, высота 150 пикселей
mainFrame.Position = UDim2.new(0, 20, 0, 20) -- Отступ от левого верхнего угла (20, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Темно-серый цвет
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255) -- Белая рамка
mainFrame.Active = true -- Позволяет перетаскивать окно мышкой
mainFrame.Draggable = true 
mainFrame.Parent = screenGui

-- 4. Добавляем заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30) -- Ширина 100%, высота 30
title.BackgroundTransparency = 1 -- Прозрачный фон
title.Text = "Меню"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = mainFrame

-- 5. Создаем кнопку для включения/выключения функции
local speedButton = Instance.new("TextButton")
speedButton.Size = UDim2.new(1, -20, 0, 40) -- Ширина на весь экран минус отступы, высота 40
speedButton.Position = UDim2.new(0, 10, 0, 50) -- Чуть ниже заголовка
speedButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Красный цвет (выключено)
speedButton.Text = "Супер-скорость: ВЫКЛ"
speedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
speedButton.Font = Enum.Font.SourceSans
speedButton.TextSize = 16
speedButton.Parent = mainFrame

-- 6. Логика работы кнопки
local speedEnabled = false -- Флаг состояния (по умолчанию выключено)

speedButton.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled -- Переключаем флаг (было false, станет true)
    
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    
    if speedEnabled then
        -- Включаем
        speedButton.Text = "Супер-скорость: ВКЛ"
        speedButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50) -- Зеленый
        if humanoid then humanoid.WalkSpeed = 100 end
    else
        -- Выключаем
        speedButton.Text = "Супер-скорость: ВЫКЛ"
        speedButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Красный
        if humanoid then humanoid.WalkSpeed = 16 end -- Возвращаем обычную скорость
    end
end)