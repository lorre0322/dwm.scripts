#!/bin/sh

# Prints the current volume or ð if muted.

case $BUTTON in
	1) setsid -f "$TERMINAL" -e pulsemixer ;;
	2) pamixer -t; pkill -RTMIN+7 dwmblocks ;;
	4) amixer set Master 5%+ ;;
	5) amixer set Master 5%- ;;
	3) notify-send "ð¢ é³éæ¨¡å" "\- é³éè°è:ð,ð,ð,ð
- å·¦é®ç¹å»æå¼pulsemixer
- ä¸­é®ç¹å»éé³.
- æ»è½®ä¸ä¸è°æ´é³é." ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

MUTED=$(amixer sget Master | tail -n1 |sed -r "s/.*\[(.*)\]/\1/")
VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
# MUTED=$(pamixer --get-mute)
# VOL=$(pamixer --get-volume)

if [ "$MUTED" = "off" ]; then
    printf " ïª $VOL%s%%"
elif [ "$VOL" -gt -1 ] && [ "$VOL" -le 30 ]; then
    printf " ï¦ $VOL%s%%"
elif [ "$VOL" -gt 30 ] && [ "$VOL" -le 70 ]; then
    printf " ï©½ $VOL%s%%"
else
    printf " ï©½ $VOL%s%%"
fi
