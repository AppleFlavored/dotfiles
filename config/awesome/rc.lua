pcall(require, "luarocks.loader")

-- Standard library
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- Initialize theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- Input Modules
local bling = require("modules.bling")

-- Import everything else
require("awful.autofocus")
require("awful.hotkeys_popup.keys")

require("config")
require("ui")
require("signals")
require("autostart")

if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "An error occurred!",
        text = awesome.startup_errors
    })
end

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--     c:emit_signal("request::activate", "mouse_enter", { raise = false })
-- end)

collectgarbage("setpause", 250)
collectgarbage("setstepmul", 750)
