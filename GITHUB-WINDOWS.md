# Part 1 | GitHub Account and Connection — Windows

[Back to start](README.md) · [Mac instructions](GITHUB-MAC.md)

**Finish Steps 1–3. Stop at DONE.**

## 1. Check your installed Git

Git was included in the first course setup. **Check its version; if a version appears, continue without reinstalling.**

In VS Code, choose **Terminal → New Terminal → PowerShell**. Run commands outside Claude Code.

Copy, paste, and press **Enter**:

> **Where to paste:** VS Code terminal · **PowerShell**

```powershell
git --version
```

> **CHECK 1 — A Git version appears. Continue to Step 2.**

<details>
<summary>Git is not recognized</summary>

Try [command help](HELP.md#a-command-is-not-recognized) first. Use the [Windows Git installer instructions](HELP.md#install-git-manually-on-windows) only if Git is missing.

</details>

## 2. Create or use your GitHub account

**Where: Your browser**

1. Open [GitHub](https://github.com/).
2. **Sign in**, or **Sign up** for a free account.
3. Complete email verification and any requested sign-in steps.

> **CHECK 2 — Your profile menu shows your class account. Continue to Step 3.**

## 3. Set your Git name and email

**Check first. Copy both lines together:**

> **Where to paste:** VS Code terminal · **PowerShell**

```text
git config --get user.name
git config --get user.email
```

**Both values correct?** Skip the next block. Otherwise, replace **Your Name** and **you@example.com** below with your own name and a GitHub-verified email. Keep the quotes. You can use your GitHub **noreply** address from [email settings](https://github.com/settings/emails) for privacy.

**After replacing both placeholders, copy these lines together:**

> **Where to paste:** VS Code terminal · **PowerShell**

```text
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

Run the **two check commands above again**. If they still show different values, use [Git identity help](HELP.md#git-shows-the-wrong-name-or-email).

> **DONE — Check all three:**
>
> - Git prints a version.
> - You can sign in to your GitHub account.
> - Git shows your correct name and email.
>
> **Stop here for Part 1.** GitHub authorization happens when you publish or push in the lesson.

[![Return to book — Lesson 5.4, Step 1](https://raw.githubusercontent.com/cyj-oss/itm325-vibecoding/main/return-to-book.svg)](https://cyj-oss.github.io/itm325-vibecoding/#lesson=5.4&step=0)

<details>
<summary>VS Code says to configure user.name and user.email</summary>

Complete Step 3, then try **Commit** again. These settings identify the author of your commits; they do not sign you in to GitHub. You do not need GitHub Desktop, GitHub Copilot, or Node.js for Part 1.

**Returning to your commit in Lesson 5.4, Step 2?**

[![Return to book — Lesson 5.4, Step 2](https://raw.githubusercontent.com/cyj-oss/itm325-vibecoding/main/return-to-book.svg)](https://cyj-oss.github.io/itm325-vibecoding/#lesson=5.4&step=1)

</details>

[Need help?](HELP.md) · [Official VS Code GitHub guide](https://code.visualstudio.com/docs/sourcecontrol/github)