#!/usr/bin/env bash
# Hapus workspace Hyprland yang sedang aktif/fokus.
#
# Cara kerja:
#   1. Semua jendela di workspace aktif dipindahkan ke workspace tetangga
#      terdekat (berikutnya, atau sebelumnya bila yang aktif paling akhir).
#   2. Bila workspace tersebut persistent (didefinisikan via workspace rule),
#      status persistent-nya dilepas memakai `hyprctl eval`.
#   3. Fokus dipindahkan ke workspace target, sehingga workspace lama yang
#      sudah kosong otomatis dihancurkan oleh Hyprland.
#
# Catatan: penghapusan bersifat sementara sampai config di-reload/restart,
# karena rule persistent-nya tetap ada di config/workspaces.lua.

set -euo pipefail

notify() { notify-send -a Hyprland -u normal -t 3000 "Workspace" "$1" 2>/dev/null || true; }

active_id=$(hyprctl -j activeworkspace | jq -r '.id')
active_name=$(hyprctl -j activeworkspace | jq -r '.name')

# Hanya workspace numerik biasa yang didukung (bukan special / named)
if ! [[ "$active_id" =~ ^[0-9]+$ ]] || [ "$active_id" -le 0 ]; then
    notify "'$active_name' tidak bisa dihapus otomatis"
    exit 0
fi

mapfile -t ids < <(hyprctl -j workspaces | jq -r '.[].id' | sort -n)

if [ "${#ids[@]}" -le 1 ]; then
    notify "Tidak bisa menghapus workspace terakhir"
    exit 0
fi

# Pilih workspace target: berikutnya bila ada, kalau tidak pakai sebelumnya
target=""
for id in "${ids[@]}"; do
    if [ "$id" -gt "$active_id" ]; then
        target="$id"
        break
    fi
done
if [ -z "$target" ]; then
    for ((i = ${#ids[@]} - 1; i >= 0; i--)); do
        if [ "${ids[i]}" -lt "$active_id" ]; then
            target="${ids[i]}"
            break
        fi
    done
fi
if [ -z "$target" ]; then
    notify "Tidak menemukan workspace tujuan"
    exit 0
fi

# Pindahkan seluruh jendela dari workspace aktif ke workspace target
while read -r addr; do
    [ -n "$addr" ] || continue
    hyprctl dispatch "hl.dsp.window.move({ workspace = $target, window = \"address:$addr\" })" >/dev/null 2>&1 || true
done < <(hyprctl -j clients | jq -r --argjson ws "$active_id" '.[] | select(.workspace.id == $ws) | .address')

# Lepas persistence (bila ada) agar workspace kosong ikut terhapus
persistent=$(hyprctl -j workspaces | jq -r --argjson ws "$active_id" '.[] | select(.id == $ws) | .ispersistent')
if [ "$persistent" = "true" ]; then
    hyprctl eval "hl.workspace_rule({ workspace = \"$active_name\", persistent = false })" >/dev/null 2>&1 || true
fi

# Pindah fokus ke target → workspace lama (kosong) dihancurkan
hyprctl dispatch "hl.dsp.focus({ workspace = $target })" >/dev/null 2>&1 || true

notify "Workspace $active_name dihapus, jendela dipindah ke workspace $target"
