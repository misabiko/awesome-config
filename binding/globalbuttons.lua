local awful = require("awful")
local gears = require("gears")

root.buttons(gears.table.join(
	awful.button({ }, 1, function () RC.mainmenu:hide() end),
	awful.button({ }, 3, function () RC.mainmenu:toggle() end),
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)
))
