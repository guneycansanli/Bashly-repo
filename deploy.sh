#!/usr/bin/env bash
# This script was generated by bashly 1.1.8 (https://bashly.dannyb.co)
# Modifying it manually is not recommended

# :wrapper.bash3_bouncer
if [[ "${BASH_VERSINFO:-0}" -lt 4 ]]; then
  printf "bash version 4 or higher is required\n" >&2
  exit 1
fi

# :command.master_script

# :command.version_command
version_command() {
  echo "$version"
}

# :command.usage
deploy.sh_usage() {
  if [[ -n $long_usage ]]; then
    printf "deploy.sh - Sample application\n"
    echo

  else
    printf "deploy.sh - Sample application\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  deploy.sh COMMAND\n"
  printf "  deploy.sh [COMMAND] --help | -h\n"
  printf "  deploy.sh --version | -v\n"
  echo
  # :command.usage_commands
  printf "%s\n" "Commands:"
  printf "  %s   Read file from remote hosts\n" "read"
  echo

  # :command.long_usage
  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    # :command.usage_fixed_flags
    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo
    printf "  %s\n" "--version, -v"
    printf "    Show version number\n"
    echo

  fi
}

# :command.usage
deploy.sh_read_usage() {
  if [[ -n $long_usage ]]; then
    printf "deploy.sh read - Read file from remote hosts\n"
    echo

  else
    printf "deploy.sh read - Read file from remote hosts\n"
    echo

  fi

  printf "Alias: r\n"
  echo

  printf "%s\n" "Usage:"
  printf "  deploy.sh read HOST TARGET [OPTIONS]\n"
  printf "  deploy.sh read --help | -h\n"
  echo

  # :command.long_usage
  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    # :command.usage_flags
    # :flag.usage
    printf "  %s\n" "--force, -f"
    printf "    Read with sudo\n"
    echo

    # :flag.usage
    printf "  %s\n" "--debug, -d"
    printf "    Debug Mode\n"
    echo

    # :command.usage_fixed_flags
    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    # :command.usage_args
    printf "%s\n" "Arguments:"

    # :argument.usage
    printf "  %s\n" "HOST"
    printf "    Target host\n"
    echo

    # :argument.usage
    printf "  %s\n" "TARGET"
    printf "    Target file absolute path\n"
    echo

    # :command.usage_environment_variables
    printf "%s\n" "Environment Variables:"

    # :environment_variable.usage
    printf "  %s\n" "DEFAULT_TARGET_LOCATION"
    printf "    Set the default location to download to\n"
    echo

    # :command.usage_examples
    printf "%s\n" "Examples:"
    printf "  deploy.sh target /etc/cron.daily/apt-compat\n"
    printf "  deploy.sh target --force /etc/cron.daily/apt-compat\n"
    printf "  deploy.sh target --debug --force /etc/cron.daily/apt-compat\n"
    echo

  fi
}

