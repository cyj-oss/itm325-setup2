# Part 2 | Node.js and Next.js on Windows

[Back to start](README.md)

Use this page in the Next.js lesson. Node.js runs JavaScript outside the browser, and npm manages project packages. Complete all three steps on this page: prepare the tools, create your app, and run it.

## 1. Prepare Node.js and npm

Open **Windows PowerShell** from Start. Use the entry without **x86** and open it normally.

Check that the prompt begins with **PS**. If you opened Command Prompt instead, type `powershell` and press Enter first.

Copy this entire command, paste it into PowerShell, and press **Enter**.

```powershell
& ([scriptblock]::Create((Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/cyj-oss/itm325-setup2/main/prepare-windows.ps1')))
```

Type **Y** to continue. The helper checks Git, Node.js, and npm. It keeps supported working installations and installs missing tools. Git from the first course setup is kept if it works.

If the Node installer opens, complete it. Keep **npm** and **Add to PATH** selected. Leave **Tools for Native Modules** unchecked if offered. Review any Windows permission prompt.

New Node installations use **Node.js 24 LTS**. Existing supported LTS versions are kept. An old or broken installation is left in place with a link to help.

Wait for **PROJECT TOOLS READY**. If you see **SETUP NEEDS ATTENTION**, use [Setup Help](HELP.md) before continuing.

### Check in VS Code

Save your work and close **all VS Code windows**. Reopen VS Code, close any restored terminal with its trash can button, and open **Terminal > New Terminal**. If it is not PowerShell, use the terminal dropdown to select **PowerShell**.

Run each command separately in the regular terminal, outside Claude's message area.

```powershell
git --version
```

```powershell
node --version
```

```powershell
npm.cmd --version
```

**Done:** All three print version numbers. If a command is not recognized, use [command help](HELP.md#a-command-is-not-recognized) before reinstalling.

## 2. Create the Next.js app

Keep using the VS Code terminal. Run **one command at a time**, pressing **Enter** after each one.

### Go to your course folder

In **File Explorer**, open your existing **webdev** folder. Choose the one containing your earlier course projects. Click the address bar and copy its full path.

In the command below, replace **PASTE_FULL_PATH_TO_WEBDEV_HERE** with the path you copied. Keep the quotation marks. This uses your existing folder wherever it is located.

```powershell
cd "PASTE_FULL_PATH_TO_WEBDEV_HERE"
```

If `cd` reports an error, check the path before continuing. Confirm your current location:

```powershell
pwd
```

The path should end in **webdev**. List its contents:

```powershell
ls
```

### Create your app

**Already have an app?** If this webdev folder already contains **ohana-link** with a **package.json** file inside it, skip the next command and continue to Step 3. If your existing app has a different name, use that name in Step 3.

For a new app, run:

```powershell
npx.cmd create-next-app@latest ohana-link --use-npm
```

If asked to install **create-next-app**, type **y** and press **Enter**. When asked about the recommended Next.js defaults, select **Yes, use recommended defaults** and press **Enter**.

This creates **ohana-link** inside your current webdev folder and installs Next.js and the app's packages there. Wait for the success message and the terminal prompt to return. If the folder already exists but is not a working app, ask for help before creating another copy.

## 3. Run the app

From the **webdev** folder in the same terminal, enter your app folder:

```powershell
cd ohana-link
```

Start the development server:

```powershell
npm.cmd run dev
```

Open the **Local** address shown in the terminal in your browser. It is usually **http://localhost:3000**. If the terminal shows another port, use that address.

**Done:** Your Next.js page appears in the browser. Keep the terminal running while you use the app. To stop the server, click the terminal and press **Control+C**.

To edit the project, use **File > Open Folder** in VS Code and select this **ohana-link** folder. You should see **package.json** in Explorer. When you reopen the project later, open a new terminal in that folder and run `npm.cmd run dev` again.

### Existing app with missing packages

A newly created app already has its packages. For an existing app without **node_modules**, restore them from the app folder before running the server.

If **package-lock.json** is present, run:

```powershell
npm.cmd ci
```

If there is no package-lock.json, run this instead:

```powershell
npm.cmd install
```

Then run `npm.cmd run dev`.

[Setup help](HELP.md) · [Publish the app to GitHub when assigned](GITHUB.md#4-open-your-course-project) · [Official Next.js instructions](https://nextjs.org/docs/app/getting-started/installation)
