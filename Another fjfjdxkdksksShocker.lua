local P, Ws, Rs, Tw, Db = game:GetService("Players").LocalPlayer, workspace, game:GetService("RunService"), game:GetService("TweenService"), game:GetService("Debris")
local C = P.Character or P.CharacterAdded:Wait()
repeat C = P.Character or P.CharacterAdded:Wait() until C:FindFirstChild("HumanoidRootPart") and C:FindFirstChild("Humanoid")
local R, H = C.HumanoidRootPart, C.Humanoid

local E = game:GetObjects("rbxassetid://123057474039786")[1].shock
E.Name, E.Anchored, E.CanCollide, E.Parent = "Another Shocker", true, true, Ws

-- Light
local L = Instance.new("PointLight", E.Attachment)
L.Color, L.Brightness, L.Range = Color3.fromRGB(210,170,45), 10, 5

-- Sound
local S = E:FindFirstChild("PlaySound")
if S then S.TimePosition, S.Pitch, S.PlaybackSpeed, S.Volume = 0, 2, 0, 0; S:Play(); Tw:Create(S, TweenInfo.new(2), {PlaybackSpeed = 1, Volume = 2}):Play() end

-- Bolts
local A = E:FindFirstChild("Attachment")
local B = A and A:FindFirstChild("Bolts")
if B then
	B.Enabled = true
	B.Lifetime = NumberRange.new(1, 2)
	B.Rate = 25
	B.Rotation = NumberRange.new(-180, 180)
	B.RotSpeed = NumberRange.new(0, 3600)
	B.Speed = NumberRange.new(0, 1)
	B.SpreadAngle, B.Brightness, B.LightEmission, B.LightInfluence = Vector2.new(), 1, 0.9, 0
	B.Color = ColorSequence.new(Color3.fromRGB(255,255,0))
end

-- ParticleEmitter
local PE = A and A:FindFirstChild("ParticleEmitter")
if PE then
	PE.Enabled = true
	PE.Texture = "rbxassetid://129046659738965"
	PE.Lifetime = NumberRange.new(0.5, 2)
	PE.Rate = 20
	PE.Rotation = NumberRange.new(-5, 5)
	PE.RotSpeed = NumberRange.new(-5, 5)
	PE.Speed = NumberRange.new(0, 0)
	PE.SpreadAngle = Vector2.new()
	PE.Brightness, PE.LightEmission, PE.LightInfluence = 1, 0, 5
	PE.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,0)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,0,0)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0,255,170))
	})
end

-- Disable trail + glitch
for _,v in ipairs({"BlackTrail", "GlitchEffect"}) do
	local x = A and A:FindFirstChild(v)
	if x then x.Enabled = false end
end

-- Spawn position
local function getPos()
	local rp = RaycastParams.new()
	rp.FilterType, rp.FilterDescendantsInstances = Enum.RaycastFilterType.Blacklist, {C}
	local d = R.CFrame.LookVector * 10
	local h = Ws:Raycast(R.Position, d, rp)
	return h and h.Position - R.CFrame.LookVector * 1.5 or R.Position + R.CFrame.LookVector * 10
end
E.CFrame = CFrame.new(getPos())

-- Logic
local T, LS, ST, Atd, F = true, nil, tick(), false, false
local function isLook() local v = (E.Position - Ws.CurrentCamera.CFrame.Position).Unit return Ws.CurrentCamera.CFrame.LookVector:Dot(v) > 0.6 end
local function fall()
	if F then return end
	F, T = true, false
	Tw:Create(S, TweenInfo.new(5), {PlaybackSpeed = 0, Volume = 0}):Play()
	local tw = Tw:Create(E, TweenInfo.new(5), {CFrame = E.CFrame - Vector3.new(0,50,0)})
	tw:Play(); tw.Completed:Wait(); Db:AddItem(E, 0)
end
local function atk()
	if Atd then return end
	Atd, T = true, false
	local s = E:FindFirstChild("scawy")
	if s then
		local c = s:Clone()
		c.Parent, c.SoundId, c.Pitch = Ws, "rbxassetid://297569488", 2
		c:Play(); Db:AddItem(c, c.TimeLength + 5)
	end
	Tw:Create(E, TweenInfo.new(0.25), {CFrame = R.CFrame}):Play()
	task.wait(0.25)
	if H and H.Health > 0 then
		H:TakeDamage(math.random(10, 20))
		
		-- Color effect
		local G, P3 = Instance.new, Color3.new
		local cc = G("ColorCorrectionEffect", game.Lighting)
		cc.TintColor, cc.Saturation, cc.Contrast = P3(0,0,0), 1, 1
		task.spawn(function()
			Tw:Create(cc, TweenInfo.new(10), {TintColor = P3(1,1,1), Saturation = 0, Contrast = 0}):Play()
			task.wait(10); cc:Destroy()
		end)

		-- Red screen
		task.spawn(function()
			local g = G("ScreenGui", P:WaitForChild("PlayerGui"))
			g.Name, g.ResetOnSpawn, g.IgnoreGuiInset = "BloodEffect", false, true
			local f = G("Frame", g)
			f.Size, f.Position, f.BackgroundColor3 = UDim2.fromScale(1,1), UDim2.fromScale(0,0), P3(1,0,0)
			f.BackgroundTransparency, f.ZIndex = 1, 10
			local i = Tw:Create(f, TweenInfo.new(0.5), {BackgroundTransparency = 0.4})
			local o = Tw:Create(f, TweenInfo.new(3), {BackgroundTransparency = 1})
			i:Play(); i.Completed:Wait(); o:Play(); o.Completed:Wait(); g:Destroy()
		end)

		-- Death reason
		game:GetService("ReplicatedStorage").GameStats["Player_"..P.Name].Total.DeathCause.Value = "Another Shocker"
	end
	fall()
end

Rs.RenderStepped:Connect(function()
	if not T then return end
	local t = tick()
	if t - ST < 2 then return end
	if isLook() then
		if not LS then LS = t end
		if t - LS >= 4 then atk() end
	else
		if LS and t - LS < 4 then fall()
		elseif not LS then fall() end
	end
end)
