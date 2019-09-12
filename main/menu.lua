local menubar = require("menubar")
local freedesktop = require("freedesktop")

local _M = {}

awesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end, menubar.utils.lookup_icon("preferences-desktop-keyboard-shortcuts") },
    { "manual", RC.vars.terminal .. " -e man awesome", menubar.utils.lookup_icon("system-help") },
    { "edit config", RC.vars.gui_editor .. " " .. awesome.conffile,  menubar.utils.lookup_icon("accessories-text-editor") },
    { "restart", awesome.restart, menubar.utils.lookup_icon("system-restart") }
}

exitmenu = {
    { "log out", function() awesome.quit() end, menubar.utils.lookup_icon("system-log-out") },
    { "suspend", "systemctl suspend", menubar.utils.lookup_icon("system-suspend") },
    { "hibernate", "systemctl hibernate", menubar.utils.lookup_icon("system-suspend-hibernate") },
    { "reboot", "systemctl reboot", menubar.utils.lookup_icon("system-reboot") },
    { "shutdown", "poweroff", menubar.utils.lookup_icon("system-shutdown") }
}

return freedesktop.menu.build({
    icon_size = 32,
    before = {
        { "terminal", RC.vars.terminal, menubar.utils.lookup_icon("utilities-RC.vars.terminal") },
        { "browser", RC.vars.browser, menubar.utils.lookup_icon("internet-web-browser") },
        { "files", RC.vars.filemanager, menubar.utils.lookup_icon("system-file-manager") },
        -- other triads can be put here
    },
    after = {
        { "awesome", awesomemenu, "/usr/share/awesome/icons/awesome32.png" },
        { "exit", exitmenu, menubar.utils.lookup_icon("system-shutdown") },
        -- other triads can be put here
    }
})
