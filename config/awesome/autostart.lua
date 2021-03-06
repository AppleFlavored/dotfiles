local awful = require("awful")
local gears = require("gears")

local config_dir = gears.filesystem.get_configuration_dir()

local function run_once(cmd)
    local findme = cmd
    local firstspace = cmd:find(' ')

    if firstspace then findme = cmd:sub(0, firstspace - 1) end

    awful.spawn.with_shell(string.format(
        "pgrep -u $USER -x %s > /dev/null || (%s)",
        findme, cmd), false)
end

run_once("picom -b --experimental-backend --config " ..
    gears.filesystem.get_configuration_dir() .. "config/picom.conf"
)

return autostart
