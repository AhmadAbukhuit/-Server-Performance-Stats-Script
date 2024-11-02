#! /bin/bash

# function to get server name
get_server_name(){
    echo "# Server Info : "
    uname -a | cut -d " " -f 1,2,3
}

# function to get server time
get_time(){
    echo "# Server Current Time : "
    uptime | cut -d "," -f 1
}

# funtion to get the number of current users 
get_users() {
    echo "# Number of current users : "
    uptime | cut -d "," -f 2
}

# function to get CPU Usage 
get_cpu_usage(){
    mpstat | grep "all" | cut -d '.' -f 10,11 | cut -d ' ' -f 4 | awk '{print "# CPU Usage: " 100-$1 "%"}'
}

# function to get Memory Usage
get_memory_usage(){
    echo "# Memory Usage : " 
    free | grep "Mem:" -w | awk '{printf "Total: %.1fGi\nUsed: %.1fGi (%.2f%%)\nFree: %.1fGi (%.2f%%)\n",$2/1024^2, $3/1024^2, $3/$2 * 100, $4/1024^2, $4/$2 * 100}'
}

# function to get Disk Usage
get_disk_usage(){
    echo "# Disk Usage : " 
    df -h | grep "/" -w | awk '{printf "Total: %sG\nUsed: %s (%.2f%%)\nFree: %s (%.2f%%)\n",$3 + $4, $3, $3/($3+$4) * 100, $4, $4/($3+$4) * 100}'
}

# function to get top 5 processes by memory usage 
get_memory_process(){
    echo "# Top 5 processes by memory usage : "
    ps aux --sort -%mem | head -n 6 | awk '{print $1 "\t" $2 "\t" $4 "\t" $11}'
}

# function to get top 5 processes by cpu usage
get_cpu_process(){
    echo "# Top 5 processes by CPU usage : "
    ps aux --sort -%cpu | head -n 6 | awk '{print $1 "\t" $2 "\t" $3 "\t" $11}'
}

get_server_name
echo ""
get_time
echo ""
get_users
echo ""
get_cpu_usage
echo "" 
get_memory_usage
echo ""
get_disk_usage
echo ""
get_memory_process
echo ""
get_cpu_process
