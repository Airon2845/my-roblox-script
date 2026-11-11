-- test.lua
print("Мой первый скрипт начал работу!")
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Тест",
    Text = "Скрипт успешно загружен и выполнен!",
    Duration = 5
})