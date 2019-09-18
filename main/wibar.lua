local awful = require("awful")
-- Widget and layout library
local wibox = require("wibox")
local keyboard_layout = require("keyboard_layout")
local beautiful = require("beautiful")
local gears = require("gears")
local worldclock_popup = require("main.worldclock_popup")

local taglistbuttons = require("binding.taglistbuttons")
local tasklistbuttons = require("binding.tasklistbuttons")

-- create systray widget
local systray = wibox.widget.systray()
systray.visible = false

-- system tray toggle button
local systray_toggle = wibox.widget.textbox(" ")
systray_toggle:buttons(gears.table.join(
    systray_toggle:buttons(),
    awful.button({}, 1, nil, function ()
		systray.visible = not systray.visible
    end)
))

-- keyboard map indicator and switcher
RC.kbdcfg = keyboard_layout.kbdcfg({cmd = "fcitx-remote -s", type = "tui"})

RC.kbdcfg.add_primary_layout("English", "EN", "fcitx-keyboard-ca-multix")
RC.kbdcfg.add_primary_layout("Japanese", "JP", "mozc")
RC.kbdcfg.bind()

RC.kbdcfg.widget:buttons(
    awful.util.table.join(awful.button({ }, 1, function () RC.kbdcfg.switch_next() end),
                          awful.button({ }, 3, function () RC.kbdcfg.menu:toggle() end))
)

-- create textclock widgets
local datewidget = wibox.widget.textclock("%a %Y/%m/%d")
local clockwidget = wibox.widget.textclock("%I:%M %p ")

-- attach calendar to datewidget
local calendar = awful.widget.calendar_popup.month()
calendar:attach( datewidget, "br", {on_hover = false} )

-- attach world clock to clockwidget
local worldclock = worldclock_popup()
worldclock:attach( clockwidget, "br", {on_hover = false} )

local darkblue    = beautiful.bg_focus
local blue        = "#9ebaba"
local red         = "#eb8f8f"
local separator = wibox.widget.textbox(' <span color="' .. blue .. '">| </span>')
local spacer = wibox.widget.textbox(' <span color="' .. blue .. '"> </span>')

awful.screen.connect_for_each_screen(function(s)
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglistbuttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklistbuttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "bottom", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            RC.launcher,
            s.mytaglist,
            s.mypromptbox,
            separator,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            systray,
			systray_toggle,
            separator,
            RC.kbdcfg.widget,
            separator,
            datewidget,
            separator,
            clockwidget,
            s.mylayoutbox,
        },
    }
end)
