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

command -v hyprctl >/dev/null 2>&1 || exit 0
command -v jq >/dev/null 2>&1 || exit 0

active_json=$(hyprctl -j activeworkspace 2>/dev/null) || exit 0
active_id=$(jq -r '.id // empty' <<<"$active_json" 2>/dev/null) || exit 0
active_name=$(jq -r '.name // empty' <<<"$active_json" 2>/dev/null) || exit 0
[ -n "$active_id" ] || exit 0

# Hanya workspace numerik biasa yang didukung (bukan special / named)
if ! [[ "$active_id" =~ ^[0-9]+$ ]] || [ "$active_id" -le 0 ]; then
    notify "'$active_name' tidak bisa dihapus otomatis"
    exit 0
fi

mapfile -t ids < <(hyprctl -j workspaces 2>/dev/null | jq -r '.[].id' 2>/dev/null | sort -n)
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
done < <(hyprctl -j clients 2>/dev/null | jq -r --argjson ws "$active_id" '.[] | select(.workspace.id == $ws) | .address' 2>/dev/null)

# Lepas persistence (bila ada) agar workspace kosong ikut terhapus
persistent=$(hyprctl -j workspaces 2>/dev/null | jq -r --argjson ws "$active_id" '.[] | select(.id == $ws) | .ispersistent' 2>/dev/null || true)
if [ "$persistent" = "true" ]; then
    hyprctl eval "hl.workspace_rule({ workspace = \"$active_name\", persistent = false })" >/dev/null 2>&1 || true
fi

# Pindah fokus ke target → workspace lama (kosong) dihancurkan
hyprctl dispatch "hl.dsp.focus({ workspace = $target })" >/dev/null 2>&1 || true

# Verifikasi hasil
remaining=$(hyprctl -j workspaces 2>/dev/null | jq -r --argjson ws "$active_id" '[.[] | select(.id == $ws)] | length' 2>/dev/null || echo 1)
if [ "${remaining:-1}" -ge 1 ]; then
    notify "Gagal menghapus workspace $active_name (masih ada)"
    exit 0
fi

notify "Workspace $active_name dihapus, jendela dipindah ke workspace $target"
