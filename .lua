local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
end)

pcall(function()
    WindUI:Notify({
        Title = "Script Executed!",
        Content = "Script Loading...",
        Duration = 2.8
    })
end)

task.wait(({0.3, 0.6, 0.9, 1.2})[math.random(1, 4)])

--// Services
local ProximityPromptService = game:GetService("ProximityPromptService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local PathfindingService = game:GetService("PathfindingService")

--// Player
local LocalPlayer = Players.LocalPlayer

--// ReplicatedStorage
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local Modules = ReplicatedStorage:WaitForChild("Modules")

--// NPC Remotes
local NPCRemotes = Remotes:WaitForChild("NPCRemotes")

local NPCArrivedAtSpot1 = NPCRemotes:WaitForChild("NPCArrivedAtSpot1")
local SoftdrinkOrdersUpdated = NPCRemotes:WaitForChild("SoftdrinkOrdersUpdated")
local AdditionalOrder = NPCRemotes:WaitForChild("AdditionalOrder")
local NPCDrink = NPCRemotes:WaitForChild("NPCDrink")

--// Shop Remotes
local ShopRemotes = Remotes:WaitForChild("ShopRemotes")

local GetShopInfo = ShopRemotes:WaitForChild("GetShopInfo")
local BuyFurniture = ShopRemotes:WaitForChild("BuyFurniture")
local ShopRestocked = ShopRemotes:WaitForChild("ShopRestocked")
local GetFurnitureInventory = ShopRemotes:WaitForChild("GetFurnitureInventory")
local BuyIngredient = ShopRemotes:WaitForChild("BuyIngredient")
local GiveSoftdrink = ShopRemotes:WaitForChild("GiveSoftdrink")

--// Counter Remotes
local CounterRemotes = Remotes:WaitForChild("CounterRemotes")

local GetCounterInfo = CounterRemotes:WaitForChild("GetCounterInfo")
local AssignNPC = CounterRemotes:WaitForChild("AssignNPC")
local RejectNPC = CounterRemotes:WaitForChild("RejectNPC")

--// Menu Remotes
local MenuRemotes = Remotes:WaitForChild("MenuRemotes")

local UnlockMenu = MenuRemotes:WaitForChild("UnlockMenu")
local ToggleMenu = MenuRemotes:WaitForChild("ToggleMenu")
local GetMenuData = MenuRemotes:WaitForChild("GetMenuData")

--// General Remotes
local RedeemCodeFolder = Remotes:WaitForChild("RedeemCode")
local RedeemCodeRemote = RedeemCodeFolder:WaitForChild("RedeemCode")

local BuyTableEvent = Remotes:WaitForChild("BuyTableEvent")
local GetUnlockedTables = Remotes:WaitForChild("GetUnlockedTables")
local PlaceFurnitureEvent = Remotes:WaitForChild("PlaceFurnitureEvent")
local UseBoostEvent = Remotes:WaitForChild("UseBoostEvent")

--// Merchant Remotes
local MerchantRemotes = Remotes:WaitForChild("MerchantRemotes")
local GetMerchantStock = MerchantRemotes:WaitForChild("GetMerchantStock")
local BuyMerchantItem = MerchantRemotes:WaitForChild("BuyMerchantItem")
local MerchantStockUpdated = MerchantRemotes:FindFirstChild("MerchantStockUpdated")

--// Merchant 2 Remotes
local Merchant2Remotes = Remotes:WaitForChild("Merchant2Remotes")

local GetMerchant2Stock = Merchant2Remotes:WaitForChild("GetMerchant2Stock")
local BuyMerchant2Item = Merchant2Remotes:WaitForChild("BuyMerchant2Item")

--// Garden Remotes
local PlantRemotes = Remotes:WaitForChild("PlantRemotes")

local GetHalamanStock = PlantRemotes:WaitForChild("GetHalamanStock")
local BuyHalamanItem = PlantRemotes:WaitForChild("BuyHalamanItem")

--// Mystery Box
local MysteryBoxRemotes = Remotes:WaitForChild("MysteryBoxRemotes")

local BuyMysteryBox = MysteryBoxRemotes:WaitForChild("BuyMysteryBox")

--// Mystery Box Notifications
local MysteryBoxNotification = Remotes:WaitForChild("Notification")
local MysteryBoxOpened = MysteryBoxNotification:WaitForChild("MysteryBoxOpened")

--// Optional / Dynamic Remotes
local HitCrocEvent = Remotes:FindFirstChild("HitCrocEvent", true)

--// Models
local Models = ReplicatedStorage:WaitForChild("Models")
local WeaponsFolder = Models:WaitForChild("Weapons")

--// Config Modules
local TableConfig = require(Modules:WaitForChild("TableConfig"))
local ChairConfig = require(Modules:WaitForChild("ChairConfig"))
local MaterialConfig = require(Modules:WaitForChild("MaterialConfig"))
local PaintConfig = require(Modules:WaitForChild("PaintConfig"))
local TileConfig = require(Modules:WaitForChild("TileConfig"))
local StoveConfig = require(Modules:WaitForChild("StoveConfig"))

local FoodConfig = require(Modules:WaitForChild("FoodConfig"))
local IngredientsConfig = require(Modules:WaitForChild("IngredientsConfig"))
local SoftdrinkConfig = require(Modules:WaitForChild("SoftdrinkConfig"))
local FurnitureConfig = require(Modules:WaitForChild("FurnitureConfig"))
local NPCConfig = require(Modules:WaitForChild("NPCConfig"))

--// Merchant Config
local MerchantConfig = require(Modules:WaitForChild("MerchantConfig"))

--// Mystery Box Config
local MysteryBoxConfig = require(Modules:WaitForChild("MysteryBoxConfig"))

--// Garden Config
local PlantConfig = require(Modules:WaitForChild("PlantConfig"))

--// Main Config
local cfg = {
    autoServe = false,
    serveMode = "Hybrid",
    autoOrder = false,
    autoRejectNPC = false,
    rejectNPCList = {},
    autoClaimCodes = false,
    autoPan = false,
    autoWash = false,
    autoSoftdrinks = false,
    autoBuyIngredients = false,

    main2AutoServe = false,
    main2AutoWash = false,

    serveDelay = 0.01,
    washDelay = 0.3,
    tweenSpeed = 26,

    -- Anti-Sync Fix Config
    antiSyncToggle = true,
    homeDelay = 2.0,
    antiSyncWhitelist = {
        ["Fast"] = true,
        ["Semi Fast"] = true
    },

    -- Merchant
    autoMerchantBuy = false,
    merchantItems = {},
    autoMerchant2Bread = false,

    -- Garden
    plantPots = {},
    plantSeeds = {},
    autoBuyPots = false,
    autoBuySeeds = false,

    autoPanV2 = false,
    panChaseStep = 8,
    panChaseDelay = 0.08,
    panChaseOffset = 1.5,

    autoQuestBubbles = false,

    walkSpeed = 16,
    infJump = false,
    noclip = false,
}

--// Custom Delays
local serveModes = {
    ["Fast"]        = { foodTp = 0.10, foodTrigger = 0.01, customerTp = 0.07, customerTrigger = 0.01, customerDelay = 0.05 },
    ["Semi Fast"]   = { foodTp = 0.18, foodTrigger = 0.02, customerTp = 0.16, customerTrigger = 0.02, customerDelay = 0.12 },
    ["Hybrid"]      = { foodTp = 0.30, foodTrigger = 0.05, customerTp = 0.35, customerTrigger = 0.05, customerDelay = 0.40 },
    ["Semi Hybrid"] = { foodTp = 0.35, foodTrigger = 0.06, customerTp = 0.38, customerTrigger = 0.06, customerDelay = 0.45 },
    ["Normal"]      = { foodTp = 0.40, foodTrigger = 0.08, customerTp = 0.45, customerTrigger = 0.08, customerDelay = 0.50 },
    ["Semi Normal"] = { foodTp = 0.45, foodTrigger = 0.10, customerTp = 0.52, customerTrigger = 0.10, customerDelay = 0.60 },
    ["Slow"]        = { foodTp = 0.55, foodTrigger = 0.15, customerTp = 0.65, customerTrigger = 0.15, customerDelay = 0.75 },
    ["Semi Slow"]   = { foodTp = 0.60, foodTrigger = 0.18, customerTp = 0.75, customerTrigger = 0.18, customerDelay = 0.85 },
    ["Legit"]       = { foodTp = 0.75, foodTrigger = 0.25, customerTp = 0.90, customerTrigger = 0.25, customerDelay = 1.00 },
    ["Semi Legit"]  = { foodTp = 0.65, foodTrigger = 0.22, customerTp = 0.80, customerTrigger = 0.22, customerDelay = 0.90 },
}

local TaskState = {
    IsBusy = false,
    CurrentAction = "Idle"
}

local function getChar()
    local character = LocalPlayer.Character
    if not character then return nil, nil, nil end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    return character, humanoid, rootPart
end

local function getPromptCFrame(prompt)
    local parent = prompt and prompt.Parent
    if not parent then return nil end

    if parent:IsA("BasePart") then
        return parent.CFrame
    elseif parent:IsA("Attachment") then
        return parent.WorldCFrame
    elseif parent:IsA("Model") then
        return parent:GetPivot()
    else
        local part = parent:FindFirstChildWhichIsA("BasePart", true)
        if part then return part.CFrame end
    end

    return nil
end

local function forceFirePrompt(prompt)
    if not prompt or not prompt.Parent then return false end

    pcall(function()
        prompt.RequiresLineOfSight = false
        prompt.MaxActivationDistance = 10
    end)

    local waitTime = 0

    while prompt and prompt.Parent and not prompt.Enabled and waitTime < 0.4 do
        task.wait(0.03)
        waitTime += 0.03
    end

    if not prompt or not prompt.Enabled then return false end

    pcall(function()
        if typeof(fireproximityprompt) == "function" then
            fireproximityprompt(prompt)
        else
            prompt:InputHoldBegin()
            task.wait(prompt.HoldDuration > 0 and prompt.HoldDuration or 0.06)
            prompt:InputHoldEnd()
        end
    end)

    return true
end

-- [[ ANTI-SYNC BACKGROUND TASK ]] --
task.spawn(function()
    while true do
        if cfg.autoServe and cfg.antiSyncToggle then
            local currentModeName = cfg.serveMode
            
            if cfg.antiSyncWhitelist[currentModeName] then
                pcall(function()
                    local Event = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TeleportHomeEvent")
                    Event:FireServer()
                end)
                task.wait(cfg.homeDelay or 2.0)
            else
                task.wait(1)
            end
        else
            task.wait(0.5)
        end
    end
end)

-- [[ TWEEN & PATHFINDING ENGINE ]] --

local function flyTweenWaypoints(targetPos)
    local char, hum, hrp = getChar()
    if not char or not hum or not hrp then return false end

    local currentPos = hrp.Position
    local yDiff = targetPos.Y - currentPos.Y
    local waypoints = {}

    if math.abs(yDiff) > 4.0 or (currentPos - targetPos).Magnitude > 25 then
        local path = PathfindingService:CreatePath({
            AgentRadius = 2.0,
            AgentHeight = 5.0,
            AgentCanJump = true,
            WaypointSpacing = 3.5
        })

        local ok = pcall(function()
            path:ComputeAsync(currentPos, targetPos)
        end)

        if ok and path.Status == Enum.PathStatus.Success then
            for _, wp in ipairs(path:GetWaypoints()) do
                table.insert(waypoints, wp.Position + Vector3.new(0, 1.6, 0))
            end
        end
    end

    if #waypoints == 0 then
        if math.abs(yDiff) > 3.0 then
            local liftY = currentPos.Y + math.max(yDiff, 3.5)
            table.insert(waypoints, Vector3.new(currentPos.X, liftY, currentPos.Z))
            table.insert(waypoints, Vector3.new(targetPos.X, liftY, targetPos.Z))
        end

        table.insert(waypoints, Vector3.new(targetPos.X, targetPos.Y + 1.6, targetPos.Z))
    end

    local activeNoclip = RunService.Stepped:Connect(function()
        if char and char.Parent then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end

            if hrp and hrp.Parent then
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
            end
        end
    end)

    local flySuccess = true

    for _, pos in ipairs(waypoints) do
        if not char or not char.Parent or not hrp or not hrp.Parent or hum.Health <= 0 then
            flySuccess = false
            break
        end

        local distance = (hrp.Position - pos).Magnitude

        if distance > 0.3 then
            local speed = math.clamp(tonumber(cfg.tweenSpeed) or 26, 12, 50)
            local duration = distance / speed
            local _, yaw, _ = hrp.CFrame:ToOrientation()
            local currentTarget = CFrame.new(pos) * CFrame.Angles(0, yaw, 0)

            local tween = TweenService:Create(
                hrp,
                TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                {CFrame = currentTarget}
            )

            tween:Play()

            local completed = false
            local conn = tween.Completed:Connect(function()
                completed = true
            end)

            while not completed and hrp and hrp.Parent do
                task.wait()
            end

            if conn then conn:Disconnect() end
        end
    end

    if activeNoclip then activeNoclip:Disconnect() end

    if hrp and hrp.Parent then
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end

    return flySuccess
end

local tpLock = false

local function acquireTp()
    while tpLock do task.wait(0.05) end
    tpLock = true
    return function() tpLock = false end
end

local function tp(cframe)
    local character = LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if rootPart then rootPart.CFrame = cframe end
end

local function getPlot()
    for _, v in ipairs(Workspace:GetChildren()) do
        if string.find(v.Name, "^Karenderya") and v:GetAttribute("Owner") == LocalPlayer.UserId then
            return v
        end
    end
    return nil
end

local function getCash()
    local ls = LocalPlayer:FindFirstChild("leaderstats")
    local cash = ls and ls:FindFirstChild("Cash")
    return cash and cash.Value or 0
end

local npcRarities = {}
local rarityExists = {}

for _, data in pairs(NPCConfig.Types) do
    if type(data) == "table" then
        local rarity = data.Rarity or "Unknown"
        if not rarityExists[rarity] then
            rarityExists[rarity] = true
            table.insert(npcRarities, rarity)
        end
    end
end

table.sort(npcRarities)

-- [[ SOFTDRINK ORDERS ]] --

local activeDrinkOrders = {}
local lastDrinkAttempt = {}
local drinkConns = {}

local function resolveDrinkKey(rawKey)
    if not rawKey then return "Kola" end

    local str = tostring(rawKey)
    local lower = str:lower():gsub("%s+", "")

    for ingName, _ in pairs(IngredientsConfig or {}) do
        if tostring(ingName):lower():gsub("%s+", "") == lower then
            return ingName
        end
    end

    if lower == "cola" or lower == "kola" then
        return IngredientsConfig["Kola"] and "Kola" or str
    elseif lower == "suprise" or lower == "surprise" then
        return IngredientsConfig["Suprise"] and "Suprise" or str
    elseif lower == "loyal" then
        return "Loyal"
    end

    return str
end

local function disconnectDrinkConns()
    for _, conn in ipairs(drinkConns) do
        pcall(function() conn:Disconnect() end)
    end
    drinkConns = {}
end

disconnectDrinkConns()

table.insert(drinkConns, SoftdrinkOrdersUpdated.OnClientEvent:Connect(function(orders)
    if type(orders) == "table" then
        activeDrinkOrders = {}

        for _, drink in pairs(orders) do
            table.insert(activeDrinkOrders, resolveDrinkKey(drink))
        end
    end
end))

table.insert(drinkConns, AdditionalOrder.OnClientEvent:Connect(function(_npcName, drinkKey)
    if drinkKey ~= nil then
        table.insert(activeDrinkOrders, resolveDrinkKey(drinkKey))
    end
end))

local drinkStats = {
    given = 0,
    state = "Watching for requests"
}

table.insert(drinkConns, NPCDrink.OnClientEvent:Connect(function(_npcName, drinkKey)
    drinkStats.given += 1
    drinkStats.state = string.format("Delivered %s!", resolveDrinkKey(drinkKey))
end))

local function buyIngredient(key)
    local ingCfg = IngredientsConfig[key]

    if not ingCfg or not ingCfg.Cost or getCash() - ingCfg.Cost < 5000 then
        return false
    end

    local ok, result = pcall(function()
        return BuyIngredient:InvokeServer(key, 1, "Cash")
    end)

    return ok and result
end

local function stepFulfillSoftdrinkOrders()
    if not cfg.autoSoftdrinks then return false end
    if #activeDrinkOrders == 0 then return false end

    local drinkKey = resolveDrinkKey(activeDrinkOrders[1])
    local now = os.clock()

    if now < (lastDrinkAttempt[drinkKey] or 0) then return false end
    lastDrinkAttempt[drinkKey] = now + 1.5

    local ingredients = LocalPlayer:FindFirstChild("Ingredients")
    local stock = ingredients and ingredients:FindFirstChild(drinkKey)

    if not stock or stock.Value <= 0 then
        if cfg.autoBuyIngredients then
            buyIngredient(drinkKey)
            task.wait(0.2)

            ingredients = LocalPlayer:FindFirstChild("Ingredients")
            stock = ingredients and ingredients:FindFirstChild(drinkKey)
        end

        if not stock or stock.Value <= 0 then
            lastDrinkAttempt[drinkKey] = now + 5
            drinkStats.state = drinkKey .. " out of stock"
            return false
        end
    end

    local ok, success, msg = pcall(function()
        return GiveSoftdrink:InvokeServer(drinkKey)
    end)

    if ok and success then
        table.remove(activeDrinkOrders, 1)
        drinkStats.given += 1
        drinkStats.state = string.format("Delivered %s!", drinkKey)
        return true
    end

    if tostring(msg):match("Nobody") or tostring(msg):match("ordered") then
        table.remove(activeDrinkOrders, 1)
    end

    drinkStats.state = string.format("%s: %s", drinkKey, tostring(msg or success))
    return false
end

local myAssignedNPCs = {}

local function trackNPC(npcId)
    if npcId and npcId ~= "" then
        myAssignedNPCs[npcId] = true
    end
end

local function isMyRunaway(npc)
    return npc
        and myAssignedNPCs[npc.Name] == true
end

task.spawn(function()
    while task.wait(1) do
        local plot = getPlot()
        local dp = plot and plot:FindFirstChild("DiningPlot1")

        if dp then
            for _, slot in ipairs(dp:GetChildren()) do
                if slot:IsA("Model") then
                    local o1 = slot:GetAttribute("OccupiedBy1")
                    local o2 = slot:GetAttribute("OccupiedBy2")

                    if o1 then
                        trackNPC(o1)
                    end

                    if o2 then
                        trackNPC(o2)
                    end
                end
            end
        end
    end
end)

local Window = WindUI:CreateWindow({
    Title = "Karinderya",
    Icon = "layout-dashboard",
    Author = "Toolkit",
    Folder = "restaurant_toolkit",
    Size = UDim2.fromOffset(720, 520),
    MinSize = Vector2.new(500, 350),
    MaxSize = Vector2.new(1200, 800),
    ToggleKey = Enum.KeyCode.LeftShift,
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 220,
    HideSearchBar = true,
    ScrollBarEnabled = true,
    Background = "rbxthumb://type=Asset&id=93118905488017&w=768&h=432",
    BackgroundImageTransparency = 0.65,
})

Window:EditOpenButton({
    Title = "Karinderya",
    Icon = "utensils",
    CornerRadius = UDim.new(0, 20),
    StrokeThickness = 1.4,
    Color = ColorSequence.new(Color3.fromHex("0B1F4D"), Color3.fromHex("02030A")),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

Window:Tag({ Title = "Premium", Icon = "crown", Color = Color3.fromHex("#0B1F4D"), Radius = 16 })
Window:Tag({ Title = "Stable v1.23.3", Icon = "git-merge", Color = Color3.fromHex("#008000"), Radius = 16 })

local HomeTab = Window:Tab({ Title = "Home", Icon = "house" })

HomeTab:Paragraph({
    Title = "Thank you for choosing to use my script!",
    Desc = "To help keep the script updated, please support me by purchasing a premium key!"
})

HomeTab:Paragraph({
    Title = "Unemployed",
    Desc = "Tiktok: knorkzykiiph"
})

local DiscordLink = "https://discord.gg/2PeDVr6pt"

HomeTab:Button({
    Title = "Join Discord",
    Desc = "Copy the Discord invite link",
    Callback = function()
        local copied = pcall(function()
            if setclipboard then
                setclipboard(DiscordLink)
            elseif toclipboard then
                toclipboard(DiscordLink)
            else
                error("Clipboard function unavailable")
            end
        end)

        if copied then
            WindUI:Notify({
                Title = "Discord Link Copied",
                Content = "Discord invite link copied to clipboard.",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "Copy Failed",
                Content = "Your executor does not support clipboard.",
                Duration = 4
            })
        end
    end
})

-- Tabs
local ImportantTab = Window:Tab({ Title = "Important", Icon = "circle-alert" })
local MainTab = Window:Tab({ Title = "Main", Icon = "utensils" })
local AlternativeTab = Window:Tab({ Title = "Alternative", Icon = "plane" })
local ShopTab = Window:Tab({ Title = "Shop", Icon = "shopping-cart" })
local IngredientsTab = Window:Tab({ Title = "Ingredients", Icon = "apple" })
local MerchantTab = Window:Tab({ Title = "Merchant", Icon = "store" })
local SettingsTab = Window:Tab({ Title = "Settings", Icon = "settings" })
local SecurityTab = Window:Tab({ Title = "Mods", Icon = "shield" })
local ConfigTab = Window:Tab({ Title = "Config", Icon = "save" })

ImportantTab:Paragraph({ Title = "Notice", Desc = "Some features are temporarily removed for now" })

ImportantTab:Paragraph({ Title = "Update when?", Desc = "The full update might take some time" })

MainTab:Select()

MainTab:Section({
    Title = "Position"
})

MainTab:Paragraph({
    Title = "Position Sync",
    Desc = "Helps reduce movement sync issues while serving and keeps your character from getting stuck during auto-serve."
})

MainTab:Toggle({
    Title = "Auto Sync",
    Desc = "Triggers position validation during auto-serve to prevent desync",
    Value = cfg.antiSyncToggle,
    Callback = function(v)
        cfg.antiSyncToggle = v
    end
})

MainTab:Dropdown({
    Title = "Whitelist Modes",
    Desc = "Select which modes trigger the sync fix",
    Values = {"Fast", "Semi Fast", "Hybrid", "Semi Hybrid", "Normal", "Semi Normal", "Slow", "Semi Slow", "Legit", "Semi Legit"},
    Value = {"Fast", "Semi Fast"},
    Multi = true,
    Callback = function(selectedList)
        cfg.antiSyncWhitelist = {}
        if type(selectedList) == "table" then
            for _, modeName in ipairs(selectedList) do
                cfg.antiSyncWhitelist[modeName] = true
            end
        end
    end
})

MainTab:Slider({
    Title = "TP Delay",
    Desc = "Set the delay before TP triggers",
    Value = {Min = 1.0, Max = 5.0, Default = cfg.homeDelay},
    Step = 0.1,
    Callback = function(value)
        cfg.homeDelay = value
    end
})

-- Main
MainTab:Section({
    Title = "Auto Serve"
})

MainTab:Paragraph({
    Title = "Serve Mode",
    Desc = "If you're experiencing slow serving, check the Serve Mode and change it to whichever mode works best for you."
})

MainTab:Toggle({
    Title = "Auto Serve Food",
    Desc = "Automatically serve prepared food",
    Value = false,
    Flag = "AutoServe",
    Callback = function(v)
        cfg.autoServe = v
    end
})

MainTab:Dropdown({
    Title = "Serve Mode",
    Desc = "Choose your Auto Serve modes",
    Values = {
        "Fast",
        "Semi Fast",
        "Hybrid",
        "Semi Hybrid",
        "Normal",
        "Semi Normal",
        "Slow",
        "Semi Slow",
        "Legit",
        "Semi Legit"
    },
    Value = cfg.serveMode,
    Flag = "ServeMode",
    Callback = function(v)
        cfg.serveMode =
            type(v) == "table"
            and (v.Value or v[1])
            or tostring(v)

        print(
            "[auto serve] mode changed to:",
            cfg.serveMode
        )
    end
})

MainTab:Toggle({
    Title = "Auto Assign Customers",
    Desc = "Automatically assign customers to tables",
    Value = false,
    Flag = "AutoOrder",
    Callback = function(v)
        cfg.autoOrder = v
    end
})

MainTab:Toggle({
    Title = "Auto Serve Drinks",
    Desc = "Automatically fulfill drink orders (Requires Chiller)",
    Value = false,
    Flag = "AutoSoftdrinks",
    Callback = function(v)
        cfg.autoSoftdrinks = v
    end
})

MainTab:Toggle({
    Title = "Auto Reject Selected Rarities",
    Desc = "Reject NPCs based on their rarity",
    Value = false,
    Flag = "AutoRejectNPC",
    Callback = function(v)
        cfg.autoRejectNPC = v
    end
})

MainTab:Dropdown({
    Title = "Reject Rarities",
    Desc = "Select which NPC rarities should be rejected",
    Values = npcRarities,
    Value = {},
    Multi = true,
    AllowNone = true,
    Flag = "RejectRarities",
    Callback = function(option)
        cfg.rejectNPCList = {}

        if type(option) == "table" then
            for _, rarity in ipairs(option) do
                cfg.rejectNPCList[rarity] = true
            end
        end
    end
})

MainTab:Section({
    Title = "Auto Wash & Pan"
})

MainTab:Toggle({
    Title = "Auto Pan",
    Desc = "Automatically hits NPCs who don't pay.",
    Value = false,
    Flag = "AutoPan",
    Callback = function(v)
        cfg.autoPan = v
    end
})

MainTab:Toggle({
    Title = "Auto Pan V2",
    Desc = "Chase runaways with 8-stud teleport steps",
    Value = cfg.autoPanV2,
    Flag = "AutoPanV2",
    Callback = function(value)
        cfg.autoPanV2 = value
    end
})

MainTab:Toggle({
    Title = "Auto Wash Dishes",
    Desc = "Automatically washes dirty dishes.",
    Value = false,
    Flag = "AutoWash",
    Callback = function(v)
        cfg.autoWash = v
    end
})

local isAssigning = false

local function processNPCAssign()
    if isAssigning or not cfg or not cfg.autoOrder then return end
    isAssigning = true

    pcall(function()
        local plot = getPlot()
        if not plot or not GetCounterInfo or not AssignNPC then return end

        local ok, npc, tbls = pcall(function()
            return GetCounterInfo:InvokeServer()
        end)

        if not ok or type(npc) ~= "table" or type(tbls) ~= "table" then return end

        local id = npc.NpcId or npc.TemplateName or ""
        local templateName = npc.TemplateName or ""
        if id == "" or templateName == "" then return end

        local npcData = NPCConfig and NPCConfig.Types and NPCConfig.Types[templateName]
        local npcRarity = npcData and npcData.Rarity or "Unknown"

        if cfg.autoRejectNPC and cfg.rejectNPCList and cfg.rejectNPCList[npcRarity] then
            if RejectNPC then
                local requestId = HttpService:GenerateGUID(false)
                pcall(function() RejectNPC:FireServer(id, requestId) end)
            end
            return
        end

        if typeof(trackNPC) == "function" then trackNPC(id) end

        for _, t in ipairs(tbls) do
            if t.Slot and t.Seat then
                local reqId = HttpService:GenerateGUID(false)
                pcall(function()
                    AssignNPC:FireServer({Slot = t.Slot, Seat = t.Seat, NpcId = id}, reqId)
                end)
                break
            end
        end
    end)

    isAssigning = false
end

if NPCArrivedAtSpot1 and NPCArrivedAtSpot1.OnClientEvent then
    NPCArrivedAtSpot1.OnClientEvent:Connect(function()
        if cfg and cfg.autoOrder then task.defer(processNPCAssign) end
    end)
end

task.spawn(function()
    while true do
        if cfg and cfg.autoOrder and not isAssigning then processNPCAssign() end
        task.wait(0.89)
    end
end)

-- [[ SERVE ]] --
local ActionBusy = false
local ActionOwner = nil

local function acquireAction(owner)
    if ActionBusy then return false end
    ActionBusy, ActionOwner = true, owner
    return true
end

local function releaseAction(owner)
    if ActionOwner == owner then
        ActionOwner, ActionBusy = nil, false
    end
end

task.spawn(function()
    while true do
        if cfg.autoServe and acquireAction("Serve") then
            local served, plot = 0, getPlot()
            local currentMode = serveModes[cfg.serveMode] or serveModes["Hybrid"]

            local function forceFirePrompt(prompt, triggerDelay)
                if not prompt or not prompt.Enabled then return false end

                return pcall(function()
                    prompt.RequiresLineOfSight = false
                    prompt.MaxActivationDistance = 9999
                    prompt.HoldDuration = 0

                    if typeof(fireproximityprompt) == "function" then
                        fireproximityprompt(prompt)
                    else
                        prompt:InputHoldBegin()
                        task.wait(triggerDelay or 0.01)
                        prompt:InputHoldEnd()
                    end
                end)
            end

            local function getPromptCFrame(prompt)
                local parent = prompt and prompt.Parent
                if not parent then return nil end
                if parent:IsA("BasePart") then return parent.CFrame end
                if parent:IsA("Attachment") then return parent.WorldCFrame end
                if parent:IsA("Model") then return parent:GetPivot() end

                local part = parent:FindFirstChildWhichIsA("BasePart", true)
                return part and part.CFrame
            end

            local function isServeableCustomerPrompt(desc)
                if not (desc:IsA("ProximityPrompt") and desc.Enabled) then
                    return false
                end

                local action = (desc.ActionText or ""):lower()
                local object = (desc.ObjectText or ""):lower()

                return string.find(action, "serve")
                    or string.find(action, "give")
                    or string.find(object, "serve")
            end

            local function findValidPromptInModel(model)
                if not model or not model:IsA("Instance") then return nil end

                for _, desc in ipairs(model:GetDescendants()) do
                    if isServeableCustomerPrompt(desc) then return desc end
                end
            end

            local function waitForPromptInModel(model, timeout)
                local startTime = os.clock()

                while os.clock() - startTime < (timeout or 0.3) do
                    local foundPrompt = findValidPromptInModel(model)
                    if foundPrompt then return foundPrompt end
                    task.wait(0.03)
                end

                return nil
            end

            local function servePrompt(desc, tpWaitDelay, triggerDelay, postWaitDelay, targetModel)
                if IsWashingBusy then return false end

                local target = getPromptCFrame(desc)
                if not target then return false end

                local release = acquireTp()
                tp(target * CFrame.new(0, 3, 0))

                if tpWaitDelay and tpWaitDelay > 0 then
                    task.wait(tpWaitDelay)
                end

                local promptToFire

                if targetModel then
                    promptToFire = waitForPromptInModel(targetModel, 0.3)
                elseif desc and desc.Parent and desc.Enabled then
                    promptToFire = desc
                end

                local wasServed = false

                if promptToFire and promptToFire.Parent and promptToFire.Enabled then
                    if forceFirePrompt(promptToFire, triggerDelay) then
                        task.wait(triggerDelay and triggerDelay > 0 and triggerDelay or 0.02)
                        served += 1
                        wasServed = true
                    end
                end

                release()

                if wasServed and postWaitDelay and postWaitDelay > 0 then
                    task.wait(postWaitDelay)
                end

                return wasServed
            end

            if plot and not IsWashingBusy then
                local serve = plot:FindFirstChild("Serve")

                if serve then
                    for _, desc in ipairs(serve:GetDescendants()) do
                        if served >= 8 or IsWashingBusy then break end

                        if desc:IsA("ProximityPrompt") and desc.Enabled then
                            local shouldSkip = false

                            -- 1. Check kung Y-axis ay below 4
                            local targetCFrame = getPromptCFrame(desc)
                            if targetCFrame and targetCFrame.Position.Y < 4 then
                                shouldSkip = true
                            end

                            -- 2. Check kung nakapaloob sa folder na EXACTLY 13 - BLOCKED & IGNORED
                            if not shouldSkip then
                                local current = desc.Parent
                                while current and current ~= serve do
                                    if current.Name == "13" then
                                        shouldSkip = true
                                        break
                                    end
                                    current = current.Parent
                                end
                            end

                            -- 3. Check kung valid target:
                            -- a) Model na nagsisimula sa "Cooked_" ang pangalan
                            -- b) ProximityPrompt na nasa loob ng isang BasePart
                            if not shouldSkip then
                                local isValidTarget = false
                                local parent = desc.Parent

                                local topModel = desc:FindFirstAncestorOfClass("Model")
                                if topModel and topModel.Name:sub(1, 7) == "Cooked_" then
                                    isValidTarget = true
                                elseif parent and parent:IsA("BasePart") then
                                    isValidTarget = true
                                end

                                if not isValidTarget then
                                    shouldSkip = true
                                end
                            end

                            -- Kung hindi na-block ng conditions, i-execute ang servePrompt
                            if not shouldSkip then
                                servePrompt(desc, currentMode.foodTp, currentMode.foodTrigger, 0, nil)
                            end
                        end
                    end
                end

                local dp = plot:FindFirstChild("DiningPlot1")

                if dp and not IsWashingBusy then
                    for _, slot in ipairs(dp:GetChildren()) do
                        if served >= 8 or IsWashingBusy then break end

                        if slot:IsA("Model") then
                            for _, desc in ipairs(slot:GetDescendants()) do
                                if served >= 8 or IsWashingBusy then break end

                                if isServeableCustomerPrompt(desc) then
                                    servePrompt(
                                        desc,
                                        currentMode.customerTp,
                                        currentMode.customerTrigger,
                                        currentMode.customerDelay,
                                        slot
                                    )
                                end
                            end
                        end
                    end
                end
            end

            -- Softdrinks Handler
            if cfg.autoSoftdrinks then
                for _ = 1, 5 do
                    if not stepFulfillSoftdrinkOrders() then break end
                    task.wait(0.02)
                end
            end

            releaseAction("Serve")
        end

        task.wait(0.05)
    end
end)


-- Wash 
task.spawn(function()
    while true do
        if cfg.autoWash and acquireAction("Wash") then
            local plot = getPlot()

            if plot then
                local sink = plot:FindFirstChild("Sink")
                local collectAreas = {}
                local dp = plot:FindFirstChild("DiningPlot1")

                if dp then table.insert(collectAreas, dp) end

                local serve = plot:FindFirstChild("Serve")
                if serve then table.insert(collectAreas, serve) end

                for _, area in ipairs(collectAreas) do
                    if not cfg.autoWash then break end

                    for _, desc in ipairs(area:GetDescendants()) do
                        if not cfg.autoWash then break end

                        if desc:IsA("ProximityPrompt") and desc.Enabled then
                            local action = desc.ActionText:lower()
                            local obj = desc.ObjectText:lower()

                            if string.find(obj, "dirty")
                                or string.find(obj, "dish")
                                or string.find(action, "wash")
                                or string.find(action, "pick") then

                                local pp = desc.Parent

                                if pp and pp:IsA("BasePart") then
                                    local release = acquireTp()
                                    tp(pp.CFrame * CFrame.new(0, 3, 0))
                                    task.wait(0.12)

                                    pcall(function()
                                        if desc.Enabled then fireproximityprompt(desc) end
                                    end)

                                    release()
                                    task.wait(0.3)

                                    local gotTool = false

                                    for _ = 1, 20 do
                                        local c = LocalPlayer.Character
                                        if c and c:FindFirstChildOfClass("Tool") then
                                            gotTool = true
                                            break
                                        end
                                        task.wait(0.1)
                                    end

                                    if gotTool and sink and cfg.autoWash then
                                        task.wait(0.15)

                                        for _, pd in ipairs(sink:GetDescendants()) do
                                            if pd:IsA("ProximityPrompt") and pd.Enabled then
                                                local a = pd.ActionText:lower()

                                                if string.find(a, "put")
                                                    or string.find(a, "place")
                                                    or pd.Name == "Put" then

                                                    local r2 = acquireTp()
                                                    local parent = pd.Parent

                                                    if parent and parent:IsA("BasePart") then
                                                        tp(parent.CFrame * CFrame.new(0, 3, 0))
                                                        task.wait(0.2)

                                                        pcall(function()
                                                            if pd.Enabled then fireproximityprompt(pd) end
                                                        end)
                                                    end

                                                    r2()
                                                    task.wait(0.3)
                                                    break
                                                end
                                            end
                                        end
                                    end

                                    pcall(function()
                                        local c = LocalPlayer.Character
                                        if c then
                                            local t = c:FindFirstChildOfClass("Tool")
                                            if t then t.Parent = LocalPlayer.Backpack end
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end

                if sink and cfg.autoWash then
                    for attempt = 1, 20 do
                        if not cfg.autoWash then break end

                        local washPrompt

                        for _, pd in ipairs(sink:GetDescendants()) do
                            if pd:IsA("ProximityPrompt") and pd.Enabled then
                                local a = pd.ActionText:lower()
                                local o = pd.ObjectText:lower()

                                if string.find(a, "wash")
                                    or string.find(a, "clean")
                                    or string.find(a, "scrub")
                                    or string.find(o, "dish")
                                    or string.find(o, "dirty")
                                    or string.find(o, "plate") then

                                    washPrompt = pd
                                    break
                                end
                            end
                        end

                        if not washPrompt then break end

                        local promptParent = washPrompt.Parent
                        if not promptParent or not promptParent:IsA("BasePart") then break end

                        local targetCFrame = promptParent.CFrame * CFrame.new(0, 3, 0)
                        local release3 = acquireTp()

                        tp(targetCFrame)
                        task.wait(0.3)

                        local holdStart = os.clock()
                        local holdActive = false

                        while washPrompt
                            and washPrompt.Parent
                            and washPrompt.Enabled
                            and cfg.autoWash
                            and os.clock() - holdStart < 6 do

                            local char = LocalPlayer.Character
                            local root = char and char:FindFirstChild("HumanoidRootPart")

                            if root and (root.Position - promptParent.Position).Magnitude > 8 then
                                holdActive = false

                                pcall(function()
                                    washPrompt:InputHoldEnd()
                                end)

                                task.wait(0.3)
                                tp(targetCFrame)
                                task.wait(0.6)
                            end

                            if not holdActive then
                                local ok = pcall(function()
                                    washPrompt:InputHoldBegin()
                                end)

                                if ok then holdActive = true end
                            else
                                pcall(function()
                                    washPrompt:InputHoldBegin()
                                end)
                            end

                            task.wait(0.1)
                        end

                        pcall(function()
                            if washPrompt and washPrompt.Parent then
                                washPrompt:InputHoldEnd()
                            end
                        end)

                        release3()
                        task.wait(0.2)
                    end
                end
            end

            releaseAction("Wash")
        end

        task.wait(cfg.washDelay)
    end
end)

-- ========================================================================= --
-- [[ AUTO SERVE LOOP (May Smart Queue Lock - Hindi mag-ooverlap) ]] --
-- ========================================================================= --
task.spawn(function()
    while true do
        if cfg.main2AutoServe and not TaskState.IsBusy then
            local plot = getPlot()

            if plot then
                TaskState.IsBusy = true
                TaskState.CurrentAction = "Serving"
                local served = 0

                local serveCounter = plot:FindFirstChild("Serve")

                if serveCounter then
                    for _, desc in ipairs(serveCounter:GetDescendants()) do
                        if served >= 6 or not cfg.main2AutoServe then break end

                        if desc:IsA("ProximityPrompt") and desc.Enabled then
                            local cf = getPromptCFrame(desc)

                            if cf then
                                local shouldSkip = false

                                -- 1. Check if Y-axis is below 4
                                if cf.Position.Y < 4 then
                                    shouldSkip = true
                                end

                                -- 2. Check if inside folder named "13" - BLOCKED & IGNORED
                                if not shouldSkip then
                                    local current = desc.Parent
                                    while current and current ~= serveCounter do
                                        if current.Name == "13" then
                                            shouldSkip = true
                                            break
                                        end
                                        current = current.Parent
                                    end
                                end

                                -- 3. Check if valid target:
                                -- a) Model name starts with "Cooked_"
                                -- b) ProximityPrompt directly inside a BasePart
                                if not shouldSkip then
                                    local isValidTarget = false
                                    local parent = desc.Parent

                                    local topModel = desc:FindFirstAncestorOfClass("Model")
                                    if topModel and topModel.Name:sub(1, 7) == "Cooked_" then
                                        isValidTarget = true
                                    elseif parent and parent:IsA("BasePart") then
                                        isValidTarget = true
                                    end

                                    if not isValidTarget then
                                        shouldSkip = true
                                    end
                                end

                                -- Kung hindi na-block, i-execute ang action
                                if not shouldSkip then
                                    flyTweenWaypoints((cf * CFrame.new(0, 1.6, 1.5)).Position)
                                    task.wait(0.05)

                                    if forceFirePrompt(desc) then
                                        served += 1
                                    end

                                    task.wait(cfg.serveDelay or 0.15)
                                end
                            end
                        end
                    end
                end

                local dp = plot:FindFirstChild("DiningPlot1")

                if dp and cfg.main2AutoServe then
                    local targets = {}

                    for _, slot in ipairs(dp:GetChildren()) do
                        if slot:IsA("Model") then
                            for _, desc in ipairs(slot:GetDescendants()) do
                                if desc:IsA("ProximityPrompt") and desc.Enabled then
                                    local action = desc.ActionText:lower()

                                    if string.find(action, "serve")
                                        or string.find(action, "give")
                                        or string.sub(desc.ActionText, 1, 5) == "Serve" then

                                        local promptCF = getPromptCFrame(desc)

                                        if promptCF then
                                            local pos = promptCF.Position
                                            local npcModel = desc:FindFirstAncestorOfClass("Model")
                                            local isBubbles = npcModel
                                                and cfg.autoQuestBubbles
                                                and string.find(npcModel.Name:lower(), "bubbles")

                                            table.insert(targets, {
                                                prompt = desc,
                                                cframe = promptCF,
                                                isBubbles = isBubbles,
                                                y = pos.Y
                                            })
                                        end
                                    end
                                end
                            end
                        end
                    end

                    table.sort(targets, function(a, b)
                        if a.isBubbles ~= b.isBubbles then
                            return a.isBubbles
                        end

                        return a.y < b.y
                    end)

                    for _, target in ipairs(targets) do
                        if served >= 6 or not cfg.main2AutoServe then break end

                        if target.cframe
                            and target.prompt
                            and target.prompt.Parent
                            and target.prompt.Enabled then

                            local standPos = (target.cframe * CFrame.new(0, 1.6, 1.5)).Position

                            if flyTweenWaypoints(standPos) then
                                task.wait(0.05)

                                if forceFirePrompt(target.prompt) then
                                    served += 1
                                end

                                task.wait(cfg.serveDelay or 0.15)
                            end
                        end
                    end
                end

                TaskState.IsBusy = false
                TaskState.CurrentAction = "Idle"
            else
                TaskState.IsBusy = false
                TaskState.CurrentAction = "Idle"
            end
        end

        task.wait(0.3)
    end
end)

