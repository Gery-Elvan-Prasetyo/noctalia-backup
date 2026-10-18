-- Auto-start config
-- if you dont use UWSM add your auto start programs here, otherwise use XDG autostart https://wiki.archlinux.org/title/XDG_Autostart

hl.on("hyprland.start", function ()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("noctalia")
    hl.exec_cmd("xhost +SI:localuser:root")
    --hl.exec_cmd("sleep 2 && awww-daemon")
    hl.exec_cmd("sleep 1 && fcitx5 -d --replace") -- Japanese input method
    hl.exec_cmd("sleep 3 && dbus-update-activation-environment --systemd GTK_IM_MODULE=fcitx QT_IM_MODULE=fcitx XMODIFIERS=@im=fcitx SDL_IM_MODULE=fcitx") -- propagate IM env
end)
