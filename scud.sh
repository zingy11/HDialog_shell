
#!/usr/bin/env bash

# ============================================================
# Script:      menu.sh
# Description: Interactive terminal menu with directory browser
# Compatible:  Linux, macOS, Git Bash, WSL
# ============================================================

set -u

# -------------------------
# Configuration
# -------------------------

APP_NAME="My Terminal Menu"
START_DIR="${PWD}"

# -------------------------
# Utility functions
# -------------------------

pause() {
    printf '\nPress Enter to continue...'
    IFS= read -r _
}

clear_screen() {
    clear 2>/dev/null || printf '\n'
}

print_header() {
    clear_screen
    printf '%s\n' "========================================"
    printf '  %s\n' "$APP_NAME"
    printf '%s\n' "========================================"
    printf 'Current directory: %s\n\n' "$PWD"
}

# -------------------------
# Directory browser
# -------------------------

list_subdirectories() {
    local choice
    local -a directories=()
    local dir

    while true; do
        print_header
        printf '%s\n' "--- Subdirectories ---"

        directories=()

        # Find immediate subdirectories, including hidden ones.
        for dir in "$PWD"/*/ "$PWD"/.[!.]*/ "$PWD"/..?*/; do
            [[ -d "$dir" ]] || continue
            directories+=("${dir%/}")
        done

        if ((${#directories[@]} == 0)); then
            printf 'No subdirectories found.\n\n'
        else
            for i in "${!directories[@]}"; do
                printf '  %d) %s\n' "$((i + 1))" \
                    "$(basename "${directories[$i]}")"
            done
            printf '\n'
        fi

        printf '%s\n' "  u) Go up one directory"
        printf '%s\n' "  h) Go to home directory"
        printf '%s\n' "  b) Back to main menu"
        printf '\nChoice: '

        IFS= read -r choice || return

        case "$choice" in
            u)
                cd .. || pause
                ;;
            h)
                cd "$HOME" || pause
                ;;
            b)
                return
                ;;
            *)
                if [[ "$choice" =~ ^[0-9]+$ ]] &&
                   ((choice >= 1 && choice <= ${#directories[@]})); then
                    cd "${directories[$((choice - 1))]}" || pause
                else
                    printf '\nInvalid choice.\n'
                    pause
                fi
                ;;
        esac
    done
}

# -------------------------
# Main menu
# -------------------------

main_menu() {
    local choice

    while true; do
        print_header

        printf '%s\n' "  1) List subdirectories"
        printf '%s\n' "  2) Show current directory"
        printf '%s\n' "  3) Change to starting directory"
        printf '%s\n' "  4) Exit"
        printf '\nChoice: '

        IFS= read -r choice || break

        case "$choice" in
            1)
                list_subdirectories
                ;;
            2)
                print_header
                printf 'Current directory:\n%s\n' "$PWD"
                pause
                ;;
            3)
                cd "$START_DIR" || {
                    printf 'Could not access starting directory.\n'
                    pause
                }
                ;;
            4)
                printf '\nGoodbye!\n'
                break
                ;;
            *)
                printf '\nInvalid choice. Enter 1-4.\n'
                pause
                ;;
        esac
    done
}

# -------------------------
# Entry point
# -------------------------

main_menu

#!/usr/bin/env bash

# ============================================================
# Script:      menu.sh
# Description: Interactive terminal menu with directory browser
# Compatible:  Linux, macOS, Git Bash, WSL
# ============================================================

set -u

# -------------------------
# Configuration
# -------------------------

APP_NAME="My Terminal Menu"
START_DIR="${PWD}"

# -------------------------
# Utility functions
# -------------------------

pause() {
    printf '\nPress Enter to continue...'
    IFS= read -r _
}

clear_screen() {
    clear 2>/dev/null || printf '\n'
}

print_header() {
    clear_screen
    printf '%s\n' "========================================"
    printf '  %s\n' "$APP_NAME"
    printf '%s\n' "========================================"
    printf 'Current directory: %s\n\n' "$PWD"
}

# -------------------------
# Directory browser
# -------------------------

list_subdirectories() {
    local choice
    local -a directories=()
    local dir

    while true; do
        print_header
        printf '%s\n' "--- Subdirectories ---"

        directories=()

        # Find immediate subdirectories, including hidden ones.
        for dir in "$PWD"/*/ "$PWD"/.[!.]*/ "$PWD"/..?*/; do
            [[ -d "$dir" ]] || continue
            directories+=("${dir%/}")
        done

        if ((${#directories[@]} == 0)); then
            printf 'No subdirectories found.\n\n'
        else
            for i in "${!directories[@]}"; do
                printf '  %d) %s\n' "$((i + 1))" \
                    "$(basename "${directories[$i]}")"
            done
            printf '\n'
        fi

        printf '%s\n' "  u) Go up one directory"
        printf '%s\n' "  h) Go to home directory"
        printf '%s\n' "  b) Back to main menu"
        printf '\nChoice: '

        IFS= read -r choice || return

        case "$choice" in
            u)
                cd .. || pause
                ;;
            h)
                cd "$HOME" || pause
                ;;
            b)
                return
                ;;
            *)
                if [[ "$choice" =~ ^[0-9]+$ ]] &&
                   ((choice >= 1 && choice <= ${#directories[@]})); then
                    cd "${directories[$((choice - 1))]}" || pause
                else
                    printf '\nInvalid choice.\n'
                    pause
                fi
                ;;
        esac
    done
}

# -------------------------
# Main menu
# -------------------------

main_menu() {
    local choice

    while true; do
        print_header

        printf '%s\n' "  1) List subdirectories"
        printf '%s\n' "  2) Show current directory"
        printf '%s\n' "  3) Change to starting directory"
        printf '%s\n' "  4) Exit"
        printf '\nChoice: '

        IFS= read -r choice || break

        case "$choice" in
            1)
                list_subdirectories
                ;;
            2)
                print_header
                printf 'Current directory:\n%s\n' "$PWD"
                pause
                ;;
            3)
                cd "$START_DIR" || {
                    printf 'Could not access starting directory.\n'
                    pause
                }
                ;;
            4)
                printf '\nGoodbye!\n'
                break
                ;;
            *)
                printf '\nInvalid choice. Enter 1-4.\n'
                pause
                ;;
        esac
    done
}

# -------------------------
# Entry point
# -------------------------

main_menu
