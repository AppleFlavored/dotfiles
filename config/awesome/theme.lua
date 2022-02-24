local gfs = require("gears.filesystem")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")

local dpi = xresources.apply_dpi

local theme = {}

theme.font = "Source Code Pro 10"

theme.bg_normal = "#222222"
theme.bg_focus = "#333a42"
theme.bg_urgent = "#ff0000"
theme.bg_minimize = "#4444444"

theme.fg_normal = "#ffffff"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.useless_gap = dpi(6)
theme.border_width = dpi(2)
theme.border_normal = "#22272c"
theme.border_focus = "#597387"

theme.notification_bg = "#22272c"
theme.notification_fg = theme.fg_normal
theme.notification_border_color = "#597387"
theme.notification_border_width = dpi(2)

theme.taglist_fg = "#ffffff"
theme.taglist_fg_empty = "#4f4f4f"
theme.taglist_fg_occupied = "#a0a0a0"

theme.wallpaper = gfs.get_configuration_dir() .. "wallpapers/wallpaper4.jpg"

theme.icon_theme = nil

return theme