-- ========================================================================= --
-- [[ AUTO WASH LOOP (Awtomatikong maghihintay hanggang matapos ang Serve) ]] --
-- ========================================================================= --
task.spawn(function()
    while true do
        if cfg.main2AutoWash then
            if not TaskState.IsBusy then
                TaskState.IsBusy = true
                TaskState.CurrentAction = "Washing"

                local plot = getPlot()

                if plot then
                    local sink = plot:FindFirstChild("Sink")
                    local collectAreas = {
                        plot:FindFirstChild("DiningPlot1"),
                        plot:FindFirstChild("Serve")
                    }

                    for _, area in ipairs(collectAreas) do
                        if not cfg.main2AutoWash or TaskState.CurrentAction ~= "Washing" then
                            break
                        end

                        if area then
                            for _, desc in ipairs(area:GetDescendants()) do
                                if not cfg.main2AutoWash then break end

                                if desc:IsA("ProximityPrompt") and desc.Enabled then
                                    local act, obj = desc.ActionText:lower(), desc.ObjectText:lower()

                                    if string.find(obj, "dirty")
                                        or string.find(obj, "dish")
                                        or string.find(act, "wash")
                                        or string.find(act, "pick") then

                                        local pp = desc.Parent

                                        if pp and pp:IsA("BasePart") then
                                            flyTweenWaypoints((pp.CFrame * CFrame.new(0, 1.6, 0)).Position)
                                            task.wait(0.1)
                                            forceFirePrompt(desc)
                                            task.wait(0.2)

                                            local char = LocalPlayer.Character

                                            if char and char:FindFirstChildOfClass("Tool") and sink then
                                                for _, pd in ipairs(sink:GetDescendants()) do
                                                    if pd:IsA("ProximityPrompt") and pd.Enabled then
                                                        local a = pd.ActionText:lower()

                                                        if string.find(a, "put")
                                                            or string.find(a, "place")
                                                            or pd.Name == "Put" then

                                                            flyTweenWaypoints((pd.Parent.CFrame * CFrame.new(0, 1.6, 0)).Position)
                                                            task.wait(0.15)
                                                            forceFirePrompt(pd)
                                                            task.wait(0.25)
                                                            break
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end

                    if sink and cfg.main2AutoWash then
                        for attempt = 1, 15 do
                            if not cfg.main2AutoWash then break end

                            local washPrompt

                            for _, pd in ipairs(sink:GetDescendants()) do
                                if pd:IsA("ProximityPrompt") and pd.Enabled then
                                    local a, o = pd.ActionText:lower(), pd.ObjectText:lower()

                                    if string.find(a, "wash")
                                        or string.find(a, "clean")
                                        or string.find(o, "dish")
                                        or string.find(o, "dirty") then

                                        washPrompt = pd
                                        break
                                    end
                                end
                            end

                            if not washPrompt
                                or not washPrompt.Parent
                                or not washPrompt.Parent:IsA("BasePart") then
                                break
                            end

                            local targetPos = (washPrompt.Parent.CFrame * CFrame.new(0, 1.6, 0)).Position
                            flyTweenWaypoints(targetPos)
                            task.wait(0.2)

                            local holdStart = os.clock()

                            while washPrompt
                                and washPrompt.Parent
                                and washPrompt.Enabled
                                and cfg.main2AutoWash
                                and os.clock() - holdStart < 5.5 do

                                pcall(function()
                                    washPrompt:InputHoldBegin()
                                end)

                                task.wait(0.1)
                            end

                            pcall(function()
                                if washPrompt and washPrompt.Parent then
                                    washPrompt:InputHoldEnd()
                                end
                            end)

                            task.wait(0.2)
                        end
                    end
                end

                TaskState.IsBusy = false
                TaskState.CurrentAction = "Idle"
            end
        end

        task.wait(cfg.washDelay or 0.3)
    end
end)

