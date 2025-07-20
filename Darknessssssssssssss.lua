local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "Darkness"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local dim = Instance.new("Frame")
dim.Size = UDim2.new(1, 0, 1, 0)
dim.Position = UDim2.new(0, 0, 0, 0)
dim.BackgroundColor3 = Color3.new(0, 0, 0)
dim.BackgroundTransparency = 1 -- bắt đầu sáng hoàn toàn
dim.ZIndex = 10
dim.Parent = gui

task.spawn(function()
	local RunService = game:GetService("RunService")
	local function monitorCharacter(char)
		local hum = char:WaitForChild("Humanoid")

		-- Xóa GUI nếu máu = 0
		hum:GetPropertyChangedSignal("Health"):Connect(function()
			if hum.Health <= 0 then
				gui:Destroy()
			end
		end)

		-- Tối dần nếu đứng yên
		RunService.Heartbeat:Connect(function()
			if hum.MoveDirection ~= Vector3.new(0, 0, 0) then
				dim.BackgroundTransparency = math.clamp(dim.BackgroundTransparency + 0.001, 0, 1)
			else
				dim.BackgroundTransparency = math.clamp(dim.BackgroundTransparency - 0.0005, 0, 1)
                
				if dim.BackgroundTransparency <= 0 then
					hum.Health = 0
					game:GetService("ReplicatedStorage").GameStats["Player_"..player.Name].Total.DeathCause.Value = "The Darkness"
				end
			end
		end)
	end

	-- Lần đầu
	if player.Character then
		monitorCharacter(player.Character)
	end

	-- Mỗi lần respawn
	player.CharacterAdded:Connect(monitorCharacter)
end)
