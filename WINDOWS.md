# Part 2 | Windows

[Back to start](README.md)

Use VS Code from the first setup. Open **Terminal > New Terminal** and select **PowerShell**. If Claude is running in that terminal, press **Ctrl+C twice** to leave it first.

## 1. Check Git

```powershell
git --version
```

**A Git version appears:** Keep it. The first Windows setup already installs Git when needed.

**The command is not recognized:** Save your work, close every VS Code window, and reopen VS Code. Close any restored terminal with its trash can button, open a new terminal, and check again.

If Git is still missing:

1. Open the [official Git for Windows download page](https://git-scm.com/install/windows).
2. Download the installer for your computer. Check **Settings > System > About > System type** if you are unsure which architecture you need.
3. Run the installer. Select **Visual Studio Code** if asked for the default editor. Keep the option that makes Git available from the command line and third-party software.
4. Finish the installation. Reopen VS Code and a new terminal, then run `git --version` again.

## 2. Check Node.js and npm

Run each command separately.

```powershell
node --version
```

```powershell
npm.cmd --version
```

If both work, compare your Node version with the releases labeled **LTS** on the [official Node.js download page](https://nodejs.org/en/download). The first number after `v` is the major version. Keep an installed major version that is still listed as LTS.

If Node is missing, install it below. If it is old or npm is missing, see [Node.js help](HELP.md#nodejs-version-or-installation-problems) before adding another installation.

## 3. Install Node.js if needed

1. Open the [official Node.js download page](https://nodejs.org/en/download).
2. Choose **LTS** and **Windows**. Find the prebuilt **Windows Installer (.msi)** for your system type, usually **x64**, or **ARM64** for an ARM computer.
3. Open the installer and follow its screens. Keep **npm package manager** and **Add to PATH** selected.
4. If a **Tools for Native Modules** screen appears, leave automatic installation of additional tools unchecked. Those extra tools are not needed for this setup.
5. Finish. Save your work and close every VS Code window. Reopen VS Code, close any restored terminal, and open a new PowerShell terminal.
6. Repeat the two version checks above.

This guide uses `npm.cmd` and `npx.cmd` in PowerShell to avoid the script execution-policy error. These run the same npm and npx tools.

**Done:** Git, Node.js, and npm each print a version number, and your Node release is still LTS.

**Next: [VS Code extensions](EDITOR.md)**

[Need help?](HELP.md)
