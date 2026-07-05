#!/bin/bash

# Configuration
PACKAGE_NAME="termux-dm"
SHOW_LOG=false

# Check for --log argument
if [ "$1" == "--log" ]; then
    SHOW_LOG=true
fi

# Function to display the loading animation
loading_bar() {
    local pid=$1
    local term_width=30
    local progress=0
    local filler="█"
    local empty=" "

    printf "Uninstalling %s... " "$PACKAGE_NAME"
    
    # Loop while the background process is running
    while kill -0 "$pid" 2>/dev/null; do
        local filled_str=$(printf "%0.s$filler" $(seq 1 $progress))
        local empty_str=$(printf "%0.s$empty" $(seq 1 $((term_width - progress))))
        
        printf "\r[%s%s] Processing..." "$filled_str" "$empty_str"
        
        sleep 0.2
        ((progress++))
        
        # Reset animation loop if it takes too long
        if [ $progress -gt $term_width ]; then
            progress=0
        fi
    done
    
    # Clear the loading line
    printf "\r%${term_width}s\r" ""
}

# Execute uninstallation
if [ "$SHOW_LOG" = true ]; then
    echo "Starting uninstallation with full logs..."
    pkg uninstall -y "$PACKAGE_NAME"
    EXIT_CODE=$?
else
    # Run in background and save output to a temporary log
    LOG_FILE=$(mktemp)
    pkg uninstall -y "$PACKAGE_NAME" > "$LOG_FILE" 2>&1 &
    SUB_PID=$!

    # Start visual loading animation
    loading_bar "$SUB_PID"

    # Wait for the process to collect the exit status
    wait "$SUB_PID"
    EXIT_CODE=$?
fi

# Check final result
if [ $EXIT_CODE -eq 0 ]; then
    echo "Success: $PACKAGE_NAME has been uninstalled successfully!"
    [ -f "$LOG_FILE" ] && rm "$LOG_FILE"
else
    echo "Error: Uninstallation failed!"
    if [ "$SHOW_LOG" = false ] && [ -f "$LOG_FILE" ]; then
        echo "------------------ ERROR LOG ------------------"
        cat "$LOG_FILE"
        echo "-----------------------------------------------"
        rm "$LOG_FILE"
    fi
    exit 1
fi
