# Put these in your .zshrc

# Find these by running 'lsappinfo info $(lsappinfo front)'
TERMINAL="iTerm2"
TERMINAL_BUNDLE_ID="com.googlecode.iterm2"

# Notify of long running commands
function f_notifyme {
    LAST_EXIT_CODE=$?
    LAST_CMD=$(fc -ln -1)

    FRONT=$(lsappinfo info -only name $(lsappinfo front) | cut -d= -f2)
    [[ LAST_EXIT_CODE -eq 0 ]] && TITLE="Command finished" || TITLE="Command failed"

    if [[ $FRONT != \"$TERMINAL\" ]]; then
        terminal-notifier \
            -title "$TITLE" \
            -subtitle "'$LAST_CMD'" \
            -message "exited with status $LAST_EXIT_CODE" \
            -activate "$TERMINAL_BUNDLE_ID" \
            -sender "$TERMINAL_BUNDLE_ID" \
            -group "$TERMINAL_BUNDLE_ID" > /dev/null 2>&1
    fi
}

precmd() {
    f_notifyme &!
}
