-- Look and feel configuration

-- Border colors are generated from the Noctalia palette by
-- ~/.local/share/noctalia-sync-hyprland.sh. Fall back to sane values if the
-- file is ever missing so a bad state can't break the whole compositor config.
local ok, noctalia = pcall(require, "config.noctalia-colors")
if not ok then
    noctalia = {
        active_border   = "rgba(ffffffff)",
        inactive_border = "rgba(c4c6cfff)",
        group_active    = "rgba(ffffffff)",
        group_inactive  = "rgba(c4c6cfff)",
        locked_active   = "rgba(ff5555ff)",
        locked_inactive = "rgba(c4c6cfff)",
    }
end

hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 8,
        border_size = 2,
        extend_border_grab_area = 10,
        resize_on_border = true,
        col = {
            active_border = noctalia.active_border,
            inactive_border = noctalia.inactive_border,
        },
    },
    group = {
        col = {
            border_active = noctalia.group_active,
            border_inactive = noctalia.group_inactive,
            border_locked_active = noctalia.locked_active,
            border_locked_inactive = noctalia.locked_inactive,
        },
        groupbar = {
            col = {
                active = noctalia.group_active,
                inactive = noctalia.group_inactive,
                locked_active = noctalia.locked_active,
                locked_inactive = noctalia.locked_inactive,
            },
        },
    },
    decoration = {
        dim_special = 0.3,
        rounding = 10,
        active_opacity = 0.95,
        inactive_opacity = 0.90,
        fullscreen_opacity = 1,
        blur = {
            size = 5,
            passes = 2,
            special = true,
        },
    },
})
