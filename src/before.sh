## before hook
##
## Any code here will be placed inside a `before_hook()` function and called
## before running any command (but after processing its arguments).
##
## You can safely delete this file if you do not need it.
if [[ ${args[--debug]} == 1 ]]; then
    red "------DEBUG MODE ACTIVE------"

else
    echo '
    ________     _______     _______    ___           ______     ___  ___   ___      ___   _______   _____  ___    ___________  
    |"      "\   /"     "|   |   __ "\  |"  |         /    " \   |"  \/"  | |"  \    /"  | /"     "| (\"   \|"  \  ("     _   ") 
    (.  ___  :) (: ______)   (. |__) :) ||  |        // ____  \   \   \  /   \   \  //   |(: ______) |.\\   \    |  )__/  \\__/  
    |: \   ) ||  \/    |     |:  ____/  |:  |       /  /    ) :)   \\  \/    /\\  \/.    | \/    |   |: \.   \\  |     \\_ /     
    (| (___\ ||  // ___)_    (|  /       \  |___   (: (____/ //    /   /    |: \.        | // ___)_  |.  \    \. |     |.  |     
    |:       :) (:      "|  /|__/ \     ( \_|:  \   \        /    /   /     |.  \    /:  |(:      "| |    \    \ |     \:  |     
    (________/   \_______) (_______)     \_______)   \"_____/    |___/      |___|\__/|___| \_______)  \___|\____\)      \__|     
    '
fi

    local logname_user=$(logname)
    local whoami_user=$(whoami)

    if [[ "$logname_user" != "$whoami_user" ]]; then
        echo "You should run this script as $logname_user, not $whoami_user."
        red "You should not run this script as diffrent user."
        red ".....Exiting.....BYE"
        red "."
        red ".."
        red "..."
        exit
    elif [[ "$whoami_user" == "root" ]]; then
        red "You should not run this script as root."
        red ".....Exiting.....BYE"
        red "."
        red ".."
        red "..."
        exit
    else
        green "User check passed. You are running the script as $logname_user."
        # Uncomment the command you want to execute after user check
        # ssh_to_remote "hostname"
        # parallel_ssh_to_remote "hostname1" "hostname2"
    fi


# Log some messages with emojis and different log levels
log_me "INFO" "System startup initiated"
log_me "WARN" "Warning: High CPU usage detected"
log_me "ERROR" "Security alert: Unauthorized access attempted"