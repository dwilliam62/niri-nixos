{pkgs}:
pkgs.writeShellScriptBin "powermenu" ''
  options="lock\nlogout\nreboot\nshutdown"
  choice="$(printf "%b" "$options" | rofi -dmenu -p " " -no-custom \
    -theme-str 'entry { enabled: false; }' \
    -theme-str 'prompt { enabled: false; }' \
    -theme-str 'inputbar { children: []; enabled: false; }' \
    -theme-str 'listview { lines: 4; fixed-height: true; }' \
    -theme-str 'window { width: 300px; }')"

  case "$choice" in
    lock)
      loginctl lock-session
      ;;
    logout)
      if [ -n "$XDG_SESSION_ID" ]; then
        loginctl terminate-session "$XDG_SESSION_ID"
      elif command -v niri-msg >/dev/null 2>&1; then
        niri-msg exit
      elif command -v hyprctl >/dev/null 2>&1; then
        hyprctl dispatch exit
      else
        loginctl terminate-user "$USER"
      fi
      ;;
    reboot)
      systemctl reboot
      ;;
    shutdown)
      systemctl poweroff
      ;;
    *)
      exit 0
      ;;
  esac
''
