#!/bin/bash
# Compatible with the Bash 3.2 included with macOS. Installs no package manager.

node_supported() {
    local version="$1" today="${2:-$(date +%Y-%m-%d)}" start end major
    [[ "$version" =~ ^v([0-9]+)\.[0-9]+\.[0-9]+$ ]] || return 1
    major="${BASH_REMATCH[1]}"
    case "$major" in
        22) start=2024-10-29; end=2027-04-30 ;;
        24) start=2025-10-28; end=2028-04-30 ;;
        26) start=2026-10-28; end=2029-04-30 ;;
        *) return 1 ;;
    esac
    [[ "$today" < "$start" || "$today" > "$end" || "$today" == "$end" ]] && return 1
    return 0
}

find_tool() {
    local name="$1" found
    found=$(command -v "$name" 2>/dev/null) || found=''
    if [ -n "$found" ] && [ -f "$found" ] && [ -x "$found" ]; then printf '%s\n' "$found"; return 0; fi
    case "$name" in
        node|npm)
            for found in "/usr/local/bin/$name" "/opt/homebrew/bin/$name"; do
                if [ -x "$found" ]; then printf '%s\n' "$found"; return 0; fi
            done ;;
        code)
            for found in '/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code' "$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"; do
                if [ -x "$found" ]; then printf '%s\n' "$found"; return 0; fi
            done ;;
    esac
    return 1
}

node_manager_exists() {
    local folder
    for folder in "${NVM_DIR:-$HOME/.nvm}" "${VOLTA_HOME:-$HOME/.volta}" "${FNM_DIR:-$HOME/.local/share/fnm}" "$HOME/Library/Application Support/fnm" /opt/homebrew/opt/node* /usr/local/opt/node*; do
        [ ! -d "$folder" ] || return 0
    done
    command -v fnm >/dev/null 2>&1 || command -v volta >/dev/null 2>&1 || command -v nvm >/dev/null 2>&1
}

read_version() {
    local value
    value=$("$1" --version 2>/dev/null) || return 1
    printf '%s\n' "$value"
}

