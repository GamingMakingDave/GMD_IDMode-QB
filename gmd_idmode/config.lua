Config = {}

Config.DebugMode = false -- always leave false unless you know what you are doing

Config.DiscordBotToken = ''
Config.GuildId = ''

Config.ShowOwnClientInfo = true -- false become client own info back true only other playersinfo

Config.TagHotkey = 56 -- hotkey to activate IDMode

Config.ShowTime = 10 -- you need to enter seconds here

-- drawtext settings
Config.FontGroupText = 4
Config.FontGroupScale = 0.40

Config.FontBasicText = 4
Config.FontBasicScale = 0.30

Config.FontDiscordText = 4
Config.FontDiscordScale = 0.30

-- marker settings
Config.MarkerType = 1
Config.MarkerHigh = 0.5
Config.MarkerColorR = 255
Config.MarkerColorG = 0
Config.MarkerColorB = 0
Config.MarkerColorA = 220
Config.MarkerZ = 1.0

-- here you can create groups and customize all groups make sure that the group is registered in your DB!!!
Config.canTagUse = {
    ['admin'] = {
        CanSeePlayerGrop = true, -- if true can see other player group
        CanSeeId = true, -- if true can see other player server ID
        CanSeeSteamName = true, -- if true can see other player steam name
        CanSeeIngameName = true, -- if true can see other player ingame name
        CanSeediscordName = true, -- if true can see other player discord name
        TagRange = 100.00 -- see other playerdata in range
    },
    ['streamer'] = {
        CanSeePlayerGrop = true,
        CanSeeId = true,
        CanSeeSteamName = false,
        CanSeeIngameName = true,
        CanSeediscordName = true,
        TagRange = 15.00
    },

    ['user'] = {
        CanSeePlayerGrop = true,
        CanSeeId = true,
        CanSeeSteamName = false,
        CanSeeIngameName = false,
        CanSeediscordName = false,
        TagRange = 10.00
    },

    -- here was commented out because otherwise you would have user Wallhack with good community you can activate this group with pleasure
    -- ['user'] = {
    --     CanSeePlayerGrop = false,
    --     CanSeeId = true,
    --     CanSeeSteamName = false,
    --     CanSeeIngameName = false,
    --     CanSeediscordName = false,
    --     TagRange = 5.00
    -- }
}

Config.TagColors = {
    ['admin'] = {255, 0, 0, 255},
    ['streamer'] = {127, 0, 185, 255},
    ['user'] = {25, 107, 0, 255},
}