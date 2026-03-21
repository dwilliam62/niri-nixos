{pkgs}:
pkgs.writeShellScriptBin "powermenu" ''
  options="lock\nlogout\nreboot\nshutdown"
  choice="$(printf "%b" "$options" | rofi -dmenu -p "Power")"

  case "$choice" in
    lock)
      loginctl lock-session
      ;;
    logout)
      if command -v hyprctl >/dev/null 2>&1; then
        hyprctl dispatch exit
      elif command -v niri-msg >/dev/null 2>&1; then
        niri-msg exit
      elif [ -n "$XDG_SESSION_ID" ]; then
        loginctl terminate-session "$XDG_SESSION_ID"
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
