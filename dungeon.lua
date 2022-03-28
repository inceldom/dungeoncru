if not game:IsLoaded() then
    game.Loaded:Wait()
end
local localPlayer,remote,arg1 = game:GetService("Players").LocalPlayer,game:GetService("ReplicatedStorage"):WaitForChild("ClientServerNetwork",3):WaitForChild("MagicNetwork",3),"Swing"
local mobs,startRemote = workspace:WaitForChild("Game",3):WaitForChild("Mobs",3),game:GetService("ReplicatedStorage"):WaitForChild("DungeonEvents",3):WaitForChild("DungeonNetwork",3)
spawn(function()--they fucking make it yield
    startRemote:InvokeServer("Start")
end)
task.wait()
local function damageTick()
    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    if character and character:FindFirstChild("IsDead") then
        --character.IsDead:Destroy()--godmode
    end
    local mob = mobs:FindFirstChildOfClass("Model")
    if not mob then
        return --warn("Couldn't find a target")
    end
    local rootPart,targetPart = character.PrimaryPart,mob:FindFirstChildWhichIsA("BasePart")
    if not (rootPart and targetPart) then
        return --warn("Couldn't find the target HRP")
    end
    rootPart.CFrame = targetPart.CFrame*CFrame.new(0,7,3)
    remote:FireServer(arg1,targetPart.Position)
end
while game:GetService("RunService").RenderStepped:Wait() do
    pcall(damageTick)--I cant be asked to fix .Character
end
