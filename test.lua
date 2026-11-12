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
mainFrame.Size = UDim2.new(0, 600, 0, 400) -- Ширина 200, высота 150 пикселей
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
title.Text = "Меню 1.1"
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

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 100, 1, 0)
sidebar.Position = UDim2(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
sidebar.BorderSizePixel = 1 
sidebar.BorderColor3 = Color3.fromRGB(60, 60, 60)
sidebar.Parent = mainFrame


-- Выравнивание кнопок в столбик
local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.FillDirection = Enum.FillDirection.Vertical -- Вертикально
sidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center -- По центру панели
sidebarLayout.Padding = UDim.new(0, 10) -- Отступ 10 пикселей между кнопками
sidebarLayout.Parent = sidebar

-- Кнопка вкладки 1
local tab1Button = Instance.new("TextButton")
tab1Button.Size = UDim2.new(0.9, 0, 0, 30) -- Ширина 90% от панели, высота 30
tab1Button.Text = "Движение"
tab1Button.BackgroundColor3 = Color3.fromRGB(50, 150, 50) -- Активный цвет
tab1Button.Parent = sidebar

-- Кнопка вкладки 2
local tab2Button = Instance.new("TextButton")
tab2Button.Size = UDim2.new(0.9, 0, 0, 30)
tab2Button.Text = "Визуал"
tab2Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Неактивный цвет
tab2Button.Parent = sidebar

-- Страница 1
local page1 = Instance.new("Frame")
page1.Size = UDim2.new(1, -110, 1, -10) -- Ширина: 100% минус 110 (100 левая панель + 10 отступ), Высота: 100% минус 10
page1.Position = UDim2.new(0, 105, 0, 5) -- Сдвиг вправо на 105 пикселей
page1.BackgroundTransparency = 1
page1.Visible = true
page1.Parent = mainFrame

-- Страница 2
local page2 = Instance.new("Frame")
page2.Size = UDim2.new(1, -110, 1, -10)
page2.Position = UDim2.new(0, 105, 0, 5) -- Точная копия позиции
page2.BackgroundTransparency = 1
page2.Visible = false
page2.Parent = mainFrame

local function switchTab(tabNumber)
    if tabNumber == 1 then
        page1.Visible = true
        page2.Visible = false
        tab1Button.BackgroundColor3 = Color3.fromRGB(50, 150, 50) -- Зеленый
        tab2Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)  -- Серый
    elseif tabNumber == 2 then
        page1.Visible = false
        page2.Visible = true
        tab1Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        tab2Button.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    end
end

tab1Button.MouseButton1Click:Connect(function() switchTab(1) end)
tab2Button.MouseButton1Click:Connect(function() switchTab(2) end)