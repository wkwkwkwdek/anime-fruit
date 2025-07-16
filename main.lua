-- Anime Fruit OP GUI W/ Attach Check
-- DISCLAIMER: Jangan abai terhadap TOS Roblox

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local WS = game:GetService("Workspace")
local player = Players.LocalPlayer

-- Pastikan game sudah load
if not WS:FindFirstChild("Mobs") then
    warn("Workspace.Mobs tidak ditemukan! Dieksekusi ulang setelah masuk game.")
    return
end

-- Anti AFK
local vu = game:GetService("VirtualUser")
player.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

-- Settings
local Settings = {
    AutoQuest = false,
    AutoFarm = false,
    AutoSkill = false,
    AutoBoss = false,
    AutoFruit = false
}

-- Skill spam loop
spawn(function()
    while wait(0.3) do
        if Settings.AutoSkill and RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("Skill") then
            for i = 1, 4 do
                RS.Remotes.Skill:FireServer("Skill"..i)
            end
        end
    end
end)

-- Farm musuh
spawn(function()
    while wait(0.5) do
        if Settings.AutoFarm then
            for _, mob in ipairs(WS:FindFirstChild("Mobs"):GetChildren()) do
                local hrp = mob:FindFirstChild("HumanoidRootPart")
                local h = mob:FindFirstChild("Humanoid")
                if hrp and h and h.Health > 0 then
                    player.Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 12, 0)
                end
            end
        end
    end
end)

-- Quest "Kill 10 Bandits"
spawn(function()
    while wait(10) do
        if Settings.AutoQuest and RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("Quest") then
            RS.Remotes.Quest:FireServer("AcceptQuest", "Kill 10 Bandits")
        end
    end
end)

-- Boss farming
spawn(function()
    while wait(0.5) do
        if Settings.AutoBoss then
            local boss = WS:FindFirstChild("Boss")
            if boss and boss:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0)
            end
        end
    end
end)

-- Collect fruits
spawn(function()
    while wait(2) do
        if Settings.AutoFruit and WS:FindFirstChild("Drops") then
            for _, drop in ipairs(WS.Drops:GetChildren()) do
                if drop:IsA("Tool") and drop:FindFirstChild("Handle") then
                    firetouchinterest(player.Character.HumanoidRootPart, drop.Handle, 0)
                    wait()
                    firetouchinterest(player.Character.HumanoidRootPart, drop.Handle, 1)
                end
            end
        end
    end
end)

-- Buat GUI
local screen = Instance.new("ScreenGui")
screen.Parent = game.CoreGui
local frame = Instance.new("Frame", screen)
frame.Size = UDim2.new(0, 180, 0, 200)
frame.Position = UDim2.new(0, 10, 0, 100)
frame.BackgroundTransparency = 0.4
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)

local function toggleButton(name, i)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, 10 + i*35)
    btn.Text = name .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.MouseButton1Click:Connect(function()
        Settings[name] = not Settings[name]
        btn.Text = name .. (Settings[name] and ": ON" or ": OFF")
        btn.BackgroundColor3 = Settings[name] and Color3.fromRGB(0,170,0) or Color3.fromRGB(50,50,50)
    end)
end

toggleButton("AutoQuest", 0)
toggleButton("AutoFarm", 1)
toggleButton("AutoSkill", 2)
toggleButton("AutoBoss", 3)
toggleButton("AutoFruit", 4)

print("✅ Anime Fruit GUI OP: Menu siap!")
