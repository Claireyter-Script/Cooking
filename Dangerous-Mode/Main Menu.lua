local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FullScreenImageGui"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") -- Đặt vào PlayerGui của người chơi
local hasClicked = false

game.CoreGui.TopBarApp.TopBarApp.Enabled = false

local static = Instance.new("Frame")
static.Name = "Static"
static.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
static.BackgroundTransparency = 1
static.Size = UDim2.new(1.1, 0, 1.2, 0)
static.Position = UDim2.new(-0.1, 0, -0.15, 0)
static.BorderSizePixel = 0
static.Parent = screenGui

-- Static Image (white noise layer)
local staticImage = Instance.new("ImageLabel")
staticImage.Name = "Static"
staticImage.Size = UDim2.new(1, 0, 1, 0)
staticImage.Position = UDim2.new(0.04, 0, 0, 0)
staticImage.BackgroundTransparency = 1
staticImage.Image = "rbxassetid://90456576134510"
staticImage.ImageTransparency = 0
staticImage.Parent = static

local sprintButton = Instance.new("TextButton")
sprintButton.Size = UDim2.new(0.2, 0, 0.1, 0)
sprintButton.Position = UDim2.new(0.45, 0, 0.65, 0)
sprintButton.Text = "Play"
sprintButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
sprintButton.Parent = static
sprintButton.TextColor3  = Color3.fromRGB(255, 255, 255)
sprintButton.TextSize = 45
sprintButton.Font = Enum.Font.SciFi

local function onButtonClicked()
    if not hasClicked then
        hasClicked = true
        sprintButton.Text = "Counting..."
        sprintButton.Active = false
        local loading = ""
        
        -- Loop from 1 to 100
        for i = 1, 100 do
            loading = tostring(i) .. "%"
            sprintButton.Text = loading
            sprintButton.TextColor3  = Color3.fromRGB(150, 0, math.random(0, 150))
            task.wait(0.1)
            sprintButton.Text = ""
            task.wait(0.1)
        end
        
        sprintButton.Text = "Finished!"
        wait(2)
        screenGui:Destroy()
        game.CoreGui.TopBarApp.TopBarApp.Enabled = true
    end
end

sprintButton.MouseButton1Click:Connect(onButtonClicked)
