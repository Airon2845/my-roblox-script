
-- Выводим уведомление прямо на экран игры (в правом верхнем углу)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Мой тест",
    Text = "Скрипт с GitHub работает!",
    Duration = 10
    Icon = "rbxassetid://1234567890"
})

-- Давай сделаем что-то интересное: заставим твоего персонажа подпрыгнуть
local player = game.Players.LocalPlayer
if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
    player.Character.HumanoidRootPart.Velocity = Vector3.new(0, 500, 0)
end