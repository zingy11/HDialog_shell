
#!/usr/bin/env bash

# ==================================================
# Directory Browser — Read Only
# Platforms: Linux, macOS, Git Bash, WSL
# ==================================================

set -u

show_dirs() {
    local target="${1:-.}"
    local entry
    local -a dirs=()

    if [[ ! -d "$target" || ! -r "$target" ]]; then
        printf 'Cannot read directory: %s\n' "$target"
        return 1
    fi

    printf '\nDirectory: %s\n\n' "$target"

    # Collect immediate subdirectories.
    for entry in "$target"/* "$target"/.[!.]* "$target"/..?*; do
        [[ -d "$entry" ]] || continue
        dirs+=("$entry")
    done

    if ((${#dirs[@]} == 0)); then
        printf 'No subdirectories found.\n'
        return 0
    fi

    local i
    for i in "${!dirs[@]}"; do
        printf '%3d) %s\n' "$((i + 1))" "${dirs[$i]}"
    done

    printf '\nTotal: %d subdirectories\n' "${#dirs[@]}"
}

main() {
    local target="."
    local choice

    while true; do
        printf '\n================================\n'
        printf ' Read-only Directory Browser\n'
        printf '================================\n'
        show_dirs "$target"
        printf '\n'
        printf '1) Inspect a subdirectory\n'
        printf '2) List another path\n'
        printf '3) Go to parent directory\n'
        printf '4) Exit\n'
        printf 'Choice: '

        IFS= read -r choice || break

        case "$choice" in
            1)
                printf 'Directory number: '
                IFS= read -r choice || break

                if [[ "$choice" =~ ^[0-9]+$ ]]; then
                    local selected=""
                    local entry
                    local -a dirs=()

                    for entry in "$target"/* \
                                 "$target"/.[!.]* \
                                 "$target"/..?*; do
                        [[ -d "$entry" ]] || continue
                        dirs+=("$entry")
                    done

                    if ((choice >= 1 && choice <= ${#dirs[@]})); then
                        target="${dirs[$((choice - 1))]}"
                    else
                        printf 'Invalid directory number.\n'
                    fi
                else
                    printf 'Please enter a number.\n'
                fi
                ;;
            2)
                printf 'Path: '
                IFS= read -r target || break
                [[ -n "$target" ]] || target="."
                ;;
            3)
                target="${target%/}"
                [[ -n "$target" ]] || target="/"
                target="$(dirname "$target")"
                ;;
            4)
                printf 'Goodbye.\n'
                break
                ;;
            *)
                printf 'Invalid choice.\n'
                ;;
        esac
    done
}

main
