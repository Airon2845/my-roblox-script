-- ============================================
-- СКЕЛЕТ BSS ХАБА (для обучения)
-- ============================================
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Удаляем старое меню, если есть
if player.PlayerGui:FindFirstChild("BSS_TestHub") then
    player.PlayerGui.BSS_TestHub:Destroy()
end

-- 1. Главный контейнер
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BSS_TestHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

-- 2. Окно меню
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 350)
mainFrame.Position = UDim2.new(0, 50, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 200, 0) -- Желтый, под пчел
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- 3. Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "BSS Test Hub (Учебный)"
title.TextColor3 = Color3.fromRGB(255, 200, 0)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = mainFrame

-- 4. Левая панель (Sidebar)
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 120, 1, -30)
sidebar.Position = UDim2.new(0, 0, 0, 30)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
sidebar.Parent = mainFrame

local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.FillDirection = Enum.FillDirection.Vertical
sidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sidebarLayout.Padding = UDim.new(0, 8)
sidebarLayout.Parent = sidebar

-- 5. Кнопки вкладок
local function createTabButton(name, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.LayoutOrder = order
    btn.Parent = sidebar
    return btn
end

local tabMainBtn = createTabButton("Главное", 1)
local tabFarmBtn = createTabButton("Фарм", 2)

-- 6. Страницы (Pages)
local function createPage()
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, -130, 1, -40)
    page.Position = UDim2.new(0, 125, 0, 35)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = mainFrame
    return page
end

local pageMain = createPage()
local pageFarm = createPage()

-- 7. Контент для "Главное"
local tpButton = Instance.new("TextButton")
tpButton.Size = UDim2.new(1, -20, 0, 40)
tpButton.Position = UDim2.new(0, 10, 0, 10)
tpButton.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
tpButton.Text = "Телепорт к Улью"
tpButton.TextColor3 = Color3.fromRGB(0, 0, 0)
tpButton.Font = Enum.Font.SourceSansBold
tpButton.Parent = pageMain

tpButton.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        -- Просто телепортируем в координаты спавна (примерные, могут отличаться)
        char.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
        print("Телепорт выполнен (примерно)")
    end
end)

-- 8. Контент для "Фарм"
local convertButton = Instance.new("TextButton")
convertButton.Size = UDim2.new(1, -20, 0, 40)
convertButton.Position = UDim2.new(0, 10, 0, 10)
convertButton.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
convertButton.Text = "Превратить пыльцу в мёд (FireServer)"
convertButton.TextColor3 = Color3.fromRGB(255, 255, 255)
convertButton.Parent = pageFarm

convertButton.MouseButton1Click:Connect(function()
    -- В BSS это событие вызывается, когда игрок нажимает кнопку в улье 
    local events = ReplicatedStorage:FindFirstChild("Events")
    if events and events:FindFirstChild("PlayerHiveCommand") then
        events.PlayerHiveCommand:FireServer("ToggleHoneyMaking")
        print("Отправлен запрос на превращение пыльцы")
    else
        warn("Событие PlayerHiveCommand не найдено!")
    end
end)

-- 9. Переключение вкладок
local function switchTab(pageToShow, btnToHighlight)
    pageMain.Visible = false
    pageFarm.Visible = false
    pageToShow.Visible = true
    
    tabMainBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tabFarmBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btnToHighlight.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
end

tabMainBtn.MouseButton1Click:Connect(function() switchTab(pageMain, tabMainBtn) end)
tabFarmBtn.MouseButton1Click:Connect(function() switchTab(pageFarm, tabFarmBtn) end)

-- Показываем первую вкладку по умолчанию
switchTab(pageMain, tabMainBtn)
