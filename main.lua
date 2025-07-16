-- ANTI AFK
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- AUTO SPIN FRUIT
spawn(function()
    while wait(5) do
        local remote = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes"):FindFirstChild("SpinFruit")
        if remote then
            remote:FireServer()
        end
    end
end)

-- AUTO ATTACK MOB
spawn(function()
    while wait(1) do
        for _, mob in pairs(workspace.Mobs:GetChildren()) do
            if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                wait(0.2)
                game:GetService("ReplicatedStorage").Remotes:FindFirstChild("UseSkill"):FireServer("Z")
            end
        end
    end
end)

-- AUTO COLLECT CHESTS / FRUITS
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

print("[Anime Fruit OP Script] Loaded")
