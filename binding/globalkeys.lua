local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable VIM help for hotkeys widget when client with matching name is opened:
require("awful.hotkeys_popup.keys.vim")
local menubar = require("menubar")

local globalkeys = gears.table.join(
	awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
			  {description="show help", group="awesome"}),
	awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
			  {description = "view previous", group = "tag"}),
	awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
			  {description = "view next", group = "tag"}),
	awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
			  {description = "go back", group = "tag"}),

	awful.key({ modkey,           }, "j",
		function ()
			awful.client.focus.byidx( 1)
		end,
		{description = "focus next by index", group = "client"}
	),
	awful.key({ modkey,           }, "k",
		function ()
			awful.client.focus.byidx(-1)
		end,
		{description = "focus previous by index", group = "client"}
	),
	awful.key({ modkey,           }, "w", function () RC.mainmenu:show() end,
			  {description = "show main menu", group = "awesome"}),

	-- Layout manipulation
	awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
			  {description = "swap with next client by index", group = "client"}),
	awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
			  {description = "swap with previous client by index", group = "client"}),
	awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
			  {description = "focus the next screen", group = "screen"}),
	awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
			  {description = "focus the previous screen", group = "screen"}),
	awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
			  {description = "jump to urgent client", group = "client"}),
	awful.key({ modkey,           }, "Tab",
		function ()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		{description = "go back", group = "client"}),
	awful.key({ modkey,           }, "space", function () awful.layout.inc( 1) end,
          	{description = "select next", group = "layout"}),
	awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1) end,
			{description = "select previous", group = "layout"}),

	-- Standard program
	awful.key({ modkey,           }, "Return", function () awful.spawn(RC.vars.terminal) end,
			  {description = "open a terminal", group = "launcher"}),
	awful.key({ modkey,           }, "z", function () awful.spawn(RC.vars.terminal) end,
			  {description = "open a terminal", group = "launcher"}),
	awful.key({ modkey, "Control" }, "r", awesome.restart,
			  {description = "reload awesome", group = "awesome"}),
	awful.key({ modkey, "Shift"   }, "q", awesome.quit,
			  {description = "quit awesome", group = "awesome"}),

	awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)                 end,
			  {description = "increase master width factor", group = "layout"}),
	awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)                 end,
			  {description = "decrease master width factor", group = "layout"}),
	awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true)        end,
			  {description = "increase the number of master clients", group = "layout"}),
	awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true)        end,
			  {description = "decrease the number of master clients", group = "layout"}),
	awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)           end,
			  {description = "increase the number of columns", group = "layout"}),
	awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)           end,
			  {description = "decrease the number of columns", group = "layout"}),
	awful.key({ modkey     }, "b", function () awful.spawn(RC.vars.browser)          end,
			  {description = "launch Browser", group = "launcher"}),
	awful.key({ modkey, "Control"}, "Escape", function () awful.spawn("/usr/bin/rofi -show drun -modi drun") end,
			  {description = "launch rofi", group = "launcher"}),
	awful.key({ modkey,           }, "e", function () awful.spawn(RC.vars.filemanager)            end,
			  {description = "launch filemanager", group = "launcher"}),
	awful.key({                   }, "Print", function () awful.spawn.with_shell("sleep 0.1 && /usr/bin/i3-scrot -d")   end,
			  {description = "capture a screenshot", group = "screenshot"}),
	awful.key({"Control"          }, "Print", function () awful.spawn.with_shell("sleep 0.1 && /usr/bin/i3-scrot -w")   end,
			  {description = "capture a screenshot of active window", group = "screenshot"}),
	awful.key({"Shift"            }, "Print", function () awful.spawn.with_shell("sleep 0.1 && /usr/bin/maim -os ~/Dropbox/Photos/Screenshots/$(date +%s).png")   end,
			  {description = "capture a screenshot of selection", group = "screenshot"}),

	awful.key({ modkey, "Control" }, "n",
			  function ()
				  local c = awful.client.restore()
				  -- Focus restored client
				  if c then
					  client.focus = c
					  c:raise()
				  end
			  end,
			  {description = "restore minimized", group = "client"}),

	-- Prompt
	awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
			  {description = "run prompt", group = "launcher"}),

	awful.key({ modkey, "Control" }, "o",
			  function ()
				  awful.prompt.run {
					prompt       = "Run Lua code: ",
					textbox      = awful.screen.focused().mypromptbox.widget,
					exe_callback = awful.util.eval,
					history_path = awful.util.get_cache_dir() .. "/history_eval"
				  }
			  end,
			  {description = "lua execute prompt", group = "awesome"}),
	-- Menubar
	awful.key({ modkey }, "p", function() menubar.show() end,
			  {description = "show the menubar", group = "launcher"}),

	--awful.key({ "Mod1" }, "Tab", function()
	--    switcher.switch( 1, "Mod1", "Alt_L", "Shift", "Tab")
	--end),

	--awful.key({ "Mod1", "Shift" }, "Tab", function()
	--    switcher.switch(-1, "Mod1", "Alt_L", "Shift", "Tab")
	--end),

	awful.key({ "Mod1" }, "Tab", function()
		awful.menu.clients()
	end),
	awful.key({ "Mod1", "Shift" }, "Tab", function()
		awful.menu.clients()
	end),

	awful.key({"Shift"}, "Alt_L", function() RC.kbdcfg.switch_next() end),
	awful.key({"Mod1"}, "Shift_L", function() RC.kbdcfg.switch_next() end)
)

for i = 1, 9 do
	globalkeys = gears.table.join(globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9,
				  function ()
						local screen = awful.screen.focused()
						local tag = screen.tags[i]
						if tag then
						   tag:view_only()
						end
				  end,
				  {description = "view tag #"..i, group = "tag"}),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9,
				  function ()
					  local screen = awful.screen.focused()
					  local tag = screen.tags[i]
					  if tag then
						 awful.tag.viewtoggle(tag)
					  end
				  end,
				  {description = "toggle tag #" .. i, group = "tag"}),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9,
				  function ()
					  if client.focus then
						  local tag = client.focus.screen.tags[i]
						  if tag then
							  client.focus:move_to_tag(tag)
						  end
					 end
				  end,
				  {description = "move focused client to tag #"..i, group = "tag"}),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
				  function ()
					  if client.focus then
						  local tag = client.focus.screen.tags[i]
						  if tag then
							  client.focus:toggle_tag(tag)
						  end
					  end
				  end,
				  {description = "toggle focused client on tag #" .. i, group = "tag"})
	)
end

root.keys(globalkeys)
