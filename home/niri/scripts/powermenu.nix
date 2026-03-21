{pkgs}:
pkgs.writeShellScriptBin "powermenu" ''
  options="lock\nlogout\nreboot\nshutdown"
  choice="$(printf "%b" "$options" | rofi -dmenu -p " " -no-custom \
    -theme-str 'entry { enabled: false; }' \
    -theme-str 'prompt { enabled: false; }' \
    -theme-str 'inputbar { children: []; enabled: false; }' \
    -theme-str 'listview { lines: 4; fixed-height: true; spacing: 8px; }' \
    -theme-str 'element { padding: 8px 0; }' \
    -theme-str 'element-text { horizontal-align: 0.5; }' \
    -theme-str 'window { width: 360px; }')"

  case "$choice" in
    lock)
      loginctl lock-session
      ;;
    logout)
      if command -v niri-msg >/dev/null 2>&1; then
        niri-msg exit || true
      fi
      if [ -n "$XDG_SESSION_ID" ]; then
        loginctl terminate-session "$XDG_SESSION_ID"
      elif command -v hyprctl >/dev/null 2>&1; then
        hyprctl dispatch exit
      else
        loginctl terminate-user "$USER"
      fi
      # Ensure niri-session isn't left running
      pkill -f niri-session 2>/dev/null || true
      pkill -x niri 2>/dev/null || true
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
