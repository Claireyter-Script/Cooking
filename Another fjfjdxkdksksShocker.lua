local cameraShaker = require(game.ReplicatedStorage.CameraShaker)
local camera = workspace.CurrentCamera

local camShake = cameraShaker.new(Enum.RenderPriority.Camera.Value, function(cf)
	camera.CFrame = camera.CFrame * cf
end)

camShake:Start()

function GetTime(Distance, Speed)
	return Distance / Speed
end

function LoadCustomInstance(source, parent)
	local model

	local function NormalizeGitHubURL(url)
		if url:match("^https://github.com/.+%.rbxm$") and not url:find("?raw=true") then
			return url .. "?raw=true"
		end
		return url
	end

	while task.wait() and not model do
		if type(source) == "number" or tostring(source):match("^%d+$") then
			local success, result = pcall(function()
				return game:GetObjects("rbxassetid://" .. tostring(source))[1]
			end)

			if success and result then
				model = result
			end

		elseif type(source) == "string" and source:match("^https?://") and source:match("%.rbxm") then
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

function GetRoom()
	local gruh = workspace.CurrentRooms
	return gruh:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
end

function GetLastRoom()
	local gruh = workspace.CurrentRooms
	return gruh[game.ReplicatedStorage.GameData.LatestRoom.Value + 1]
end

local moduleScripts = {
	Module_Events = require(game.ReplicatedStorage.ClientModules.Module_Events),
	Main_Game = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
}

	local s = LoadCustomInstance("https://github.com/Francisco1692qzd/OverridenEntitiesMode/blob/main/shockeryellow.rbxm?raw=true", workspace)
	local entity = s and s:FindFirstChild("Shockeeer")

	if not entity then
		return
	end
	
	local light = Instance.new("PointLight",entity.Attachment)
    light.Color = Color3.fromRGB(210, 170, 45)
    light.Brightness = 10
    light.Range = 5

	entity.Name = "Another Shocker"
	entity.CFrame = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0, 0, -10)
    entity.Attachment.ParticleEmitter.Texture = "rbxassetid://129046659738965"
    entity.Attachment.ParticleEmitter.Rate = 220
    entity.Attachment.ParticleEmitter.Speed = NumberRange.new(5, 5)
    entity.Attachment.ParticleEmitter.Brightness = 10
    
    entity.Attachment.Bolts.Rate = 120
    entity.Attachment.Bolts.RotSpeed = NumberRange.new(-3600, 3600)
    entity.Attachment.Bolts.Brightness = 10
    
    entity.Attachment.BlackTrail.Enabled = false
    
	local playSound = entity:FindFirstChild("PlaySound")
	if playSound then
		playSound.TimePosition = 0
		playSound.Pitch = 2
		playSound:Play()
	end
	
    local count = 0

    for _, obj in ipairs(s:GetChildren()) do
	if obj:IsA("Sound") and obj.Name == "PlaySound" then
        obj.Volume = 0
		obj:Destroy()
		count += 1
		if count >= 2 then
			break
		end
	end
    end
    
	local horrorScream = entity:FindFirstChild("HORROR SCREAM 15")

	local player = game.Players.LocalPlayer
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not hum or not root then return end

	local lookingStart = nil
	local runService = game:GetService("RunService")
	local tweenService = game:GetService("TweenService")
	local debris = game:GetService("Debris")

	local connection
	connection = runService.RenderStepped:Connect(function()
		if not entity or not entity:IsDescendantOf(s) then
			if connection then connection:Disconnect() end
			return
		end

		local cameraLook = camera.CFrame.LookVector
		local toEntity = (entity.Position - camera.CFrame.Position).Unit
		local dot = cameraLook:Dot(toEntity)

		if dot > 0.6 then
			if not lookingStart then
				lookingStart = tick()
			elseif tick() - lookingStart >= 7 then
				local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
				local goal = {CFrame = root.CFrame + Vector3.new(0, 0, 0)}
				local tween = tweenService:Create(entity, tweenInfo, goal)

				if horrorScream then
					horrorScream:Play()
    	                           horrorScream.Pitch = 2
                                  horrorScream.Volume = 5
                                        task.delay(2, function()
                                                horrorScream:Stop()
                                        end)
				end

				tween:Play()
				tween.Completed:Connect(function()
					if hum then
						hum.Health = hum.Health - math.random(10, 20)
						local color = Instance.new("ColorCorrectionEffect", game.Lighting)
                                 color.TintColor = Color3.fromRGB(0, 0, 0)
                                 color.Saturation = 1
                                 color.Contrast = 1
task.spawn(function()
    local a = game:GetService("TweenService"):Create(color, TweenInfo.new(10), {
        TintColor = Color3.fromRGB(255, 255, 255),
        Saturation = 0,
        Contrast = 0
    })
    a:Play()
    a.Completed:Wait()
    color:Destroy()
end)
task.spawn(function()
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "BloodEffect"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 1, 0)
frame.Position = UDim2.new(0, 0, 0, 0)
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
frame.BackgroundTransparency = 1 -- Bắt đầu ẩn hoàn toàn
frame.ZIndex = 10
frame.Parent = gui

    local TweenService = game:GetService("TweenService")
	frame.BackgroundTransparency = 1
	local fadeIn = TweenService:Create(frame, TweenInfo.new(0.5), {BackgroundTransparency = 0.4})
	local fadeOut = TweenService:Create(frame, TweenInfo.new(3), {BackgroundTransparency = 1})
	
	fadeIn:Play()
	fadeIn.Completed:Wait()
	fadeOut:Play()
    fadeOut.Completed:Wait()
    gui:Destroy()
end)
                                                camShake:Shake(cameraShaker.Presets.Explosion)
                                                game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Another Shocker"
					end
				end)

                    entity.Anchored = false
			        entity.CanCollide = false
                    debris:AddItem(s, 3)
                    
				if connection then connection:Disconnect() end
			end
		else

			lookingStart = nil
			entity.Anchored = false
			entity.CanCollide = false
			debris:AddItem(s, 3)
		end
	end)
