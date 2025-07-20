function GetRoom()
        local gruh = workspace.CurrentRooms
        return gruh:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
end

local Kill = true
local eye = game:GetObjects("rbxassetid://121121926426152")[1]
eye.Parent = game.Workspace
local eyes = eye:FindFirstChildWhichIsA("BasePart") or eye:FindFirstChildWhichIsA("Part")
eyes.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0,2,-15)
eyes.Initiate:Play()
eyes.Ambience:Play()
eyes.Ambience.PlaybackSpeed = 0.5
eyes.Ambience.Volume += 0.45
eyes.Attachment.Bite:Destroy()
eyes.Attachment.Visible = false

local d = Instance.new("PitchShiftSoundEffect",eyes.Ambience)
d.Octave = 0.5
local e = Instance.new("DistortionSoundEffect",eyes.Ambience)
e.Level = 0.75

wait(3)
task.spawn(function()
	while Kill == true do
	    task.wait(0.2)
	    local _ , camera = game.Workspace.CurrentCamera:WorldToViewportPoint(eyes.Position)
	    if camera then
    	local ray = game.Workspace:Raycast(eyes.Position,game.Players.LocalPlayer.Character.HumanoidRootPart.Position - eyes.Position)
        if ray.Instance.Parent == game.Players.LocalPlayer.Character or ray.Instance.Parent.Parent == game.Players.LocalPlayer.Character then
            	game.Players.LocalPlayer.Character.Humanoid:TakeDamage(1.5)
                eyes.Attack:Play()
	    end
    	end
	if game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then
                game.ReplicatedStorage.GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Manic Eyes"
                break end
   end
end)

game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
Kill = false
eye:Destroy()
