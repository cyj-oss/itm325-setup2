# Part 2 | Mac

[Back to start](README.md)

## 1. Run the setup helper

Press **Command+Space**, type **Terminal**, and press Return.

Copy this entire command, paste it into Terminal, and press **Return**.

```bash
course_setup="$(/usr/bin/mktemp /tmp/itm325-project.XXXXXX)" && /usr/bin/curl --fail --show-error --location --proto '=https' https://raw.githubusercontent.com/cyj-oss/itm325-setup2/main/prepare-mac.sh --output "$course_setup" && /bin/bash "$course_setup"
```

Type **Y** to continue. The helper checks Git, Node.js, and npm. It keeps supported working installations and prepares missing tools.

| Message | What to do |
| --- | --- |
| **FINISH THE APPLE INSTALLER** | Complete the Command Line Tools window. It includes Git. Then run the same helper again. |
| **FINISH THE NODE INSTALLER** | Complete the official Node installer. Enter your Mac password there if requested. Then run the same helper again. |
| **PROJECT TOOLS READY** | Continue to Step 2 below. |
| **SETUP NEEDS ATTENTION** | Open [Setup Help](HELP.md) before continuing. |

You may need to run the helper again after each installer. Completed tools are kept. Homebrew and the full Xcode app are not required.

New Node installations use **Node.js 24 LTS**, which requires macOS **13.5 or later**. Existing supported LTS versions are kept. An old or broken installation is left in place with a link to help.

## 2. Check in VS Code

Save your work, quit VS Code with **Command+Q**, and reopen it. Close any restored terminal with its trash can button. Open **Terminal > New Terminal** and use **Zsh** or your usual **Bash** shell.

Run these commands in the regular terminal, outside Claude's message area.

```bash
git --version
node --version
npm --version
```

**Done:** All three print version numbers. If a command is not found, use [command help](HELP.md#a-command-is-not-recognized) before reinstalling.

**Next: [GitHub account and connection](GITHUB.md)**