-- [[ ALTERNATIVE TAB ]] --

AlternativeTab:Section({Title = "Automation & Pathfinding (Tween Fly)"})

AlternativeTab:Toggle({
    Title = "Tween Auto Serve",
    Desc = "Automatically serve with height routing",
    Value = false,
    Flag = "Main2AutoServe",
    Callback = function(v) cfg.main2AutoServe = v end
})

AlternativeTab:Toggle({
    Title = "Tween Auto Wash",
    Desc = "Automatically washes dishes",
    Value = false,
    Flag = "Main2AutoWash",
    Callback = function(v) cfg.main2AutoWash = v end
})

AlternativeTab:Slider({
    Title = "Tween Speed",
    Desc = "Set your preferred tween speed",
    Value = {Min = 1, Max = 60, Default = cfg.tweenSpeed or 26},
    Step = 1,
    Flag = "TweenSpeedSlider",
    Callback = function(value) cfg.tweenSpeed = tonumber(value) or 26 end
})

AlternativeTab:Section({Title = "Main (Connected)"})

AlternativeTab:Toggle({
    Title = "Auto Assign Customers",
    Desc = "Automatically assign customers to tables",
    Value = false,
    Flag = "AutoOrder",
    Callback = function(v) cfg.autoOrder = v end
})

