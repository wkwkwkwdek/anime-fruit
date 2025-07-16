-- DISCLAIMER: Hanya untuk pembelajaran. Jangan disalahgunakan!

-- ANTI AFK
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- AUTO QUEST
spawn(function()
    while wait(10) do
        local questRemote = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes"):FindFirstChild("Quest")
        if questRemote then
            questRemote:FireServer("Accept")
        end
    end
end)

-- AUTO FARM
spawn(function()
    while wait(1) do
        for _, mob in pairs(workspace.Mobs:GetChildren()) do
            if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                wait(0.3)
                game:GetService("ReplicatedStorage").Remotes:FindFirstChild("UseSkill"):FireServer("Z")
            end
        end
    end
end)

-- AUTO DUNGEON MASUK
spawn(function()
    while wait(15) do
        local entrance = workspace:FindFirstChild("DungeonEntrance")
        if entrance and entrance:FindFirstChildWhichIsA("ProximityPrompt") then
            fireproximityprompt(entrance:FindFirstChildWhichIsA("ProximityPrompt"))
        end
    end
end)

-- AUTO DUNGEON ATTACK
spawn(function()
    while wait(1) do
        local dungeon = workspace:FindFirstChild("Dungeon")
        if dungeon then
            for _, mob in pairs(dungeon:GetDescendants()) do
                if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                    wait(0.3)
                    game:GetService("ReplicatedStorage").Remotes:FindFirstChild("UseSkill"):FireServer("Z")
                end
            end
        end
    end
end)

-- AUTO CHEST / FRUIT COLLECT
spawn(function()
    while wait(3) do
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Tool") or item.Name:lower():find("chest") then
                if item:FindFirstChildOfClass("ClickDetector") then
                    fireclickdetector(item:FindFirstChildOfClass("ClickDetector"))
                end
            end
        end
    end
end)

-- AUTO BOSS
spawn(function()
    while wait(1) do
        for _, boss in pairs(workspace.Bosses:GetChildren()) do
            if boss:FindFirstChild("Humanoid") and boss:FindFirstChild("HumanoidRootPart") and boss.Humanoid.Health > 0 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                wait(0.3)
                game:GetService("ReplicatedStorage").Remotes:FindFirstChild("UseSkill"):FireServer("Z")
            end
        end
    end
end)

print("[Anime Fruit OP Script Loaded] ✅ AUTO: Quest | Farm | Dungeon | Chest | Boss")
