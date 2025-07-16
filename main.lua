-- Anime Fruit OP Script with GUI
-- Disclaimer: Untuk edukasi. Gunakan risiko sendiri.

-- Anti AFK
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- Settings table
local Settings = {
    AutoQuest = false,
    AutoFarm = false,
    AutoBoss = false,
    AutoDungeon = false,
    AutoChest = false
}

-- Utility fire proximity
local function firePrompt(p)
    p:InputHoldBegin()
    wait(p.HoldDuration or 0)
    p:InputHoldEnd()
end

-- Fitur utama loop
spawn(function()
    while true do
        wait(1)
        local RS = game:GetService("ReplicatedStorage")
        local Remotes = RS:FindFirstChild("Remotes")
        local plr = game.Players.LocalPlayer
        local char = plr.Character
        if not char then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        -- Auto Quest
        if Settings.AutoQuest and Remotes and Remotes:FindFirstChild("Quest") then
            Remotes.Quest:FireServer("Accept")
        end
        -- Auto Farm Mob
        if Settings.AutoFarm then
            for _, mob in ipairs(workspace:GetDescendants()) do
                local h = mob:FindFirstChild("Humanoid")
                local m = mob:FindFirstChild("HumanoidRootPart")
                if h and m and h.Health > 0 then
                    hrp.CFrame = m.CFrame * CFrame.new(0,5,0)
                    wait(0.3)
                    if Remotes and Remotes:FindFirstChild("UseSkill") then
                        Remotes.UseSkill:FireServer("Z")
                    end
                end
            end
        end
        -- Auto Boss
        if Settings.AutoBoss and workspace:FindFirstChild("Bosses") then
            for _, boss in ipairs(workspace.Bosses:GetChildren()) do
                local h = boss:FindFirstChild("Humanoid")
                local m = boss:FindFirstChild("HumanoidRootPart")
                if h and m and h.Health > 0 then
                    hrp.CFrame = m.CFrame * CFrame.new(0,5,0)
                    wait(0.3)
                    if Remotes and Remotes:FindFirstChild("UseSkill") then
                        Remotes.UseSkill:FireServer("Z")
                    end
                end
            end
        end
        -- Auto Dungeon
        if Settings.AutoDungeon then
            local ent = workspace:FindFirstChild("DungeonEntrance")
            if ent and ent:FindFirstChildWhichIsA("ProximityPrompt") then
                firePrompt(ent:FindFirstChildWhichIsA("ProximityPrompt"))
            end
        end
        -- Auto Chest / Fruit
        if Settings.AutoChest then
            for _, item in ipairs(workspace:GetDescendants()) do
                if item:IsA("Tool") or item.Name:lower():find("chest") then
                    local cd = item:FindFirstChildOfClass("ClickDetector")
                    if cd then fireclickdetector(cd) end
                end
            end
        end
    end
end)

-- GUI Toggle Menu
local screen = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", screen)
frame.Position = UDim2.new(0,50,0,200)
frame.Size = UDim2.new(0,150,0,200)
frame.BackgroundTransparency = 0.5

local function makeToggle(name, idx)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0,5,0, 5 + idx*35)
    btn.Text = name .. ": OFF"
    btn.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.MouseButton1Click:Connect(function()
        Settings[name] = not Settings[name]
        btn.Text = name .. (Settings[name] and ": ON" or ": OFF")
    end)
end

makeToggle("AutoQuest", 0)
makeToggle("AutoFarm", 1)
makeToggle("AutoBoss", 2)
makeToggle("AutoDungeon", 3)
makeToggle("AutoChest", 4)

print("[Anime Fruit OP GUI Script] Ready!")
