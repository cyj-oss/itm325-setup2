# Part 2 | Node.js and Next.js on Windows

[Back to start](README.md)

**Finish all 3 steps. Stop when your app opens in your browser.**

## 1. Prepare Node.js and npm

**Where: Windows PowerShell, outside VS Code**

1. Search for **Windows PowerShell** in Start and open it normally, **without x86**. The prompt should begin with **PS**. If you opened Command Prompt, type **powershell** and press Enter first.
2. Paste this entire command and press **Enter**:

```powershell
& ([scriptblock]::Create((Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/cyj-oss/itm325-setup2/main/prepare-windows.ps1')))
```

3. Read the summary. Type **Y**, press **Enter**, and wait.

If the Node installer opens, keep **npm** and **Add to PATH** selected. Leave **Tools for Native Modules** unchecked if offered. Review any Windows permission prompt.

> **WAIT — PROJECT TOOLS READY must appear. Then check in VS Code below.**

**SETUP NEEDS ATTENTION?** Stop and open [Setup Help](HELP.md).

<details>
<summary>What does the helper do? Already installed?</summary>

The helper checks Git, Node.js, and npm. It keeps supported working tools, including Git from the first setup, and installs missing tools. It does not create your Next.js app.

New Node installations use **Node.js 24 LTS**. Existing supported LTS versions are kept. Old or broken installations are left in place for [help](HELP.md#nodejs-version-or-installation-problems).

</details>

### Check in VS Code

Save your work. Close **all VS Code windows**, then reopen VS Code. Close any restored terminal with its **trash can** button. Choose **Terminal → New Terminal** and select **PowerShell** from its dropdown.

**Where: VS Code PowerShell terminal, outside Claude's message area**  
**Copy all three lines together**, paste, and press **Enter**:

```powershell
git --version
node --version
npm.cmd --version
```

> **CHECK 1 — All three print version numbers. Continue to Step 2.**

If any command fails, use [command help](HELP.md#a-command-is-not-recognized).

## 2. Create the Next.js app

**Where: The same VS Code terminal**

### Go to your course folder

In **File Explorer**, open your existing **webdev** folder containing your earlier course projects. Click the **address bar** and copy the full path.

Replace **PASTE_FULL_PATH_TO_WEBDEV_HERE** with that path. Keep the quotes, then run:

```powershell
cd "PASTE_FULL_PATH_TO_WEBDEV_HERE"
```

**If cd reports an error, fix the path before continuing.** Then copy both checks together:

```powershell
pwd
ls
```

> **CHECK — The path ends in webdev, and its contents are listed.**

### Create your app

**Already have ohana-link with package.json inside?** Skip the next command and go to Step 3. For an app with another name, use that name in Step 3.

For a **new app**, run:

```powershell
npx.cmd create-next-app@latest ohana-link --use-npm
```

- Asked to install **create-next-app**? Type **y** and press **Enter**.
- Asked about defaults? Choose **Yes, use recommended defaults** and press **Enter**.

> **CHECK 2 — A success message appears and the terminal prompt returns. Continue to Step 3.**

If **ohana-link** already exists but is not a working app, ask for help before creating another copy.

## 3. Run the app

**Where: The same VS Code terminal, currently in webdev**

Enter your app folder:

```powershell
cd ohana-link
```

After it succeeds, start the server:

```powershell
npm.cmd run dev
```

**Where: Your browser**  
Open the **Local** address printed in the terminal, usually **http://localhost:3000**. Use the printed address if the port differs.

> **DONE — Your Next.js page appears in the browser. Stop here for Part 2.**
>
> Keep the terminal running while you use the app.

<details>
<summary>How do I edit, stop, or reopen the app?</summary>

In VS Code, choose **File → Open Folder** and select this **ohana-link** folder. You should see **package.json** in Explorer.

To stop the server, click its terminal and press **Control+C**. Later, open a new terminal in this app folder and run **npm.cmd run dev** again.

</details>

### Existing app with missing packages

<details>
<summary>My existing app has no node_modules folder</summary>

New apps already have their packages. For an existing app without **node_modules**, use the **VS Code terminal inside the app folder**.

If **package-lock.json** exists, run:

```powershell
npm.cmd ci
```

If there is no **package-lock.json**, use this instead:

```powershell
npm.cmd install
```

Then run **npm.cmd run dev**.

</details>

[Setup help](HELP.md) · [Official Next.js instructions](https://nextjs.org/docs/app/getting-started/installation)
