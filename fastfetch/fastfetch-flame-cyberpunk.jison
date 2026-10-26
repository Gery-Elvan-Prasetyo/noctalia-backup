{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",

  // FLAME CYBERPUNK — based on your uploaded CachyOS config.jsonc
  // Keeps your existing Kitty image logo and original image path.
  "logo": {
    "type": "kitty",
    "source": "/home/arianeve/Pictures/pffp/flame3.jpg",
    "height": 18,
    "padding": {
      "top": 1,
      "right": 3
    }
  },

  "display": {
    "separator": " 󰑃 ",
    "color": {
      "keys": "#FF7849",
      "output": "#E6E6FA",
      "separator": "#8B7CFF",
      "title": "#67E8F9"
    },
    "key": {
      "width": 14
    },
    "percent": {
      "type": 3
    },
    "bar": {
      "width": 10,
      "char": {
        "elapsed": "█",
        "total": "░"
      }
    }
  },

  "modules": [
    {
      "type": "title",
      "format": "{##67E8F9}{user-name}{##FF7849}@{##67E8F9}{host-name}{#}"
    },
    {
      "type": "custom",
      "format": "{##8B7CFF}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━{#}"
    },
    {
      "type": "custom",
      "format": "{##FF7849}󰍹  SYSTEM{#}"
    },
    "os",
    "host",
    "kernel",
    "uptime",
    "packages",
    "shell",
    "display",
    "de",
    "wm",
    {
      "type": "custom",
      "format": "{##8B7CFF}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━{#}"
    },
    {
      "type": "custom",
      "format": "{##67E8F9}󰻠  HARDWARE{#}"
    },
    "cpu",
    "gpu",
    "memory",
    "swap",
    "disk",
    "poweradapter",
    {
      "type": "custom",
      "format": "{##8B7CFF}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━{#}"
    },
    {
      "type": "custom",
      "format": "{##FF7849}󰏖  LOOK & NETWORK{#}"
    },
    "wmtheme",
    "icons",
    "terminal",
    "terminalfont",
    "localip",
    "locale",
    {
      "type": "custom",
      "format": "{##8B7CFF}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━{#}"
    },
    "colors",
    "break"
  ]
}
