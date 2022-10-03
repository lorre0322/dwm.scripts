#!/bin/sh

case $BUTTON in
	3) notify-send "🌐 网络流量模块" "\- 查看实时网络流量
- 🔼: 下行流量
- 🔽: 上行流量" ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

update() {
    sum=0
    for arg; do
        read -r i < "$arg"
        sum=$(( sum + i ))
    done
    cache=${XDG_CACHE_HOME:-$HOME/.cache}/${1##*/}
    [ -f "$cache" ] && read -r old < "$cache" || old=0
    printf %d\\n "$sum" > "$cache"
    printf %d\\n $(( sum - old ))
}

RX=$(update /sys/class/net/[ew]*/statistics/rx_bytes)
#TX=$(update /sys/class/net/[ew]*/statistics/tx_bytes)

# 换算单位
# 如果 接收/发送 小于 1024/大于1048576 换算单位
# 下载
if [[ $RX -lt 2048 ]];then
    RX="${RX}B/s"
elif [[ $TX -gt 1048576 ]];then
    RX=$(echo $RX | awk '{printf("%0.2fMB/s", $1/1048576 )}')
else
    RX=$(echo $RX | awk '{printf("%0.2fKB/s", $1/1024)}')
fi

# 上传
#if [[ $TX -lt 1024 ]];then
#    TX="${TX}B/s"
#elif [[ $TX -gt 1048576 ]];then
#    TX=$(echo $TX | awk '{printf("%0.2fMB/s",$1/1048576 }')
#else
#    TX=$(echo $TX | awk '{printf("%0.3fKB/s",$1/1024}')
#fi
printf "   $RX"