AlternativeTab:Toggle({
    Title = "Auto Serve Drinks",
    Desc = "Automatically fulfill drink orders (Requires Chiller)",
    Value = false,
    Flag = "AutoSoftdrinks",
    Callback = function(v) cfg.autoSoftdrinks = v end
})

-- [[ AUTO PAN (V1) ]] --

local PAN_NAMES = {pan = true, goldenpan = true, vippan = true}
local isChasingRunaways = false
local hasReturnedToCounter = false

local function findPanTool()
    local character = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")

    for _, container in ipairs({backpack, character}) do
        if not container then continue end

        for _, tool in ipairs(container:GetChildren()) do
            if tool:IsA("Tool") and PAN_NAMES[string.lower(tool.Name)] then
                return tool
            end
        end
    end

    return nil
end

local function getRunawayNPCs()
    local clientNPCs = Workspace:FindFirstChild("ClientNPCs")
    if not clientNPCs then return {} end

    local runaways = {}

    for _, npc in ipairs(clientNPCs:GetChildren()) do
        if npc:IsA("Model") and npc.Parent and npc:GetAttribute("IsRunaway") == true and isMyRunaway(npc) then
            table.insert(runaways, npc)
        end
    end

    return runaways
end

local function unequipPanTool()
    if cfg.autoPanV2 then return end

    local character, humanoid = getChar()
    if not character or not humanoid then return end

    local pan = findPanTool()

    if pan and pan.Parent == character then
        pcall(function() humanoid:UnequipTools() end)
    end
