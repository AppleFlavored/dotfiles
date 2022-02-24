local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local bling = require("modules.bling")

--require("ui.widgets")
require("ui.decoration")
require("ui.bar")

awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle,
}

awful.screen.connect_for_each_screen(function(s)
    -- Set wallpaper
    -- TODO: move this to a function
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)