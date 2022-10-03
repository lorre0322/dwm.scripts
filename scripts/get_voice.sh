#!/bin/sh

# Prints the current volume or 🔇 if muted.

case $BUTTON in
	1) setsid -f "$TERMINAL" -e pulsemixer ;;
	2) pamixer -t; pkill -RTMIN+7 dwmblocks ;;
	4) amixer set Master 5%+ ;;
	5) amixer set Master 5%- ;;
	3) notify-send "📢 音量模块" "\- 音量调节:🔇,🔈,🔉,🔊
- 左键点击打开pulsemixer
- 中键点击静音.
- 滑轮上下调整音量." ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

MUTED=$(amixer sget Master | tail -n1 |sed -r "s/.*\[(.*)\]/\1/")
VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
# MUTED=$(pamixer --get-mute)
# VOL=$(pamixer --get-volume)

if [ "$MUTED" = "off" ]; then
    printf " 婢 $VOL%s%%"
elif [ "$VOL" -gt -1 ] && [ "$VOL" -le 30 ]; then
    printf "  $VOL%s%%"
elif [ "$VOL" -gt 30 ] && [ "$VOL" -le 70 ]; then
    printf " 墳 $VOL%s%%"
else
    printf " 墳 $VOL%s%%"
fi