end

local function returnToCounter()
    if not cfg.autoPan or cfg.autoPanV2 or hasReturnedToCounter then return false end

    local plot = getPlot()
    local counter = plot and plot:FindFirstChild("Counter")
    if not counter then return false end

    local returnPart = counter:FindFirstChild("Comp", true) or (counter:IsA("BasePart") and counter) or counter:FindFirstChildWhichIsA("BasePart", true)
    if not returnPart then return false end

    hasReturnedToCounter = true

    local releaseTp = acquireTp()

    pcall(function()
        if cfg.autoPan and not cfg.autoPanV2 then
            tp(returnPart.CFrame * CFrame.new(0, 3, 0))
        end
    end)

    releaseTp()
    return true
end

task.spawn(function()
    while true do
        task.wait(0.10)

        if not cfg.autoPan then
            if isChasingRunaways then
                isChasingRunaways = false
                hasReturnedToCounter = false
                unequipPanTool()
            end
            continue
        end

        local runaways = getRunawayNPCs()

        if #runaways == 0 then
            if isChasingRunaways then
                isChasingRunaways = false
                unequipPanTool()
                task.wait(0.1)

                if cfg.autoPan and not cfg.autoPanV2 then
                    returnToCounter()
                end
            end
            continue
        end

        isChasingRunaways = true
        hasReturnedToCounter = false

        for _, runawayNpc in ipairs(runaways) do
            if not cfg.autoPan then break end

            if not runawayNpc or not runawayNpc.Parent or runawayNpc:GetAttribute("IsRunaway") ~= true or not isMyRunaway(runawayNpc) then
                continue
            end

            while cfg.autoPan and runawayNpc and runawayNpc.Parent and runawayNpc:GetAttribute("IsRunaway") == true and isMyRunaway(runawayNpc) do
                local character, humanoid = getChar()

                if not character or not humanoid or humanoid.Health <= 0 then break end

                local targetRoot = runawayNpc:FindFirstChild("HumanoidRootPart") or runawayNpc.PrimaryPart
                if not targetRoot or not targetRoot.Parent then break end

                local pan = findPanTool()
                if not pan then break end

                if pan.Parent ~= character then
                    pcall(function() humanoid:EquipTool(pan) end)
                    task.wait(0.1)
                    if not cfg.autoPan then break end
                end

                local releaseTp = acquireTp()

                pcall(function()
                    if targetRoot.Parent and cfg.autoPan then
                        tp(targetRoot.CFrame * CFrame.new(0, 0, -1.8))
                    end
                end)

                releaseTp()

                if not cfg.autoPan then break end

                task.wait(0.05)

                if pan.Parent == character then
                    pcall(function() pan:Activate() end)
                end

                task.wait(0.8)
            end
        end
    end
end)

-- [[ AUTO PAN (V2) ]] --

local VALID_PAN_NAMES_V2 = {pan = true, goldenpan = true, vippan = true}
local ACTIVATE_COOLDOWN = 0.8
local isChasingV2 = false
local hasReturnedV2 = false
lastPanActivationTime = 0

local function findPanToolV2()
    local character = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")

    for _, container in ipairs({backpack, character}) do
        if not container then continue end

        for _, tool in ipairs(container:GetChildren()) do
            if tool:IsA("Tool") and VALID_PAN_NAMES_V2[string.lower(tool.Name)] then
                return tool
            end
        end
    end

    return nil
end

local function getRunawayNPCsV2()
    local clientNPCs = Workspace:FindFirstChild("ClientNPCs")
    if not clientNPCs then return {} end

    local runaways = {}

    for _, npc in ipairs(clientNPCs:GetChildren()) do
        if npc:IsA("Model") and npc.Parent and npc:GetAttribute("IsRunaway") == true and isMyRunaway(npc) then
            table.insert(runaways, npc)
        end
    end

    return runaways
end

local function getNPCRootPart(npc)
    if not npc or not npc.Parent then return nil end
    return npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
end

local function chaseTargetPosition(targetRoot, rootPart)
    if not targetRoot or not targetRoot.Parent or not rootPart or not rootPart.Parent then return false end

    local chaseOffset = cfg.panChaseOffset or 8
    local stepDistance = cfg.panChaseStep or 12
    local distanceVector = targetRoot.Position - rootPart.Position
    local currentDistance = distanceVector.Magnitude

    if currentDistance <= chaseOffset then return true end

    local moveStep = math.min(stepDistance, currentDistance - chaseOffset)
    if moveStep <= 0 then return true end

    local nextPosition = rootPart.Position + distanceVector.Unit * moveStep
    local releaseTp = acquireTp()

    pcall(function()
        if cfg.autoPanV2 and targetRoot.Parent and rootPart.Parent then
            rootPart.CFrame = CFrame.lookAt(nextPosition, targetRoot.Position)
        end
    end)

    releaseTp()
    return true
end

local function returnToCounterV2()
    if not cfg.autoPanV2 or cfg.autoPan or hasReturnedV2 then return false end

    local plot = getPlot()
    local counter = plot and plot:FindFirstChild("Counter")
    if not counter then return false end

    local targetPart = counter:FindFirstChild("Comp", true) or (counter:IsA("BasePart") and counter) or counter:FindFirstChildWhichIsA("BasePart", true)
    if not targetPart then return false end

    hasReturnedV2 = true

    local releaseTp = acquireTp()

    pcall(function()
        if cfg.autoPanV2 and not cfg.autoPan then
            tp(targetPart.CFrame * CFrame.new(0, 3, 0))
        end
    end)

    releaseTp()
    return true
end

local function unequipPanV2()
    if cfg.autoPan then return end

    local _, humanoid = getChar()

    if humanoid then
        pcall(function() humanoid:UnequipTools() end)
    end
end

