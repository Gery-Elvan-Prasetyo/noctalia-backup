hl.config({
    dwindle = {
        preserve_split = true,
    },
    general = {
        -- Biarkan aplikasi fullscreen (game) request tearing -> frame rate & latency lebih bagus.
        -- Tidak mengubah animasi/efek apa pun; hanya aktif kalau aplikasi memang memintanya.
        allow_tearing = true,
    },
    misc = {
        col = {
            splash = CACHYLGREEN,
        },
        middle_click_paste = false,
        enable_swallow = true,
        swallow_regex = "(kitty|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)",
        vrr = 3,
    },
    xwayland = {
        force_zero_scaling = true
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
})
