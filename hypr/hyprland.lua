-- CachyOS Hyprland Configuration


require("config.animations")
require("config.autostart")
require("config.colors")
require("config.variables")
require("config.environment")
require("config.inputs")
require("config.binds")
require("config.misc")
require("config.monitors")
require("config.windowrules")
require("config.workspaces")


-- For Noctalia Color templates
require("noctalia").apply_theme()
-- Keep the local window border settings as the final override of theme colors.
require("config.decorations")