local function triggerPanActivationV2()
    if not cfg.autoPanV2 then return end

    local runaways = getRunawayNPCsV2()
    if #runaways == 0 then return end

    local character, humanoid = getChar()

    if not character or not humanoid or humanoid.Health <= 0 then return end

    local pan = findPanToolV2()
    if not pan then return end

    if pan.Parent ~= character then
        pcall(function() humanoid:EquipTool(pan) end)
        task.wait(0.1)
    end

    if pan.Parent == character then
        pcall(function() pan:Activate() end)
    end
end

task.spawn(function()
    while true do
        task.wait(0.05)

        if not cfg.autoPanV2 then
            if isChasingV2 then
                isChasingV2 = false
                hasReturnedV2 = false

                if not cfg.autoPan then
                    unequipPanV2()
                end
            end
            continue
        end

        local runaways = getRunawayNPCsV2()

        if #runaways == 0 then
            if isChasingV2 then
                isChasingV2 = false

                if not cfg.autoPan then
                    unequipPanV2()
                    task.wait(0.1)

                    if cfg.autoPanV2 and not cfg.autoPan then
                        returnToCounterV2()
                    end
                end
            end
            continue
        end

        isChasingV2 = true
        hasReturnedV2 = false

        local character, humanoid = getChar()

        if not character or not humanoid or humanoid.Health <= 0 then
            continue
        end

        local pan = findPanToolV2()

        if pan and pan.Parent ~= character then
            pcall(function() humanoid:EquipTool(pan) end)
            task.wait(0.1)
        end

        if os.clock() - lastPanActivationTime >= ACTIVATE_COOLDOWN then
            lastPanActivationTime = os.clock()
            triggerPanActivationV2()
        end

        for _, npc in ipairs(runaways) do
            if not cfg.autoPanV2 then break end

            if not npc or not npc.Parent or npc:GetAttribute("IsRunaway") ~= true or not isMyRunaway(npc) then
                continue
            end

            while cfg.autoPanV2 and npc and npc.Parent and npc:GetAttribute("IsRunaway") == true and isMyRunaway(npc) do
                local activeCharacter, activeHumanoid, rootPart = getChar()
                local targetRoot = getNPCRootPart(npc)

                if not activeCharacter or not activeHumanoid or activeHumanoid.Health <= 0 or not rootPart or not targetRoot then
                    break
                end

                local distance = (targetRoot.Position - rootPart.Position).Magnitude

                if distance <= (cfg.panChaseOffset or 8) then
                    break
                end

                chaseTargetPosition(targetRoot, rootPart)
                task.wait(cfg.panChaseDelay or 0.05)
            end
        end
    end
end)

-- [[ INGREDIENTS ]] --
local IngredientStats = {}
local ingredientBusy = {}

local autoBuyThreshold = 5

local ingredientCategories = {
    Rice = "Other",
    Vegetable = "Condiments",
    Condiments = "Condiments",
    Egg = "Other",
    CornBeef = "Meat",
    Cheese = "Other",
    SpaghettiPack = "Other",
    CarbonaraPack = "Other",
    Noodles = "Other",
    Chicharon = "Other",
    Bacon = "Meat",
    Tapa = "Meat",
    Tocino = "Meat",
    Hotdog = "Meat",
    Hungarian = "Meat",
    Bangus = "Meat",
    Pork = "Meat",
    Beef = "Meat",
    Chicken = "Meat",
    Shrimp = "Meat",
    Kola = "Drinks",
    Loyal = "Drinks",
    Suprise = "Drinks"
}

local categoryOrder = {
    "Condiments",
    "Meat",
    "Drinks",
    "Other"
}

local ingredientsByCategory = {
    Condiments = {},
    Meat = {},
    Drinks = {},
    Other = {}
}

for name, data in pairs(IngredientsConfig) do
    if type(data) == "table" and data.Cost then
        local category = ingredientCategories[name] or "Other"
        table.insert(ingredientsByCategory[category], name)
    end
end

for _, category in ipairs(categoryOrder) do
    table.sort(ingredientsByCategory[category], function(a, b)
        return (IngredientsConfig[a].LayoutOrder or math.huge) <
            (IngredientsConfig[b].LayoutOrder or math.huge)
    end)
end

local function getIngredientStock(name)
    local ingredients = LocalPlayer:FindFirstChild("Ingredients")

    if not ingredients then
        return 0
    end

    local stock = ingredients:FindFirstChild(name)

    if not stock then
        return 0
    end

    return tonumber(stock.Value) or 0
end

local function getIngredientMax(name)
    local config = IngredientsConfig[name]

    if not config then
        return 100
    end

    return tonumber(
        config.MaxStock
        or config.Max
        or config.Capacity
        or config.Limit
    ) or 100
end

local function getIngredientPercent(name)
    local stock = getIngredientStock(name)
    local maxStock = getIngredientMax(name)

    if maxStock <= 0 then
        return 0
    end

    return math.clamp(
        (stock / maxStock) * 100,
        0,
        100
    )
end

local function updateIngredientStockDisplay(name)
    local paragraph = IngredientStats[name]

    if not paragraph then
        return
    end

    local stock = getIngredientStock(name)
    local maxStock = getIngredientMax(name)
    local percent = getIngredientPercent(name)

    paragraph:SetDesc(
        string.format(
            "%d / %d (%d%%)",
            stock,
            maxStock,
            math.floor(percent + 0.5)
        )
    )
end

local function refreshIngredientStocks()
    for _, category in ipairs(categoryOrder) do
        for _, name in ipairs(ingredientsByCategory[category]) do
            updateIngredientStockDisplay(name)
        end
    end
end

local function buyIngredient(name, quantity)
    if ingredientBusy[name] then
        return false
    end

    local config = IngredientsConfig[name]

    if not config or not config.Cost then
        return false
    end

    quantity = math.floor(
        tonumber(quantity) or 0
    )

    if quantity <= 0 then
        return false
    end

    local stock = getIngredientStock(name)
    local maxStock = getIngredientMax(name)

    quantity = math.min(
        quantity,
        math.max(0, maxStock - stock)
    )

    if quantity <= 0 then
        return false
    end

    ingredientBusy[name] = true

    local ok, result = pcall(function()
        return BuyIngredient:InvokeServer(
            name,
            quantity,
            "Cash"
        )
    end)

    task.wait(0.2)

    ingredientBusy[name] = nil

    updateIngredientStockDisplay(name)

    return ok and result ~= false
end

local function buyIngredientMax(name)
    local stock = getIngredientStock(name)
    local maxStock = getIngredientMax(name)

    local quantity = math.max(
        0,
        maxStock - stock
    )

    if quantity <= 0 then
        return false
    end

    return buyIngredient(
        name,
        quantity
    )
end

IngredientsTab:Slider({
    Title = "Buy Threshold",
    Desc = "Automatically buy when stock reaches this percentage or lower",
    Value = {
        Min = 5,
        Max = 30,
        Default = 5
    },
    Step = 1,
    Flag = "AutoBuyThreshold",
    Callback = function(value)
        autoBuyThreshold = math.clamp(
            tonumber(value) or 5,
            5,
            30
        )
    end
})

IngredientsTab:Toggle({
    Title = "Auto Buy",
    Desc = "Automatically buy ingredients when stock is at or below the threshold",
    Value = false,
    Flag = "AutoBuyIngredients",
    Callback = function(value)
        cfg.autoBuyIngredients = value
    end
})

for _, category in ipairs(categoryOrder) do
    local section = IngredientsTab:Section({
        Title = category,
        Opened = false
    })

    for _, name in ipairs(ingredientsByCategory[category]) do
        local maxStock = getIngredientMax(name)

        local paragraph = section:Paragraph({
            Title = tostring(name),
            Desc = string.format(
                "0 / %d (0%%)",
                maxStock
            )
        })

        IngredientStats[name] = paragraph

        section:Button({
            Title = "Buy " .. tostring(name),
            Icon = "shopping-cart",
            Callback = function()
                buyIngredient(
                    name,
                    1
                )
            end
        })

        section:Button({
            Title = "Buy Max",
            Icon = "shopping-cart",
            Callback = function()
                buyIngredientMax(
                    name
                )
            end
        })
    end
end

refreshIngredientStocks()

task.spawn(function()
    while true do
        task.wait(30)
        refreshIngredientStocks()
    end
end)

task.spawn(function()
    while true do
        if cfg.autoBuyIngredients then
            for _, category in ipairs(categoryOrder) do
                for _, name in ipairs(ingredientsByCategory[category]) do
                    if not ingredientBusy[name] then
                        local stock = getIngredientStock(name)
                        local maxStock = getIngredientMax(name)

                        if maxStock > 0
                        and stock < maxStock then
                            local percent = (stock / maxStock) * 100

                            if percent <= autoBuyThreshold then
                                buyIngredient(
                                    name,
                                    1
                                )

                                task.wait(0.75)
                            end
                        end
                    end
                end
            end
        end

        task.wait(0.5)
    end
end)

-- [[ SHOP SYSTEMS INTEGRATION ]] --
local ShopItems = {}
local ShopDropdowns = {}
local ShopBusy = {}
local AutoBuyLastAttempt = {}

local AutoBuyFlags = {
    Tables = false,
    Chairs = false,
    Materials = false,
    Paints = false,
    Tiles = false,
    Stoves = false
}

local SelectedItems = {
    Tables = {},
    Chairs = {},
    Materials = {},
    Paints = {},
    Tiles = {},
    Stoves = {}
}

local CONFIG_MAP = {
    Tables = TableConfig,
    Chairs = ChairConfig,
    Materials = MaterialConfig,
    Paints = PaintConfig,
    Tiles = TileConfig,
    Stoves = StoveConfig
}

local CATEGORIES = {
    {Name = "Table", Category = "Tables"},
    {Name = "Chair", Category = "Chairs"},
    {Name = "Material", Category = "Materials"},
    {Name = "Paint", Category = "Paints"},
    {Name = "Tile", Category = "Tiles"},
    {Name = "Stove", Category = "Stoves"}
}

local function getConfig(category, key)
    local cfg = CONFIG_MAP[category]
    if not cfg then return nil end

    if cfg.Get then
        local ok, result = pcall(function()
            return cfg:Get(key)
        end)

        if ok and result then
            return result
        end
    end

    return cfg[key]
end

local function getDisplayName(item)
    if not item then return "Unknown" end

    local config = item.Config

    if type(config) == "table" then
        return tostring(config.DisplayName or config.Name or item.Key)
    end

    return tostring(item.Key)
end

local function makeId(category, key)
    return tostring(category) .. ":" .. tostring(key)
end

local function getFurnitureConfig(systemType, category, key)
    if FurnitureConfig and FurnitureConfig.GetItemConfig then
        local ok, result = pcall(function()
            return FurnitureConfig:GetItemConfig(systemType, category, key)
        end)

        if ok and result then
            return result
        end
    end

    return getConfig(category, key)
end

local function getSystemType(category, item)
    local systemType = type(item) == "table" and item.SystemType or nil

    if category == "Tables" or category == "Chairs" then
        return "Dining"
    elseif category == "Stoves" then
        return "Kitchen"
    end

    return systemType
end

local function getServerItemKey(item, fallbackKey)
    if type(item) == "table" then
        return tostring(item.Key or item.Id or fallbackKey)
    end

    return tostring(fallbackKey)
