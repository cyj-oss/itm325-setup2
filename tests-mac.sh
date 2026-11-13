#!/bin/bash
set -u
cd "$(dirname "$0")" || exit 1
. ./prepare-mac.sh
passed=0
assert_status() {
    local expected="$1" actual="$2" label="$3"
    if [ "$expected" -ne "$actual" ]; then printf 'FAIL: %s (status %s)\n' "$label" "$actual"; exit 1; fi
    passed=$((passed + 1)); printf 'PASS: %s\n' "$label"
}
node_supported v24.1.0 2026-11-04; assert_status 0 $? 'retain Node 24 LTS'
node_supported v20.1.0 2026-11-04; assert_status 1 $? 'reject EOL Node'
node_supported v22.1.0 2027-04-30; assert_status 1 $? 'enforce LTS expiry'
node_supported v26.1.0 2026-10-01; assert_status 1 $? 'reject pre-LTS Node'
node_supported v24.1.0-beta 2026-11-04; assert_status 1 $? 'reject prerelease Node'

# Exercise control flow without running installers or changing user settings.
scratch=$(mktemp -d) || exit 1
reset_scenario() {
    missing_node=0; missing_npm=0; missing_git=0; broken_node=0; fixture_version=v24.1.0
    : > "$scratch/installs"
}
uname() { printf 'Darwin\n'; }
id() { printf '501\n'; }
confirm_setup() { return 0; }
find_tool() {
    case "$1" in
        node) [ "$missing_node" -eq 0 ] || return 1 ;;
        npm) [ "$missing_npm" -eq 0 ] || return 1 ;;
        git) [ "$missing_git" -eq 0 ] || return 1 ;;
    esac
    printf '/mock/%s\n' "$1"
}
read_version() {
    case "$1" in
        /mock/git) printf 'git version 2.50.0\n' ;;
        /mock/node) [ "$broken_node" -eq 0 ] || return 1; printf '%s\n' "$fixture_version" ;;
        /mock/npm) printf '11.1.0\n' ;;
    esac
}
list_extensions() { printf 'Unexpected extension inspection\n' >&2; return 1; }
install_extension() { printf 'Unexpected extension install\n' >&2; return 1; }
open_node_installer() { printf 'node\n' >> "$scratch/installs"; return 2; }

reset_scenario
project_setup; assert_status 0 $? 'existing tools succeed'
[ ! -s "$scratch/installs" ]; assert_status 0 $? 'existing tools are not reinstalled'
missing_node=1; missing_npm=1
project_setup --check; assert_status 1 $? 'check-only stops on missing Node'
[ ! -s "$scratch/installs" ]; assert_status 0 $? 'check-only never installs Node'
project_setup; assert_status 2 $? 'Node installer remains pending, not ready'
reset_scenario; broken_node=1
project_setup; assert_status 1 $? 'broken Node stops setup'
[ ! -s "$scratch/installs" ]; assert_status 0 $? 'broken Node is not overwritten'
reset_scenario; fixture_version=v20.1.0
project_setup; assert_status 1 $? 'unsupported Node stops setup'
[ ! -s "$scratch/installs" ]; assert_status 0 $? 'unsupported Node is not overwritten'
reset_scenario
project_setup --check; assert_status 0 $? 'check-only succeeds without accessing extensions'
project_setup; assert_status 0 $? 'rerun succeeds without accessing extensions'
[ ! -s "$scratch/installs" ]; assert_status 0 $? 'rerun does not install anything'
printf '%s Mac behavior checks passed.\n' "$passed"
