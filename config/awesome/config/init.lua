local beautiful = require("beautiful")
local gears = require("gears")

local keys = require("config.keys")
root.buttons(keys.desktopbuttons)
root.keys(keys.globalkeys)

require("config.rules")