end

local function addShopItems(shopData, category)
    local items = shopData and shopData[category]

    if type(items) == "table" then
        for k, item in pairs(items) do
            local key = getServerItemKey(item, k)
            local systemType = getSystemType(category, item)
            local config = getFurnitureConfig(systemType, category, key)
            local id = makeId(category, key)
            local stock, price = 0, 0

            if type(item) == "table" then
                stock = tonumber(item.Stock) or 0
                price = tonumber(item.Price or item.Cost) or 0
            end

            ShopItems[id] = {
                Key = key,
                Category = category,
                SystemType = systemType,
                Stock = stock,
                Price = price,
                Config = config
            }
        end
    end

    local localConfigModule = CONFIG_MAP[category]
    if not localConfigModule then return end

    local targetTable = localConfigModule.Types or localConfigModule.Items or localConfigModule
    if type(targetTable) ~= "table" then return end

    for key, config in pairs(targetTable) do
        if type(config) == "table" and type(key) == "string" and key ~= "Get" then
            local id = makeId(category, key)

            if not ShopItems[id] then
                local systemType = getSystemType(category, nil)

                ShopItems[id] = {
                    Key = key,
                    Category = category,
                    SystemType = systemType,
                    Stock = 0,
                    Price = tonumber(config.Price or config.Cost) or 0,
                    Config = config
                }
            end
        end
    end
end

local function getCategoryValues(category)
    local values, seen = {}, {}

    for _, item in pairs(ShopItems) do
        if item.Category == category then
            local name = getDisplayName(item)
            local stock = tonumber(item.Stock) or 0
            local label = string.format("%s [Stock: %d]", name, stock)

            if not seen[label] then
                seen[label] = true
                table.insert(values, label)
            end
        end
    end

    table.sort(values)
    return values
end

local function getCleanItemName(label)
    return tostring(label):gsub("%s*%[Stock:%s*%d+%]%s*$", "")
end

local function refreshShopDropdowns()
    for _, catData in ipairs(CATEGORIES) do
        local category = catData.Category
        local dropdown = ShopDropdowns[category]

        if dropdown then
            local selected = SelectedItems[category] or {}
            local selectedNames = {}

            for _, value in ipairs(selected) do
                selectedNames[getCleanItemName(value)] = true
            end

            local values = getCategoryValues(category)
            local restored = {}

            for _, value in ipairs(values) do
                if selectedNames[getCleanItemName(value)] then
                    table.insert(restored, value)
                end
            end

            SelectedItems[category] = restored

            pcall(function()
                dropdown:SetValues(values)
            end)

            task.defer(function()
                pcall(function()
                    if dropdown.SetValue then
                        dropdown:SetValue(restored)
                    end
                end)
            end)
        end
    end
end

local function refreshShop()
    local ok, shopData = pcall(function()
        return GetShopInfo:InvokeServer()
    end)

    if not ok or type(shopData) ~= "table" then
        return false
    end

    local oldShopItems = ShopItems
    ShopItems = {}

    for _, catData in ipairs(CATEGORIES) do
        addShopItems(shopData, catData.Category)
    end

    if next(ShopItems) == nil and next(oldShopItems) ~= nil then
        ShopItems = oldShopItems
        return false
    end

    refreshShopDropdowns()
    return true
end

