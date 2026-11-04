# Part 2 | Windows

[Back to start](README.md)

## 1. Run the setup helper

Open **Windows PowerShell** from Start. Use the entry without **x86** and open it normally.

Copy this entire command, paste it into PowerShell, and press **Enter**.

```powershell
& ([scriptblock]::Create((Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/cyj-oss/itm325-setup2/main/prepare-windows.ps1')))
```

Type **Y** to continue. The helper checks Git, Node.js, npm, ESLint, and Prettier. It keeps supported working installations and installs missing tools.

If the Node installer opens, complete it. Keep **npm** and **Add to PATH** selected. Leave **Tools for Native Modules** unchecked if offered. Review any Windows permission prompt.

New Node installations use **Node.js 24 LTS**. Existing supported LTS versions are kept. An old or broken installation is left in place with a link to help.

Wait for **PROJECT TOOLS READY**. If you see **SETUP NEEDS ATTENTION**, use [Setup Help](HELP.md) before continuing.

## 2. Check in VS Code

Save your work and close **all VS Code windows**. Reopen VS Code, close any restored terminal with its trash can button, and open **Terminal > New Terminal > PowerShell**.

Run these commands in the regular terminal, outside Claude's message area.

```powershell
git --version
node --version
npm.cmd --version
```

**Done:** All three print version numbers. If a command is not recognized, use [command help](HELP.md#a-command-is-not-recognized) before reinstalling.

**Next: [Finish the editor settings](EDITOR.md)**
