local s = game:GetObjects("rbxassetid://17071491370")[1]
s.Parent = game.Workspace
local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CanCollide = true
entity.Anchored = true

local att = entity.Attachment
local face = att.ParticleEmitter
local l = att.PointLight

l.Range = 1
face.Rate = 9999
face.Brightness = 2

local rooms = workspace.CurrentRooms
local a = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value + 1)
local b = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
local c = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 1)
local d = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 2)
local e = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 3)
local f = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 4)
local g = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 5)

game:GetService("RunService").Heartbeat:Connect(function()
a = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value + 1)
b = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
c = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 1)
d = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 2)
e = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 3)
f = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 4)
g = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 5)
end)

entity.CFrame = g.RoomEntrance.CFrame * CFrame.new(0,0,0)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModuleEvents = require(ReplicatedStorage.ClientModules.Module_Events)

ModuleEvents.flicker(b, 10)
    
wait(12)
for i = 1, 15 do
local to = game.TweenService:Create(entity, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = f.RoomEntrance.Position + Vector3.new(0, 0, 0)})
          to:Play()
          to.Completed:Wait()
          ModuleEvents.shatter(f)
local tos = game.TweenService:Create(entity, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = e.RoomEntrance.Position + Vector3.new(0, 0, 0)})
          tos:Play()
          tos.Completed:Wait()
          ModuleEvents.shatter(e)
local toss = game.TweenService:Create(entity, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = d.RoomEntrance.Position + Vector3.new(0, 0, 0)})
          toss:Play()
          toss.Completed:Wait()
          ModuleEvents.shatter(d)
local tosss = game.TweenService:Create(entity, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = c.RoomEntrance.Position + Vector3.new(0, 0, 0)})
          tosss:Play()
          tosss.Completed:Wait()
          ModuleEvents.shatter(c)
local tor = game.TweenService:Create(entity, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = b.RoomEntrance.Position + Vector3.new(0, 0, 0)})
          tor:Play()
          tor.Completed:Wait()
          ModuleEvents.shatter(b)
local tob = game.TweenService:Create(entity, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = a.RoomEntrance.Position + Vector3.new(0, 0, 0)})
          tob:Play()
          tob.Completed:Wait()
          ModuleEvents.shatter(a)
local hey = game.TweenService:Create(entity, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = b.RoomEntrance.Position + Vector3.new(0, 0, 0)})
          hey:Play()
          hey.Completed:Wait()
local heyy = game.TweenService:Create(entity, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = c.RoomEntrance.Position + Vector3.new(0, 0, 0)})
          heyy:Play()
          heyy.Completed:Wait()
local ngu = game.TweenService:Create(entity, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = d.RoomEntrance.Position + Vector3.new(0, 0, 0)})
          ngu:Play()
          ngu.Completed:Wait()
local ngao = game.TweenService:Create(entity, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = e.RoomEntrance.Position + Vector3.new(0, 0, 0)})
          ngao:Play()
          ngao.Completed:Wait()
local xam = game.TweenService:Create(entity, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = f.RoomEntrance.Position + Vector3.new(0, 0, 0)})
          xam:Play()
          xam.Completed:Wait()
local het = game.TweenService:Create(entity, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = g.RoomEntrance.Position + Vector3.new(0, 0, 0)})
          het:Play()
          het.Completed:Wait()
          wait(0.5)
end
s:Destroy()
