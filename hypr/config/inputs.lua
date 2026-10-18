-- Input configuration

hl.config({
    input = {
        sensitivity = 0.5,
        accel_profile = "flat",
        repeat_delay = 300,
        repeat_rate = 40,
        touchpad = {
          scroll_factor = 0.2,
          natural_scroll = true,    -- coba true dulu
        }
    },
    -- Uncomment the section below to enable software cursors; this can help with cursor display or behavior issues
    -- cursor = {
    --     no_hardware_cursors = 1,
    -- },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down",       action = "close" })
hl.gesture({ fingers = 3, direction = "up",         action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "left",       action = "float" })
