# Part 2 | Mac

[Back to start](README.md)

Use VS Code from the first setup. Open **Terminal > New Terminal** and use **Zsh** or your usual **Bash** shell. If Claude is running in that terminal, press **Control+C twice** to leave it first.

## 1. Check Git

```bash
git --version
```

**A Git version appears:** Keep it, including a version labeled **Apple Git**. An existing Homebrew Git installation is also fine.

**A developer-tools installation window appears:** Follow the Apple installer and wait for it to finish.

**Git is missing and no installation window appears:** Run this command once.

```bash
xcode-select --install
```

Complete the installation in the Apple window. This installs **Command Line Tools**, which include Git. You do not need to download the full Xcode app or add Homebrew for this guide.

After installation, save your work, quit VS Code with **Command+Q**, and reopen it. Close any restored terminal with its trash can button. Open a new terminal and run `git --version` again.

If Apple says the tools are already installed but Git still fails, use [Mac Git help](HELP.md#mac-git-does-not-start).

## 2. Check Node.js and npm

Run each command separately.

```bash
node --version
```

```bash
npm --version
```

If both work, compare your Node version with the releases labeled **LTS** on the [official Node.js download page](https://nodejs.org/en/download). The first number after `v` is the major version. Keep an installed major version that is still listed as LTS.

If Node is missing, install it below. If it is old or npm is missing, see [Node.js help](HELP.md#nodejs-version-or-installation-problems) before adding another installation.

## 3. Install Node.js if needed

1. Open the [official Node.js download page](https://nodejs.org/en/download).
2. Choose **LTS** and **macOS**. Find the prebuilt **macOS Installer (.pkg)**. If asked to choose an architecture, use **ARM64** for Apple silicon or **x64** for Intel. **Apple menu > About This Mac** identifies your chip or processor.
3. Open the installer and follow its screens. Enter your Mac password if the official installer requests it. Node.js and npm are installed together.
4. Save your work, quit VS Code with **Command+Q**, and reopen it. Close any restored terminal and open a new one.
5. Repeat the two version checks above.

**Done:** Git, Node.js, and npm each print a version number, and your Node release is still LTS.

**Next: [VS Code extensions](EDITOR.md)**

[Need help?](HELP.md) · [Official Git installation options](https://git-scm.com/install/mac)