open_node_installer() {
    local scratch base line expected filename actual os major minor
    node_supported v24.0.0 || { printf 'The course installer needs a newer LTS configuration. Use Setup Help.\n'; return 1; }
    if node_manager_exists; then printf 'A Node manager or Homebrew Node installation was found. Activate it using Setup Help; no second installation was added.\n'; return 1; fi
    os=$(/usr/bin/sw_vers -productVersion) || return 1
    major=${os%%.*}; minor=${os#*.}; minor=${minor%%.*}
    if [ "$major" -lt 13 ] || { [ "$major" -eq 13 ] && [ "$minor" -lt 5 ]; }; then
        printf 'Node.js 24 needs macOS 13.5 or later. Use Setup Help before changing your Mac.\n'; return 1
    fi
    scratch=$(/usr/bin/mktemp -d /tmp/itm325-node.XXXXXX) || return 1
    base='https://nodejs.org/dist/latest-v24.x/'
    printf 'Downloading the official Node.js 24 LTS installer. This may take a few minutes.\n'
    /usr/bin/curl --fail --silent --show-error --location --proto '=https' --tlsv1.2 --max-time 60 "${base}SHASUMS256.txt" -o "$scratch/SHASUMS256.txt" || return 1
    line=$(/usr/bin/awk '$2 ~ /^node-v24\.[0-9]+\.[0-9]+\.pkg$/ {print $1 " " $2}' "$scratch/SHASUMS256.txt")
    expected=${line%% *}; filename=${line#* }
    [[ "$expected" =~ ^[a-f0-9]{64}$ && "$filename" =~ ^node-v24\.[0-9]+\.[0-9]+\.pkg$ ]] || { printf 'The official installer could not be identified.\n'; return 1; }
    /usr/bin/curl --fail --silent --show-error --location --proto '=https' --tlsv1.2 --max-time 300 "${base}${filename}" -o "$scratch/$filename" || return 1
    actual=$(/usr/bin/shasum -a 256 "$scratch/$filename") || return 1
    [ "${actual%% *}" = "$expected" ] || { printf 'The download did not pass its checksum. Nothing was installed.\n'; return 1; }
    /usr/sbin/pkgutil --check-signature "$scratch/$filename" > "$scratch/signature.txt" 2>&1 || { printf 'The installer signature could not be verified. Nothing was installed.\n'; return 1; }
    /usr/bin/open "$scratch/$filename" || return 1
    printf 'FINISH THE NODE INSTALLER\nFollow the installer window. Enter your Mac password there if requested.\n'
    printf 'When it finishes, quit VS Code with Command Q, reopen it, and run the same helper again.\n'
    return 2
}

confirm_setup() {
    local answer
    printf 'Type Y to continue, or press Return to stop: '
    read -r answer < /dev/tty || return 1
    case "$answer" in y|Y|yes|YES|Yes) return 0 ;; *) return 1 ;; esac
}
project_setup() {
    local check_only=0 code git node npm version npm_version
    case "${1:-}" in --check) check_only=1 ;; '') ;; *) printf 'Usage: bash prepare-mac.sh [--check]\n'; return 1 ;; esac
    [ "$(uname -s)" = Darwin ] || { printf 'Use this helper on a Mac.\n'; return 1; }
    [ "$(id -u)" -ne 0 ] || { printf 'Run this helper without sudo.\n'; return 1; }
    code=$(find_tool code) || { printf 'VS Code was not found. Complete the first setup or use Setup Help.\n'; return 1; }
    printf 'ITM 325 | Project tools\n'
    if [ "$check_only" -eq 0 ]; then
        printf 'Keep working tools. Install only missing Git and Node.js, including npm.\n'
        confirm_setup || { printf 'Stopped. No installation changes were made.\n'; return 3; }
    fi
    git=$(find_tool git) || git=''
    # macOS supplies a Git stub before developer tools exist. Avoid triggering it in check mode.
    if [ "$git" = /usr/bin/git ] && ! /usr/bin/xcode-select -p >/dev/null 2>&1; then git=''; fi
    if [ -z "$git" ]; then
        [ "$check_only" -eq 0 ] || { printf 'Git is missing.\n'; return 1; }
        /usr/bin/xcode-select --install >/dev/null 2>&1 || { printf 'Apple could not open the Command Line Tools installer. Use Setup Help.\n'; return 1; }
        printf 'FINISH THE APPLE INSTALLER\nComplete the Command Line Tools window. It includes Git.\n'
        printf 'When it finishes, reopen VS Code and run the same helper again.\n'
        return 2
    fi
    version=$(read_version "$git") || { printf 'Existing Git did not start. Use Setup Help before reinstalling.\n'; return 1; }
    case "$version" in 'git version '*) printf 'KEEP: %s\n' "$version" ;; *) printf 'Unexpected Git result. Use Setup Help.\n'; return 1 ;; esac
    node=$(find_tool node) || node=''
    if [ -z "$node" ]; then
        if find_tool npm >/dev/null; then printf 'npm exists but Node was not found. Use Setup Help before installing again.\n'; return 1; fi
        [ "$check_only" -eq 0 ] || { printf 'Node.js is missing.\n'; return 1; }
        open_node_installer
        return $?
    fi
    version=$(read_version "$node") || { printf 'Existing Node did not start. Use Setup Help.\n'; return 1; }
    node_supported "$version" || { printf 'Node %s is outside this helper\047s supported LTS versions. Keep it and use Node.js help to select LTS.\n' "$version"; return 1; }
    # Changes affect only this helper process. Existing shell settings stay unchanged.
    export PATH="$(dirname "$node"):$PATH"
    npm=$(find_tool npm) || { printf 'Node exists but npm is missing. Use Setup Help.\n'; return 1; }
    npm_version=$(read_version "$npm") || { printf 'npm did not start. Use Setup Help.\n'; return 1; }
    [[ "$npm_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+ ]] || { printf 'Unexpected npm result. Use Setup Help.\n'; return 1; }
    printf 'KEEP: Node %s and npm %s\n' "$version" "$npm_version"
    printf 'PROJECT TOOLS READY\nQuit VS Code with Command Q, reopen it, and use a new terminal for the guide\047s final checks.\n'
    return 0
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
    project_setup "$@"
    setup_status=$?
    if [ "$setup_status" -eq 1 ]; then
        printf 'SETUP NEEDS ATTENTION\nHelp: https://github.com/cyj-oss/itm325-setup2/blob/main/HELP.md\n'
    fi
    exit "$setup_status"
fi
