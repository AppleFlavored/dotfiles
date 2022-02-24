local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")

local modkey = "Mod4"

local terminal = "kitty"
local launcher = "rofi"
local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor

local keys = {}

keys.desktopbuttons = gears.table.join()

keys.globalkeys = gears.table.join(
    -- Tags
    awful.key({ modkey }, "Left", awful.tag.viewprev,
        { description = "view previous", group = "tag" }
    ),
    awful.key({ modkey }, "Right", awful.tag.viewnext,
        { description = "view next", group = "tag" }
    ),

    -- Client
    awful.key({ modkey }, "Tab",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ modkey, "Shift" }, "Tab",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }
    ),

    -- Start
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end,
        { description = "open terminal", group = "launcher" }
    ),
    awful.key({ modkey }, "r", function() awful.spawn("rofi -show drun") end,
        { description = "open launcher", group = "launcher" }    
    ),

    -- Audio
    awful.key({}, "XF86AudioRaiseVolume",
        function()
            awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%",
                function() awesome.emit_signal("volume_refresh") end)
        end,
        { description = "raise volume by 5%", group = "audio" }
    ),
    awful.key({}, "XF86AudioLowerVolume",
        function()
            awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%",
                function() awesome.emit_signal("volume_refresh") end)
        end,
        { description = "lower volume by 5%", group = "audio" }
    ),
    awful.key({}, "XF86AudioMute",
        function()
            awful.spawn.easy_async_with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle",
                function() awesome.emit_signal("volume_refresh") end)
        end,
        { description = "mute audio", group = "audio" }
    ),

    -- Awesome
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }
    ),
    awful.key({ modkey, "Shift" }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }
    )
)

for i = 1, 9 do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. i, group = "tag" }
        ),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag" }
        )
    )
end

clientkeys = gears.table.join(
    awful.key({ modkey }, "Up",
        function(c)
            c.maximized = true
            c:raise()
        end,
        { description = "maximize", group = "client" }
    ),
    awful.key({ modkey }, "Down",
        function(c)
            c.maximized = false
            c:raise()
        end,
        { description = "unmaximize", group = "client" }
    ),
    awful.key({ modkey, "Shift" }, "f", awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }
    ),
    awful.key({ modkey }, "q", function(c) c:kill() end,
        { description = "close", group = "client" }
    )
)

clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

return keys