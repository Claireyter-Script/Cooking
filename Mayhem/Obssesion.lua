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

local latestRoom = game.ReplicatedStorage.GameData.LatestRoom.Value
local room = game.Workspace.CurrentRooms:FindFirstChild(latestRoom)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local cam = workspace.CurrentCamera
local FOV_THRESHOLD = 0.6

local s = LoadCustomInstance("https://github.com/Jahani-john/mayhem-mode/blob/main/mayhemmode-main/Greed.Obssesion.rbxm?raw=true", workspace)
s.Parent = workspace

local entity = s:FindFirstChildWhichIsA("BasePart", true)
entity.Anchored = true
entity.CanCollide = false
entity.CFrame = room:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value).CFrame * CFrame.new(0, 6, 0)

local att = entity.Attachment
att:FindFirstChild("BlackTrail").RotSpeed = NumberRange.new(360000, 360000)
local color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255))
})

for _, obj in pairs(att:GetChildren()) do
	if obj.Name == "BlackTrail" then
		obj.Rate = 9999
		obj.Lifetime = NumberRange.new(1, 5)
		obj.Speed = NumberRange.new(0, 0.5)
	elseif obj.Name == "ParticleEmitter" then
	    obj.Rate = 20
	    obj.Lifetime = NumberRange.new(0.1, 0.5)
	    obj.Speed = NumberRange.new(0, 2)
	    obj.Color = color
	end
end

entity:SetAttribute("Look", true)

task.spawn(function()
	while task.wait(0.1) do
		if not entity or not entity.Parent then
			break
		end
		
		if entity:GetAttribute("Look") == true then
			if player.Character and player.Character:FindFirstChild("Humanoid") then
				local humanoid = player.Character.Humanoid
				local lookVector = cam.CFrame.LookVector
				local dirToPart = (entity.Position - cam.CFrame.Position).Unit
				local dot = lookVector:Dot(dirToPart)

				if dot < FOV_THRESHOLD then
					humanoid:TakeDamage(3)
					game.ReplicatedStorage.GameStats["Player_".. player.Name].Total.DeathCause.Value = "Obssesion"
				end
			end
		end
	end
end)

local latestRoomVal = game.ReplicatedStorage.GameData.LatestRoom
latestRoomVal.Changed:Connect(function(newValue)
	if entity then
		entity:SetAttribute("Look", false)
	end
	if s then
		s:Destroy()
		s = nil
	end
	entity = nil
end)
