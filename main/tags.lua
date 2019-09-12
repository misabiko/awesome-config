local awful = require("awful")
local gears = require("gears")

local tags = {}
-- each screen has its own tag table.
local names = { "main", "www", "3", "4", "5", "6", "7", "8", "9" }
local l = awful.layout.suit    -- alias
-- try creating filled array and change [1] to l.max
local layouts = { l.tile, l.fair, l.tile, l.tile, l.tile, l.tile, l.tile, l.tile, l.tile }

awful.screen.connect_for_each_screen(function(s)
	local new_tags
	if screen.primary == s then
		new_tags = awful.tag(
			{"main", "www", "ide", "fd", "5", "6", "7", "8", "9"},
			s,
			{l.tile, l.tile, l.max, l.floating, l.tile, l.tile, l.tile, l.tile, l.tile }
		)
	else
		new_tags = awful.tag(names, s, layouts)
	end

	tags = gears.table.join(tags, new_tags)


	new_tags[1].selected = true
	new_tags[2].selected = true
end)

-- set an alias (e.g. tags["2/www"]
for i, tag in ipairs(tags) do
	tags[tostring(tag.screen.index) .. "/" .. tag.name] = tag
end

return tags
