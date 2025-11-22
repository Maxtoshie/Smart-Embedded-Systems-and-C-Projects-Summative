#!/bin/bash
# Project 2 - Advanced System Monitoring Script (No sudo needed)
# Author: Maxtoshie - Summative 2025

# Use user-writable locations only
LOGFILE="$HOME/sysmonitor.log"
CONFIGFILE="$HOME/.sysmonitor.conf"

# Default thresholds
CPU_THRESH=80
MEM_THRESH=80
DISK_THRESH=90
INTERVAL=60

# Load saved thresholds if exist
[ -f "$CONFIGFILE" ] && source "$CONFIGFILE"

# Simple timestamped logging
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"
}

# Get system stats
get_cpu() {
    top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}'
}

get_mem() {
    free -m | awk '/Mem/{total=$2; used=$3; print used/total*100}'
}

get_disk() {
    df -h ~ | awk 'NR==2 {print substr($5, 1, length($5)-1)}'
}

show_status() {
    clear
    echo "=== System Status ==="
    printf "CPU Usage : %.1f%%\n" $(get_cpu)
    printf "Memory    : %.1f%%\n" $(get_mem)
    printf "Disk (~)  : %s%%\n" $(get_disk)
    echo "Log file  : $LOGFILE"
    echo
}

set_thresholds() {
    read -p "CPU Threshold [$CPU_THRESH]: " input
    [[ -n "$input" ]] && CPU_THRESH=$input
    read -p "Memory Threshold [$MEM_THRESH]: " input
    [[ -n "$input" ]] && MEM_THRESH=$input
    read -p "Disk Threshold [$DISK_THRESH]: " input
    [[ -n "$input" ]] && DISK_THRESH=$input

    cat > "$CONFIGFILE" << EOF
CPU_THRESH=$CPU_THRESH
MEM_THRESH=$MEM_THRESH
DISK_THRESH=$DISK_THRESH
EOF
    log "Thresholds updated: CPU=$CPU_THRESH% MEM=$MEM_THRESH% DISK=$DISK_THRESH%"
}

monitor_loop() {
    while true; do
        CPU=$(get_cpu)
        MEM=$(get_mem)
        DISK=$(get_disk)

        (( $(echo "$CPU > $CPU_THRESH" | bc -l 2>/dev/null || echo 0) )) && log "ALERT: CPU High (${CPU}% > ${CPU_THRESH}%)"
        (( $(echo "$MEM > $MEM_THRESH" | bc -l 2>/dev/null || echo 0) )) && log "ALERT: Memory High (${MEM}% > ${MEM_THRESH}%)"
        (( DISK > DISK_THRESH )) && log "ALERT: Disk Full (${DISK}% > ${DISK_THRESH}%)"

        sleep $INTERVAL
    done
}

menu() {
    while true; do
        show_status
        echo "1. View Status"
        echo "2. Set Thresholds"
        echo "3. View Log"
        echo "4. Clear Log"
        echo "5. Start Monitoring (background)"
        echo "6. Exit"
        read -p "Choose: " choice
        case $choice in
            1) show_status; read -p "Press Enter to continue..." ;;
            2) set_thresholds ;;
            3) less "$LOGFILE" 2>/dev/null || echo "Log is empty" ;;
            4) : > "$LOGFILE"; log "Log cleared by user" ;;
            5) monitor_loop & echo "Monitoring started in background (PID: $!)" ;;
            6) echo "Goodbye!"; exit 0 ;;
            *) echo "Invalid option" ;;
        esac
    done
}

# Create log file if not exists
touch "$LOGFILE"
log "System monitor started by $USER"

menu
