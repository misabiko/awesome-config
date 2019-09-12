local awful = require("awful")
local gears = require("gears")

return gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise()
                 RC.mainmenu:hide() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
)
