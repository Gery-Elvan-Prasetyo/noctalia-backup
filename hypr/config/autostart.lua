-- Auto-start config
-- if you dont use UWSM add your auto start programs here, otherwise use XDG autostart https://wiki.archlinux.org/title/XDG_Autostart

hl.on("hyprland.start", function ()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("noctalia")
    hl.exec_cmd("xhost +SI:localuser:root")
    --hl.exec_cmd("sleep 2 && awww-daemon")
    hl.exec_cmd("sleep 1 && fcitx5 -d --replace") -- Japanese input method
    hl.exec_cmd("sleep 3 && dbus-update-activation-environment --systemd GTK_IM_MODULE=fcitx QT_IM_MODULE=fcitx XMODIFIERS=@im=fcitx SDL_IM_MODULE=fcitx") -- propagate IM env

    -- === Daemon fitur (sebelumnya ditangani HyDE; sekarang start mandiri) ===
    -- Dipindahkan ke sini supaya semua fitur ini TETAP JALAN walau config
    -- Hyprland tidak lagi dilewati layer HyDE (HYPRLAND_CONFIG langsung ke
    -- hyprland.lua). Perintah & argumen sama persis dengan yang dipakai HyDE.
    hl.exec_cmd("dunst")                                            -- notifikasi (pemilik org.freedesktop.Notifications)
    hl.exec_cmd("wl-paste --type text --watch cliphist store")      -- clipboard: simpan histori teks
    hl.exec_cmd("wl-paste --type image --watch cliphist store")     -- clipboard: simpan histori gambar
    hl.exec_cmd("wl-clip-persist --clipboard regular")              -- clipboard tetap hidup saat app sumber ditutup
    hl.exec_cmd("hypridle")                                         -- idle / auto-lock (baca ~/.config/hypr/hypridle.conf)
    hl.exec_cmd("hyprsunset")                                       -- filter cahaya biru (baca ~/.config/hypr/hyprsunset.conf)
    hl.exec_cmd("nm-applet --indicator")                            -- tray jaringan
    hl.exec_cmd("udiskie --no-automount --smart-tray")              -- auto-mount USB/card reader
    hl.exec_cmd("blueman-applet")                                   -- tray bluetooth
    hl.exec_cmd("/home/arianeve/.local/lib/hyde/batterynotify.lua") -- notifikasi baterai (script HyDE, dipakai kembali)

end)