# :command.normalize_input
normalize_input() {
  local arg flags

  while [[ $# -gt 0 ]]; do
    arg="$1"
    if [[ $arg =~ ^(--[a-zA-Z0-9_\-]+)=(.+)$ ]]; then
      input+=("${BASH_REMATCH[1]}")
      input+=("${BASH_REMATCH[2]}")
    elif [[ $arg =~ ^(-[a-zA-Z0-9])=(.+)$ ]]; then
      input+=("${BASH_REMATCH[1]}")
      input+=("${BASH_REMATCH[2]}")
    elif [[ $arg =~ ^-([a-zA-Z0-9][a-zA-Z0-9]+)$ ]]; then
      flags="${BASH_REMATCH[1]}"
      for ((i = 0; i < ${#flags}; i++)); do
        input+=("-${flags:i:1}")
      done
    else
      input+=("$arg")
    fi

    shift
  done
}

# :command.inspect_args
inspect_args() {
  if ((${#args[@]})); then
    readarray -t sorted_keys < <(printf '%s\n' "${!args[@]}" | sort)
    echo args:
    for k in "${sorted_keys[@]}"; do
      echo "- \${args[$k]} = ${args[$k]}"
    done
  else
    echo args: none
  fi

  if ((${#other_args[@]})); then
    echo
    echo other_args:
    echo "- \${other_args[*]} = ${other_args[*]}"
    for i in "${!other_args[@]}"; do
      echo "- \${other_args[$i]} = ${other_args[$i]}"
    done
  fi

  if ((${#deps[@]})); then
    readarray -t sorted_keys < <(printf '%s\n' "${!deps[@]}" | sort)
    echo
    echo deps:
    for k in "${sorted_keys[@]}"; do
      echo "- \${deps[$k]} = ${deps[$k]}"
    done
  fi

  if ((${#env_var_names[@]})); then
    readarray -t sorted_names < <(printf '%s\n' "${env_var_names[@]}" | sort)
    echo
    echo "environment variables:"
    for k in "${sorted_names[@]}"; do
      echo "- \$$k = ${!k:-}"
    done
  fi
}

# :command.user_lib
# src/lib/colors.sh
print_in_color() {
  local color="$1"
  shift
  if [[ -z ${NO_COLOR+x} ]]; then
    printf "$color%b\e[0m\n" "$*"
  else
    printf "%b\n" "$*"
  fi
}

red() { print_in_color "\e[31m" "$*"; }
green() { print_in_color "\e[32m" "$*"; }
yellow() { print_in_color "\e[33m" "$*"; }
blue() { print_in_color "\e[34m" "$*"; }
magenta() { print_in_color "\e[35m" "$*"; }
cyan() { print_in_color "\e[36m" "$*"; }
bold() { print_in_color "\e[1m" "$*"; }
underlined() { print_in_color "\e[4m" "$*"; }
red_bold() { print_in_color "\e[1;31m" "$*"; }
green_bold() { print_in_color "\e[1;32m" "$*"; }
yellow_bold() { print_in_color "\e[1;33m" "$*"; }
blue_bold() { print_in_color "\e[1;34m" "$*"; }
magenta_bold() { print_in_color "\e[1;35m" "$*"; }
cyan_bold() { print_in_color "\e[1;36m" "$*"; }
red_underlined() { print_in_color "\e[4;31m" "$*"; }
green_underlined() { print_in_color "\e[4;32m" "$*"; }
yellow_underlined() { print_in_color "\e[4;33m" "$*"; }
blue_underlined() { print_in_color "\e[4;34m" "$*"; }
magenta_underlined() { print_in_color "\e[4;35m" "$*"; }
cyan_underlined() { print_in_color "\e[4;36m" "$*"; }

# src/lib/logger.sh
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

# src/lib/ssh-functions.sh
ssh_to_remote() {
    local host="$1"

    # Add SSH options for security and reliability
    local ssh_options="-o StrictHostKeyChecking=no -o ConnectTimeout=10 -o BatchMode=yes -i"

    # Add -A flag for agent forwarding
    ssh $ssh_options -A $host
}

# Function to perform parallel SSH connections to multiple remote hosts
parallel_ssh_to_remote() {
    local hosts=("$@")

    # Add SSH options for security and reliability
    local ssh_options="-o StrictHostKeyChecking=no -o ConnectTimeout=10 -o BatchMode=yes -t 100"

    # Add -A flag for agent forwarding
    parallel-ssh $ssh_options -A -h <(printf "%s\n" "${hosts[@]}")
}

# Example usage:
# ssh_to_remote "hostname"
# parallel_ssh_to_remote "hostname1" "hostname2"

# src/lib/validations/validate_dir_exists.sh
validate_dir_exists() {
  [[ -d "$1" ]] || echo "must be an existing directory"
}

# src/lib/validations/validate_file_exists.sh
validate_file_exists() {
  [[ -f "$1" ]] || echo "must be an existing file"
}

# src/lib/validations/validate_integer.sh
validate_integer() {
  [[ "$1" =~ ^[0-9]+$ ]] || echo "must be an integer"
}

# src/lib/validations/validate_not_empty.sh
validate_not_empty() {
  [[ -z "$1" ]] && echo "must not be empty"
}

# :command.command_functions
# :command.function
deploy.sh_read_command() {
  # src/read_command.sh
  echo "# this file is located in 'src/read_command.sh'"
  echo "# code for 'deploy.sh read' goes here"
  echo "# you can edit it freely and regenerate (it will not be overwritten)"
  inspect_args

}

# :command.parse_requirements
parse_requirements() {
  # :command.fixed_flags_filter
  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --version | -v)
        version_command
        exit
        ;;

      --help | -h)
        long_usage=yes
        deploy.sh_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  # :command.command_filter
  action=${1:-}

  case $action in
    -*) ;;

    read | r)
      action="read"
      shift
      deploy.sh_read_parse_requirements "$@"
      shift $#
      ;;

    # :command.command_fallback
    "")
      deploy.sh_usage >&2
      exit 1
      ;;

    *)
      printf "invalid command: %s\n" "$action" >&2
      exit 1
      ;;

  esac

  # :command.parse_requirements_while
  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)
        # :command.parse_requirements_case
        # :command.parse_requirements_case_simple
        printf "invalid argument: %s\n" "$key" >&2
        exit 1

        ;;

    esac
  done

}

# :command.parse_requirements
deploy.sh_read_parse_requirements() {
  # :command.fixed_flags_filter
  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        deploy.sh_read_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  # :command.environment_variables_filter

  env_var_names+=("DEFAULT_TARGET_LOCATION")

  # :command.command_filter
  action="read"

  # :command.parse_requirements_while
  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in
      # :flag.case
      --force | -f)

        # :flag.case_no_arg
        args['--force']=1
        shift
        ;;

      # :flag.case
      --debug | -d)

        # :flag.case_no_arg
        args['--debug']=1
        shift
        ;;

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)
        # :command.parse_requirements_case
        # :command.parse_requirements_case_simple
        if [[ -z ${args['host']+x} ]]; then
          args['host']=$1
          shift
        elif [[ -z ${args['target']+x} ]]; then
          args['target']=$1
          shift
        else
          printf "invalid argument: %s\n" "$key" >&2
          exit 1
        fi

        ;;

    esac
  done

  # :command.required_args_filter
  if [[ -z ${args['host']+x} ]]; then
    printf "missing required argument: HOST\nusage: deploy.sh read HOST TARGET [OPTIONS]\n" >&2
    exit 1
  fi
  if [[ -z ${args['target']+x} ]]; then
    printf "missing required argument: TARGET\nusage: deploy.sh read HOST TARGET [OPTIONS]\n" >&2
    exit 1
  fi

}

# :command.user_hooks
before_hook() {
  # src/before.sh
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
}

after_hook() {
  # src/after.sh
  green "==[ DEPLOYMENT DONE ]=="
}

# :command.initialize
initialize() {
  version="0.1.0"
  long_usage=''
  set -e

  # src/initialize.sh

}

# :command.run
run() {
  declare -A args=()
  declare -A deps=()
  declare -a other_args=()
  declare -a env_var_names=()
  declare -a input=()
  normalize_input "$@"
  parse_requirements "${input[@]}"
  before_hook

  case "$action" in
    "read") deploy.sh_read_command ;;
  esac

  after_hook
}

initialize
run "$@"
