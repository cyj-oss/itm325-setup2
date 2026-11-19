# Part 1 | GitHub Account and Connection

[Back to start](README.md)

Use this page in the Git and GitHub lesson. **GitHub is an online service.** You do not need GitHub Desktop, GitHub Copilot, or Node.js for these steps.

## 1. Check Git

Open **Terminal > New Terminal** in VS Code. Run this in the regular terminal, outside Claude's message area:

```text
git --version
```

**If a Git version appears, keep the installation and continue to Step 2.**

**Windows:** Git was included in the first course setup. If the command is not recognized, follow [command help](HELP.md#a-command-is-not-recognized) first. Install Git using the [Windows instructions](HELP.md#install-git-manually-on-windows) only if it is missing.

**Mac:** If Apple opens a Command Line Tools installer, complete it. If Git is missing and no installer opens, run:

```bash
xcode-select --install
```

Complete the Apple installer, quit VS Code with **Command+Q**, and reopen it with a new terminal. Run `git --version` again. The full Xcode app and Homebrew are not required. If the tools are already installed but Git fails, use [Mac Git help](HELP.md#mac-git-does-not-start).

## 2. Create or use your GitHub account

1. Open [GitHub](https://github.com/).
2. Sign in to your existing account, or select **Sign up** and create a free account.
3. Complete email verification and any sign-in steps GitHub requests.

**Check:** Your profile menu shows the account you will use for class.

## 3. Set your Git name and email

Complete this before your first commit. **Windows and Mac use the same commands.** In VS Code, open **Terminal > New Terminal** and run each command separately in the regular terminal.

Check your current settings:

```text
git config --get user.name
```

```text
git config --get user.email
```

**If both show your correct name and email, keep them and skip the setup commands below.**

Otherwise, replace **Your Name** with your name and **you@example.com** with an email verified in your GitHub account. To keep your email private, use the GitHub-provided **noreply** address shown in [GitHub email settings](https://github.com/settings/emails). Keep the quotation marks and run these commands one at a time:

```text
git config --global user.name "Your Name"
```

```text
git config --global user.email "you@example.com"
```

Run the two check commands again. **Done:** They show the name and email you want recorded in your commits. If they still show different values, use [Git identity help](HELP.md#git-shows-the-wrong-name-or-email).

These settings identify the author of your commits. They do not sign you in to GitHub.

If VS Code says **Make sure you configure your "user.name" and "user.email" in git**, complete this step, then try **Commit** again.

[Need help?](HELP.md) · [Official VS Code GitHub guide](https://code.visualstudio.com/docs/sourcecontrol/github)
