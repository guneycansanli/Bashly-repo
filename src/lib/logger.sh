log_me() {
    local level=$1
    local message=$2
    local tag="DEPLOYMENT"
    local priority
    local emoji

    case "$level" in
    INFO)
        priority="user.info"
        emoji="🟢" # Green emoji
        ;;
    WARN)
        priority="user.warn"
        emoji="🟡" # Yellow emoji
        ;;
    ERROR)
        priority="user.err"
        emoji="❌" # Error emoji
        ;;
    DEBUG)
        priority="user.debug"
        emoji="🔵" # Debug emoji
        ;;
    EMERG)
        priority="user.emerg"
        emoji="🔴" # Emergency emoji
        ;;
    ALERT)
        priority="user.alert"
        emoji="🚨" # Alert emoji
        ;;
    CRIT)
        priority="user.crit"
        emoji="🔥" # Critical emoji
        ;;
    NOTICE)
        priority="user.notice"
        emoji="💡" # Notice emoji
        ;;
    *)
        priority="user.info"
        emoji="🟢" # Default to green emoji for INFO
        ;;
    esac

    logger -t "$tag" -p "$priority" "$emoji $message"
}

# Log some messages with emojis and different log levels
log_me "INFO" "System startup initiated"
log_me "WARN" "Warning: High CPU usage detected"
log_me "ERROR" "Security alert: Unauthorized access attempted"
log_me "DEBUG" "Debugging information: This is a debug message"
log_me "EMERG" "Emergency: System is down!"
log_me "ALERT" "Alert: Disk space critically low"
log_me "CRIT" "Critical: Server crash detected"
log_me "NOTICE" "Notice: Configuration file updated"