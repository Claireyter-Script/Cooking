local rooms = workspace.CurrentRooms
local currentroom = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
local romer = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 5)
local pproom = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 4)
local previousroom = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 3)
local reviousroom = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 2)
local peviousroom = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 1)
local previousrom = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
local previousroo = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value + 1)

game.Workspace.CurrentRooms.ChildAdded:Connect(function()
local currentroom = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
local romer = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 5)
local pproom = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 4)
local previousroom = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 3)
local reviousroom = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 2)
local peviousroom = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 1)
local previousrom = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
local previousroo = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value + 1)
end)


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

if not romer then return end
local s = LoadCustomInstance("https://github.com/plamen6789/CustomDoorsMonsters/blob/main/A-60.rbxm?raw=true", workspace)
local entity = s:FindFirstChildWhichIsA("BasePart")
local plr = game.Players.LocalPlayer
local chr = plr.Character

entity.CFrame = romer.RoomExit.CFrame * CFrame.new(0, 2, 0)
local TweenService = game.TweenService

local RunService = game:GetService("RunService")
local kill = nil
local dmg = true

kill = RunService.RenderStepped:Connect(function()
local r = chr.HumanoidRootPart and (chr.HumanoidRootPart.Position - entity.Position).Magnitude
if r <= 50 then
if not chr:GetAttribute("Hiding") then
    dmg = false
    local main_game = require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
    game.Players.LocalPlayer.Character.Humanoid.Health -= game.Players.LocalPlayer.Character.Humanoid.Health
    game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "A-60"
    require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Jumpscares.Death)(main_game)
    
    if dmg == false then
    kill:Disconnect()
    end
    
end
end
end)

local a = game.TweenService:Create(entity, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = romer.RoomEntrance.Position + Vector3.new(0, 2, 0)})
         a:Play()
         a.Completed:Wait()
local b = game.TweenService:Create(entity, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = pproom.RoomEntrance.Position + Vector3.new(0, 2, 0)})
         b:Play()
         b.Completed:Wait()
local c = game.TweenService:Create(entity, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = previousroom.RoomEntrance.Position + Vector3.new(0, 2, 0)})
         c:Play()
         c.Completed:Wait()
local d = game.TweenService:Create(entity, TweenInfo.new(1.9, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = reviousroom.RoomEntrance.Position + Vector3.new(0, 2, 0)})
         d:Play()
         d.Completed:Wait()
local e = game.TweenService:Create(entity, TweenInfo.new(1.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = peviousroom.RoomEntrance.Position + Vector3.new(0, 2, 0)})
         e:Play()
         e.Completed:Wait()
local f = game.TweenService:Create(entity, TweenInfo.new(1.8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = previousrom.RoomEntrance.Position + Vector3.new(0, 2, 0)})
         f:Play()
         f.Completed:Wait()
local g = game.TweenService:Create(entity, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = previousroo.RoomEntrance.Position + Vector3.new(0, 2, 0)})
         g:Play()
         g.Completed:Wait()
kill:Disconnect()
entity.Anchored = false
entity.CanCollide = false
local debris = game:GetService("Debris")
debris:AddItem(s, 3)
