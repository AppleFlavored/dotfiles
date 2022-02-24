local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")

awful.screen.connect_for_each_screen(function(s)
    awful.tag({ "1", "2", "3", "4", "5", "6" })

    local taglist_buttons = gears.table.join(
        awful.button({}, 1, function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({}, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end)
    )

    taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {
            shape = gears.shape.rect,
        },
        layout = {
            spacing = 0,
            spacing_widget = {
                color = '#181e23',
                shape = gears.shape.rounded_rect,
                widget = wibox.widget.separator,
            },
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        {
                            {
                                id = 'text_role',
                                widget = wibox.widget.textbox,
                            },
                            margins = 0,
                            widget = wibox.container.margin,
                        },
                        widget = wibox.container.background,
                    },
                    {
                        id     = 'index_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left = 7,
                right = 7,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            -- Add support for hover colors and an index label
            create_callback = function(self, c3, index, objects) --luacheck: no unused args
                self:connect_signal('mouse::enter', function()
                    if #c3:clients() > 0 then
                        awesome.emit_signal("bling::tag_preview::update", c3)
                        awesome.emit_signal("bling::tag_preview::visibility", s, true)
                    end
    
                end)
                self:connect_signal('mouse::leave', function()
                    awesome.emit_signal("bling::tag_preview::visibility", s, false)
                    if self.has_backup then self.bg = self.backup end
                end)
            end,
            update_callback = function(self, c3, index, objects)
            end,
        },
        buttons = taglist_buttons
    }

    local clock = wibox.widget.textclock(
        '<span> %a %I:%M </span>', 5
    )

    -- volume:buttons(gears.table.join( -- Left click - Mute / Unmute
    --     awful.button({}, 1, function() helpers.volume_control(0) end),
    --     -- Scroll - Increase / Decrease volume
    --     awful.button({}, 4, function() helpers.volume_control(5) end),
    --     awful.button({}, 5, function() helpers.volume_control(-5) end)
    -- ))

    s.wibar = awful.wibar({
        screen = s,
        height = 30,
        bg = "#0000000",
        widget = wibox.container.background(),
    })

    s.wibar:setup {
        {
            {
                {
                    layout = wibox.layout.align.horizontal,
                    expand = "none",
                    { -- Left widgets
                        layout = wibox.layout.fixed.horizontal,
                        start,
                        taglist,
                    },
                    {
                        music,
                        layout = wibox.layout.fixed.horizontal, 
                    },
                    { -- Right widgets
                        layout = wibox.layout.fixed.horizontal,
                        wibox.layout.margin(volume, 20, 20, 20, 20), 
                        wibox.layout.margin(clock, 0, 10, 0, 0),
                    },
                },
                bg = "#22272c",
                widget = wibox.container.background
            },
            widget = wibox.container.margin,
            bottom = 1,
        },
        bg = "#131619",
        widget = wibox.container.background
    }
end)