if not game:IsLoaded() then
    game.Loaded:Wait()
end
local localPlayer = game:GetService("Players").LocalPlayer
local levelStat = localPlayer:WaitForChild("leaderstats",10):WaitForChild("Level",3).Value
local modules = localPlayer:WaitForChild("PlayerGui",3):WaitForChild("PartyGui",3):WaitForChild("PartyClientScript",3)
local difficulties,selectedDifficulty = require(modules:WaitForChild("PartyOptions",3):WaitForChild("Difficulties",3)),0--pls dont rce
for i,v in next, difficulties do
    if typeof(v)=="number" and v<=levelStat then
        if v>selectedDifficulty then
            selectedDifficulty,difficultyName = v,i
        end
    end
end
--tired of writing WaitForChild I am just gonna guess its fucking loaded enough to have the party remotes by now
local partyNetwork = game:GetService("ReplicatedStorage").RemoteEvents.PartyRemotes
partyNetwork.CreateParty:FireServer("Rune Arc Kingdom",difficultyName,selectedDifficulty,true,false)
task.wait(1)
partyNetwork.MiscPartyRemote:FireServer("Start")
