# Part 2 | Node.js and Next.js on Mac

[Back to start](README.md)

**Using this guide on its own?** Finish all 3 steps. Stop when your app opens in your browser.

**Following the interactive book?** Complete **Step 1 and its version checks only**, then return to [Lesson 6.4](https://cyj-oss.github.io/itm325-vibecoding/#lesson=6.4&step=0) to create and run the app.

## 1. Prepare Node.js and npm

**Where: Mac Terminal, outside VS Code**

1. Press **Command+Space**, type **Terminal**, and press **Return**.
2. Paste this entire command and press **Return**:

```bash
course_setup="$(/usr/bin/mktemp /tmp/itm325-project.XXXXXX)" && /usr/bin/curl --fail --show-error --location --proto '=https' https://raw.githubusercontent.com/cyj-oss/itm325-setup2/main/prepare-mac.sh --output "$course_setup" && /bin/bash "$course_setup"
```

3. Read the summary. Type **Y**, press **Return**, and wait.

| Message on your screen | Your next action |
| --- | --- |
| **FINISH THE APPLE INSTALLER** | Finish the Command Line Tools installer, then run the same helper again. |
| **FINISH THE NODE INSTALLER** | Finish the official Node installer. Enter your Mac password there if requested. Run the same helper again. |
| **PROJECT TOOLS READY** | Check in VS Code below. |
| **SETUP NEEDS ATTENTION** | Stop and open [Setup Help](HELP.md). |

**Finish each installer and rerun the helper until PROJECT TOOLS READY appears.** Completed tools are kept.

<details>
<summary>What does the helper do? Already installed?</summary>

The helper checks Git, Node.js, and npm. It keeps supported working tools, including Git from the first setup, and installs missing tools. It does not create your Next.js app.

New Node installations use **Node.js 24 LTS**. Existing supported LTS versions are kept. Old or broken installations are left in place for [help](HELP.md#nodejs-version-or-installation-problems).

Node.js 24 requires **macOS 13.5 or later**. Homebrew and the full Xcode app are not required.

</details>

### Check in VS Code

Save your work. Quit VS Code with **Command+Q**, then reopen it. Close any restored terminal with its **trash can** button. Choose **Terminal → New Terminal** and use **Zsh** or your usual **Bash** shell.

**Where: VS Code Zsh or Bash terminal, outside Claude's message area**  
**Copy all three lines together**, paste, and press **Return**:

```bash
git --version
node --version
npm --version
```

> **CHECK 1 — All three print version numbers.**
>
> **Interactive book:** stop here and use the button below. **Using only this guide:** continue to Step 2.

[![Return to book — Lesson 6.4, Step 1](https://raw.githubusercontent.com/cyj-oss/itm325-vibecoding/main/return-to-book.svg)](https://cyj-oss.github.io/itm325-vibecoding/#lesson=6.4&step=0)

If any command fails, use [command help](HELP.md#a-command-is-not-recognized).

## 2. Create the Next.js app

**Where: The same VS Code terminal**

### Go to your course folder

In **Finder**, open your existing **webdev** folder containing your earlier course projects. Choose **View → Show Path Bar**. **Control-click webdev** in that bar and choose **Copy “webdev” as Pathname**.

Replace **PASTE_FULL_PATH_TO_WEBDEV_HERE** with that path. Keep the quotes, then run:

```bash
cd "PASTE_FULL_PATH_TO_WEBDEV_HERE"
```

**If cd reports an error, fix the path before continuing.** Then copy both checks together:

```bash
pwd
ls
```

> **CHECK — The path ends in webdev, and its contents are listed.**

### Create your app

**Already have ohana-link with package.json inside?** Skip the next command and go to Step 3. For an app with another name, use that name in Step 3.

For a **new app**, run:

```bash
npx create-next-app@latest ohana-link --use-npm
```

- Asked to install **create-next-app**? Type **y** and press **Return**.
- Asked about defaults? Choose **Yes, use recommended defaults** and press **Return**.

> **CHECK 2 — A success message appears and the terminal prompt returns. Continue to Step 3.**

If **ohana-link** already exists but is not a working app, ask for help before creating another copy.

## 3. Run the app

**Where: The same VS Code terminal, currently in webdev**

Enter your app folder:

```bash
cd ohana-link
```

After it succeeds, start the server:

```bash
npm run dev
```

**Where: Your browser**  
Open the **Local** address printed in the terminal, usually **http://localhost:3000**. Use the printed address if the port differs.

> **DONE — Your Next.js page appears in the browser. Stop here for Part 2.**
>
> Keep the terminal running while you use the app.

<details>
<summary>How do I edit, stop, or reopen the app?</summary>

In VS Code, choose **File → Open Folder** and select this **ohana-link** folder. You should see **package.json** in Explorer.

To stop the server, click its terminal and press **Control+C**. Later, open a new terminal in this app folder and run **npm run dev** again.

</details>

### Existing app with missing packages

<details>
<summary>My existing app has no node_modules folder</summary>

New apps already have their packages. For an existing app without **node_modules**, use the **VS Code terminal inside the app folder**.

If **package-lock.json** exists, run:

```bash
npm ci
```

If there is no **package-lock.json**, use this instead:

```bash
npm install
```

Then run **npm run dev**.

</details>

[Setup help](HELP.md) · [Official Next.js instructions](https://nextjs.org/docs/app/getting-started/installation)
