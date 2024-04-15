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