local awful = require("awful")
local gears = require("gears")

return gears.table.join(
     awful.button({ }, 1, function (c)
                              if c == client.focus then
                                  c.minimized = true
                              else
                                  -- without this, the following
                                  -- :isvisible() makes no sense
                                  c.minimized = false
                                  if not c:isvisible() and c.first_tag then
                                      c.first_tag:view_only()
                                  end
                                  -- this will also un-minimize
                                  -- the client, if needed
                                  client.focus = c
                                  c:raise()
                              end
                          end),
     awful.button({ }, 3, function()
	     local instance = nil
	     return function ()
	         if instance and instance.wibox.visible then
	             instance:hide()
	             instance = nil
	         else
	             instance = awful.menu.clients({ theme = { width = 250 } })
	         end
	     end
	 end),
     awful.button({ }, 4, function ()
                              awful.client.focus.byidx(1)
                          end),
     awful.button({ }, 5, function ()
                              awful.client.focus.byidx(-1)
                          end)
)
