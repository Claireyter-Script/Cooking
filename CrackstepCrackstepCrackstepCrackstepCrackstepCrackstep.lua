function LoadCustomInstance(source, parent)
	local model

	-- Normalize GitHub URL if needed
	local function NormalizeGitHubURL(url)
		if url:match("^https://github.com/.+%.rbxm$") and not url:find("?raw=true") then
			return url .. "?raw=true"
		end
		return url
	end

	while task.wait() and not model do
		if type(source) == "number" or tostring(source):match("^%d+$") then
			-- Asset ID loading
		    
			local success, result = pcall(function()
				return game:GetObjects("rbxassetid://" .. tostring(source))[1]
			end)

			if success and result then
				model = result
			end

		elseif type(source) == "string" and source:match("^https?://") and source:match("%.rbxm") then
			-- GitHub URL loading
			local url = NormalizeGitHubURL(source)
			
			local success, result = pcall(function()
				local fileName = "temp_" .. tostring(math.random(100000, 999999)) .. ".rbxm"
				writefile(fileName, game:HttpGet(url))
				local obj = game:GetObjects((getcustomasset or getsynasset)(fileName))[1]
				delfile(fileName)
				return obj
			end)

			if success and result then
				model = result
			end

		else
			break
		end

		if model then
			model.Parent = parent or workspace

			for _, obj in ipairs(model:GetDescendants()) do
				if obj:IsA("Script") or obj:IsA("LocalScript") then
					obj:Destroy()
				end
			end

			pcall(function()
				model:SetAttribute("LoadedByExecutor", true)
			end)

		end
	end

	return model
end

local s = LoadCustomInstance("https://github.com/Francisco1692qzd/OverridenEntitiesMode/blob/main/crackstep.rbxm?raw=true", workspace)
s.Parent = workspace
local entity = s:FindFirstChildWhichIsA("BasePart")

local rooms = workspace.CurrentRooms
local f = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 4)
local e = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 3)
local d = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 2)                                                                                             local c = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 1)
local b = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
local a = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value + 1)

local function move(target, dur)
    if not entity or not entity.Parent then return end
    local tween_info = TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = game:GetService("TweenService"):Create(entity, tween_info, {CFrame = target})
    tween:Play()
    tween.Completed:Wait()
end

entity.CFrame = a.RoomEntrance.CFrame * CFrame.new(0, 2, -20)

coroutine.wrap(function()
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WarningGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local textLabel = Instance.new("TextLabel")
textLabel.Font = Enum.Font.Arcade
textLabel.Parent = screenGui
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.Position = UDim2.new(0, 0, 0, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Don't Move"
textLabel.TextColor3 = Color3.new(0, 0.5, 1)
textLabel.TextScaled = true

local tweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local fadeTween = tweenService:Create(textLabel, tweenInfo, {
    TextTransparency = 1
})

wait(1)
fadeTween:Play()
fadeTween.Completed:Wait()
screenGui:Destroy()
end)()

wait(3)
local hitbox = 120
local RunService = game:GetService("RunService")
local plr = game.Players.LocalPlayer
local chr = plr.Character

local stop = RunService.Heartbeat:Connect(function()
local origin = entity.Position
local direction = (chr.HumanoidRootPart.Position - origin).Unit
local ray = Ray.new(origin, direction * hitbox)
local result = workspace:Raycast(ray.Origin, ray.Direction)

     if result and result.Instance.Parent == chr then
     if chr.Humanoid.MoveDirection ~= Vector3.new(0, 0, 0) then
     chr.Humanoid.Health = 0
     game:GetService("ReplicatedStorage").GameStats["Player_"..player.Name].Total.DeathCause.Value = "Crackstep"
     end
     end
end)

move(b.RoomEntrance.CFrame * CFrame.new(0, 2, 0), 3)
move(c.RoomEntrance.CFrame * CFrame.new(0, 2, 0), 3)
move(d.RoomEntrance.CFrame * CFrame.new(0, 2, 0), 3)
move(e.RoomEntrance.CFrame * CFrame.new(0, 2, 0), 3)
move(f.RoomEntrance.CFrame * CFrame.new(0, 2, 0), 3)
s:Destroy()
stop:Disconnect()