local function showBuyNotification(names)
    if type(names) ~= "table" or #names == 0 then return end

    local content = #names == 1
        and "Bought 1x " .. tostring(names[1])
        or "Bought 1x each of " .. tostring(#names) .. " selected items."

    pcall(function()
        WindUI:Notify({
            Title = "Shop",
            Content = content,
            Duration = 1.5
        })
    end)
end

local function buyShopItem(item, quantity)
    if not item then return false end

    quantity = math.max(1, tonumber(quantity) or 1)

    local key = tostring(item.Key)
    local category = tostring(item.Category)
    local id = makeId(category, key)

    if ShopBusy[id] then
        return false
    end

    local stock = tonumber(item.Stock) or 0

    if stock < quantity then
        return false
    end

    ShopBusy[id] = true

    local systemType = getSystemType(category, item)
    local purchased = 0

    for _ = 1, quantity do
        local ok, result = pcall(function()
            return BuyFurniture:InvokeServer(systemType, category, key)
        end)

        if not ok or not result then
            break
        end

        purchased += 1
    end

    ShopBusy[id] = nil

    if purchased <= 0 then
        return false
    end

    item.Stock = math.max(
        0,
        (tonumber(item.Stock) or 0) - purchased
    )

    refreshShopDropdowns()

    return true
end

local function findSelectedItem(category, selectedLabel)
    local cleanName = getCleanItemName(selectedLabel)

    for _, item in pairs(ShopItems) do
        if item.Category == category and getDisplayName(item) == cleanName then
            return item
        end
    end

    return nil
end

local function buySelectedItems(category)
    local selected = SelectedItems[category]

    if type(selected) ~= "table" or #selected == 0 then
        pcall(function()
            WindUI:Notify({
                Title = "Shop",
                Content = "No items selected.",
                Duration = 1.5
            })
        end)

        return
    end

    local boughtNames = {}

    for _, label in ipairs(selected) do
        local item = findSelectedItem(category, label)

        if item and (tonumber(item.Stock) or 0) > 0 then
            if buyShopItem(item, 1) then
                table.insert(boughtNames, getDisplayName(item))
            end

            task.wait(0.05)
        end
    end

    if #boughtNames > 0 then
        showBuyNotification(boughtNames)
    else
        pcall(function()
            WindUI:Notify({
                Title = "Shop",
                Content = "No selected items available.",
                Duration = 1.5
            })
        end)
    end
end

local function processAutoBuy(category)
    if not AutoBuyFlags[category] then
        return
    end

    local selected = SelectedItems[category]

    if type(selected) ~= "table" or #selected == 0 then
        return
    end

    for _, label in ipairs(selected) do
        local item = findSelectedItem(category, label)

        if item and (tonumber(item.Stock) or 0) > 0 then
            local id = makeId(item.Category, item.Key)
            local now = os.clock()
            local last = AutoBuyLastAttempt[id] or 0

            if now - last >= 1 then
                AutoBuyLastAttempt[id] = now

                task.spawn(function()
                    buyShopItem(item, 1)
                end)
            end
        end
    end
end

refreshShop()

for _, catData in ipairs(CATEGORIES) do
    local category = catData.Category
    local catName = catData.Name

    ShopTab:Section({
        Title = catName
    })

    ShopDropdowns[category] = ShopTab:Dropdown({
        Title = "Select " .. catName .. "s",
        Desc = "Select multiple " .. catName:lower() .. "s",
        Values = getCategoryValues(category),
        Value = {},
        Multi = true,
        AllowNone = true,
        Searchable = true,

        Callback = function(option)
            SelectedItems[category] = type(option) == "table" and option or {}
        end
    })

    ShopTab:Toggle({
        Title = "Auto Buy " .. catName,
        Desc = "Automatically buy selected " .. catName:lower() .. "s",
        Value = false,

        Callback = function(value)
            AutoBuyFlags[category] = value
        end
    })

    ShopTab:Button({
        Title = "Manual Buy " .. catName,
        Desc = "Buy selected " .. catName:lower() .. "s once",
        Icon = "shopping-cart",

        Callback = function()
            task.spawn(function()
                buySelectedItems(category)
            end)
        end
    })
end

ShopRestocked.OnClientEvent:Connect(function()
    task.wait(0.2)
    refreshShop()

    if logCurrentShopStock then
        task.wait(0.1)

        pcall(function()
            logCurrentShopStock()
        end)
    end
end)

task.spawn(function()
    while true do
        for _, catData in ipairs(CATEGORIES) do
            processAutoBuy(catData.Category)
        end

        task.wait(1)
    end
end)

SettingsTab:Section({ Title = "Movement" })

local WalkSpeedSlider = SettingsTab:Slider({
    Title = "WalkSpeed",
    Value = { Min = 16, Max = 100, Default = cfg.walkSpeed },
    Step = 1,
    Flag = "WalkSpeed",
    Callback = function(v)
        cfg.walkSpeed = tonumber(v) or 16
        local _, h = getChar()
        if h then h.WalkSpeed = cfg.walkSpeed end
    end
})

SettingsTab:Button({
    Title = "Reset WalkSpeed",
    Icon = "rotate-ccw",
    Callback = function()
        cfg.walkSpeed = 16
        local _, h = getChar()
        if h then h.WalkSpeed = 16 end
        pcall(function() WalkSpeedSlider:SetValue(16) end)
    end
})

LocalPlayer.CharacterAdded:Connect(function(character)
    local h = character:WaitForChild("Humanoid", 10)
    if h then h.WalkSpeed = cfg.walkSpeed or 16 end
end)

SettingsTab:Toggle({
    Title = "Infinite Jump",
    Value = cfg.infJump,
    Flag = "InfJump",
    Callback = function(v)
        cfg.infJump = v
    end
})

UserInputService.JumpRequest:Connect(function()
    if not cfg.infJump then return end
    local _, h = getChar()
    if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

local noclipConnection

local function setNoClip(enabled)
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end

    if not enabled then return end

    noclipConnection = RunService.Heartbeat:Connect(function()
        local character = LocalPlayer.Character
        if not character then return end

        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end

SettingsTab:Toggle({
    Title = "NoClip",
    Value = cfg.noclip,
    Flag = "NoClip",
    Callback = function(v)
        cfg.noclip = v
        setNoClip(v)
    end
})

SettingsTab:Button({
    Title = "Anti AFK",
    Callback = function()
        local env = getgenv()

        if env.__AntiAFK_Running then
            env.__AntiAFK_Running = false

            if env.__AntiAFK_Connection then
                pcall(function() env.__AntiAFK_Connection:Disconnect() end)
                env.__AntiAFK_Connection = nil
            end

            WindUI:Notify({
                Title = "Anti AFK",
                Content = "Anti AFK has been disabled.",
                Duration = 3.5
            })

            return
        end

        env.__AntiAFK_Running = true

        env.__AntiAFK_Connection = LocalPlayer.Idled:Connect(function()
            if not env.__AntiAFK_Running then return end

            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end)

        task.spawn(function()
            while env.__AntiAFK_Running do
                task.wait(300)

                if env.__AntiAFK_Running then
                    pcall(function()
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton2(Vector2.new())
                    end)
                end
            end
        end)

        WindUI:Notify({
            Title = "Anti AFK",
            Content = "Anti AFK is now running!",
            Duration = 3.5
        })
    end
})

SettingsTab:Section({ Title = "Background" })

SettingsTab:Slider({
    Title = "Background Visibility",
    Step = 0.01,
    Value = { Min = 0, Max = 1, Default = 0.35 },
    Flag = "BackgroundVisibility",
    Callback = function(v)
        Window:SetBackgroundImageTransparency(1 - v)
    end
})

-- [[ MERCHANT ]] --

local merchantItemNames = {}
local merchantItemKeys = {}
local merchantStock = {}

local MerchantItemDropdown
local merchantAutoBusy = false
local merchant2AutoBusy = false

local function getMerchantItemName(key)
    local item = MerchantConfig.Items and MerchantConfig.Items[key]

    if type(item) == "table" and item.Name then
        return tostring(item.Name)
    end

    return tostring(key)
end

local function getMerchantItemStock(item)
    if type(item) ~= "table" then
        return tonumber(item) or 0
    end

    return tonumber(
        item.Stock
        or item.Amount
        or item.Quantity
        or 0
    ) or 0
end

local function buildMerchantItemList()
    table.clear(merchantItemNames)
    table.clear(merchantItemKeys)

    for _, key in ipairs(MerchantConfig.Order or {}) do
        if MerchantConfig.Items and MerchantConfig.Items[key] then
            local name = getMerchantItemName(key)
            local stock = getMerchantItemStock(merchantStock[key])

            local displayName = string.format(
                "%s [STOCK: %d]",
                name,
                stock
            )

            table.insert(merchantItemNames, displayName)
            merchantItemKeys[displayName] = key
        end
    end
end

local function fetchMerchantStock()
    local success, result = pcall(function()
        return GetMerchantStock:InvokeServer()
    end)

    table.clear(merchantStock)

    if not success or type(result) ~= "table" then
        return false
    end

    for key, item in pairs(result) do
        local itemKey = key

        if type(item) == "table" then
            itemKey = item.Key or item.Id or key
        end

        merchantStock[itemKey] = item
    end

    return true
end

local function refreshMerchant()
    local selectedKeys = {}

    for key, selected in pairs(cfg.merchantItems) do
        if selected then
            selectedKeys[key] = true
        end
    end

    fetchMerchantStock()
    buildMerchantItemList()

    if not MerchantItemDropdown then
        return
    end

    pcall(function()
        MerchantItemDropdown:SetValues(merchantItemNames)

        local selectedNames = {}

        for _, displayName in ipairs(merchantItemNames) do
            local key = merchantItemKeys[displayName]

            if selectedKeys[key] then
                table.insert(selectedNames, displayName)
            end
        end

        if MerchantItemDropdown.SetValue then
            MerchantItemDropdown:SetValue(selectedNames)
        end
    end)
end

local function showMerchantBuyNotification(names)
    if type(names) ~= "table" or #names == 0 then
        return
    end

    local content = #names == 1
        and "Bought 1x " .. tostring(names[1])
        or "Bought 1x each of " .. tostring(#names) .. " selected items."

    pcall(function()
        WindUI:Notify({
            Title = "Merchant",
            Content = content,
            Duration = 1.5
        })
    end)
end

local function buyMerchantSelected()
    fetchMerchantStock()

    local boughtNames = {}
    local hasSelected = false
    local hasAvailableStock = false

    for key, selected in pairs(cfg.merchantItems) do
        if selected then
            hasSelected = true

            local item = merchantStock[key]
            local stock = getMerchantItemStock(item)
            local owned = type(item) == "table" and item.Owned == true

            if stock > 0 and not owned then
                hasAvailableStock = true

                local success, result = pcall(function()
                    return BuyMerchantItem:InvokeServer(key)
                end)

                if success and result ~= false then
                    table.insert(
                        boughtNames,
                        getMerchantItemName(key)
                    )
                end

                task.wait(0.5)
            end
        end
    end

    refreshMerchant()

    if #boughtNames > 0 then
        showMerchantBuyNotification(boughtNames)
    elseif hasSelected and not hasAvailableStock then
        pcall(function()
            WindUI:Notify({
                Title = "Merchant",
                Content = "No selected item available.",
                Duration = 1.5
            })
        end)
    elseif not hasSelected then
        pcall(function()
            WindUI:Notify({
                Title = "Merchant",
                Content = "No selected item available.",
                Duration = 1.5
            })
        end)
    end
end

local function merchantAutoLoop()
    if merchantAutoBusy then
        return
    end

    merchantAutoBusy = true

    while cfg.autoMerchantBuy do
        fetchMerchantStock()

        for key, selected in pairs(cfg.merchantItems) do
            if selected then
                local item = merchantStock[key]

                if type(item) == "table" then
                    local stock = getMerchantItemStock(item)
                    local owned = item.Owned == true

                    if stock > 0 and not owned then
                        pcall(function()
                            BuyMerchantItem:InvokeServer(key)
                        end)

                        task.wait(0.5)
                    end
                end
            end
        end

        task.wait(0.5)
    end

    merchantAutoBusy = false
end

local function merchant2AutoLoop()
    if merchant2AutoBusy then
        return
    end

    merchant2AutoBusy = true

    while cfg.autoMerchant2Bread do
        local success, stockData = pcall(function()
            return GetMerchant2Stock:InvokeServer()
        end)

        if success and type(stockData) == "table" then
            local stock = tonumber(stockData.Stock or 0) or 0

            if stock > 0 then
                pcall(function()
                    BuyMerchant2Item:InvokeServer()
                end)
            end
        end

        task.wait(0.5)
    end

    merchant2AutoBusy = false
end

buildMerchantItemList()

MerchantItemDropdown = MerchantTab:Dropdown({
    Title = "Items",
    Desc = "Select Merchant items to buy",
    Values = merchantItemNames,
    Multi = true,
    AllowNone = true,
    Default = {},

    Callback = function(values)
        table.clear(cfg.merchantItems)

        for _, displayName in ipairs(values or {}) do
            local key = merchantItemKeys[displayName]

            if key then
                cfg.merchantItems[key] = true
            end
        end
    end
})

MerchantTab:Toggle({
    Title = "Auto Buy",
    Desc = "Automatically buys selected Merchant items",
    Value = cfg.autoMerchantBuy,

    Callback = function(value)
        cfg.autoMerchantBuy = value

        if value then
            task.spawn(merchantAutoLoop)
        end
    end
})

MerchantTab:Button({
    Title = "Manual Buy",
    Desc = "Buy selected Merchant items once",

    Callback = function()
        task.spawn(function()
            buyMerchantSelected()
        end)
    end
})

MerchantTab:Section({
    Title = "Merchant 2"
})

MerchantTab:Toggle({
    Title = "Auto Buy Bread",
    Desc = "Automatically buys Bread when stocked",
    Value = cfg.autoMerchant2Bread,

    Callback = function(value)
        cfg.autoMerchant2Bread = value

        if value then
            task.spawn(merchant2AutoLoop)
        end
    end
})

MerchantTab:Button({
    Title = "Manual Buy Bread",
    Desc = "Buy Bread once",

    Callback = function()
        task.spawn(function()
            local success, stockData = pcall(function()
                return GetMerchant2Stock:InvokeServer()
            end)

            if not success or type(stockData) ~= "table" then
                return
            end

            local stock = tonumber(stockData.Stock or 0) or 0

            if stock <= 0 then
                pcall(function()
                    WindUI:Notify({
                        Title = "Merchant 2",
                        Content = "No Bread available.",
                        Duration = 1.5
                    })
                end)

                return
            end

            local buySuccess = pcall(function()
                BuyMerchant2Item:InvokeServer()
            end)

            if buySuccess then
                pcall(function()
                    WindUI:Notify({
                        Title = "Merchant 2",
                        Content = "Bought 1x Bread",
                        Duration = 1.5
                    })
                end)
            end
        end)
    end
})

Workspace:GetAttributeChangedSignal("GlobalMerchantEvent"):Connect(function()
    task.spawn(function()
        task.wait(0.5)
        refreshMerchant()
    end)
end)

Workspace:GetAttributeChangedSignal("GlobalMerchant2Event"):Connect(function()
    task.spawn(function()
        task.wait(0.5)
    end)
end)

if MerchantStockUpdated then
    MerchantStockUpdated.OnClientEvent:Connect(function()
        task.spawn(function()
            task.wait(0.25)
            refreshMerchant()
        end)
    end)
end

task.spawn(function()
    task.wait(0.5)
    refreshMerchant()
end)

ConfigTab:Section({ Title = "Configuration" })
local ConfigManager = Window.ConfigManager
local configName = ""
local selectedConfig = ""
local KarinderyaConfig

local ConfigNameInput = ConfigTab:Input({
    Title = "Config Name",
    Placeholder = "Enter a name...",
    Callback = function(value)
        configName = value
    end
})

local ConfigDropdown = ConfigTab:Dropdown({
    Title = "Select Config",
    Values = ConfigManager and ConfigManager:AllConfigs() or {},
    AllowNone = false,
    Callback = function(value)
        selectedConfig = value
    end
})

local function RefreshConfigs()
    ConfigDropdown:Refresh(ConfigManager and ConfigManager:AllConfigs() or {})
end

ConfigTab:Button({ Title = "Save Config", Icon = "save", Callback = function()
    if not ConfigManager or configName == "" or not configName:match("%S") then
        WindUI:Notify({ Title = "Config", Content = "Enter a config name first.", Duration = 3 })
        return
    end

    KarinderyaConfig = ConfigManager:CreateConfig(configName)
    KarinderyaConfig:Save()
    RefreshConfigs()

    WindUI:Notify({
        Title = "Config Saved",
        Content = "Saved as: " .. configName,
        Duration = 3
    })
end })

ConfigTab:Button({ Title = "Load Config", Icon = "folder-open", Callback = function()
    if not ConfigManager or selectedConfig == "" then
        WindUI:Notify({ Title = "Config", Content = "Select a config first.", Duration = 3 })
        return
    end

    KarinderyaConfig = ConfigManager:CreateConfig(selectedConfig)
    local loaded = KarinderyaConfig:Load()

    if loaded then
        WindUI:Notify({
            Title = "Config Loaded",
            Content = "Loaded: " .. selectedConfig,
            Duration = 3
        })
    else
        WindUI:Notify({
            Title = "Config",
            Content = "Failed to load: " .. selectedConfig,
            Duration = 3
        })
    end
end })

ConfigTab:Button({ Title = "Delete Selected", Icon = "trash-2", Callback = function()
    if not ConfigManager or selectedConfig == "" then
        WindUI:Notify({ Title = "Config", Content = "Select a config first.", Duration = 3 })
        return
    end

    local deleted, message = ConfigManager:DeleteConfig(selectedConfig)

    if deleted then
        WindUI:Notify({
            Title = "Config Deleted",
            Content = "Deleted: " .. selectedConfig,
            Duration = 3
        })

        selectedConfig = ""
        RefreshConfigs()
    else
        WindUI:Notify({
            Title = "Config",
            Content = message or "Failed to delete config.",
            Duration = 3
        })
    end
end })

ConfigTab:Button({ Title = "Delete All Configs", Icon = "trash-2", Callback = function()
    if not ConfigManager then
        return
    end

    local configs = ConfigManager:AllConfigs()

    if #configs == 0 then
        WindUI:Notify({
            Title = "Config",
            Content = "No configs to delete.",
            Duration = 3
        })
        return
    end

    for _, name in ipairs(configs) do
        ConfigManager:DeleteConfig(name)
    end

    selectedConfig = ""
    RefreshConfigs()

    WindUI:Notify({
        Title = "Configs Deleted",
        Content = "All saved configs have been deleted.",
        Duration = 3
    })
end })

task.defer(function()
    task.wait(0.5)
    pcall(function()
        WindUI:Notify({ Title = "Script Loaded", Content = "Thank you for choosing to use my script", Duration = 8 })
    end)
end)
