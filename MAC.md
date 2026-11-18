# Part 2 | Node.js and Next.js on Mac

[Back to start](README.md)

Use this page in the Next.js lesson. Node.js runs JavaScript outside the browser, and npm manages project packages. Complete all three steps on this page: prepare the tools, create your app, and run it.

## 1. Prepare Node.js and npm

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
| **PROJECT TOOLS READY** | Check the tools in VS Code below. |
| **SETUP NEEDS ATTENTION** | Open [Setup Help](HELP.md) before continuing. |

You may need to run the helper again after each installer. Completed tools are kept. Homebrew and the full Xcode app are not required.

New Node installations use **Node.js 24 LTS**, which requires macOS **13.5 or later**. Existing supported LTS versions are kept. An old or broken installation is left in place with a link to help.

### Check in VS Code

Save your work, quit VS Code with **Command+Q**, and reopen it. Close any restored terminal with its trash can button. Open **Terminal > New Terminal** and use **Zsh** or your usual **Bash** shell.

Run each command separately in the regular terminal, outside Claude's message area.

```bash
git --version
```

```bash
node --version
```

```bash
npm --version
```

**Done:** All three print version numbers. If a command is not found, use [command help](HELP.md#a-command-is-not-recognized) before reinstalling.

## 2. Create the Next.js app

Keep using the VS Code terminal. Run **one command at a time**, pressing **Return** after each one.

### Go to your course folder

In **Finder**, open your existing **webdev** folder. Choose the one containing your earlier course projects. Choose **View > Show Path Bar**, then Control-click **webdev** in the path bar and choose **Copy “webdev” as Pathname**.

In the command below, replace **PASTE_FULL_PATH_TO_WEBDEV_HERE** with the path you copied. Keep the quotation marks. This uses your existing folder wherever it is located.

```bash
cd "PASTE_FULL_PATH_TO_WEBDEV_HERE"
```

If `cd` reports an error, check the path before continuing. Confirm your current location:

```bash
pwd
```

The path should end in **webdev**. List its contents:

```bash
ls
```

### Create your app

**Already have an app?** If this webdev folder already contains **ohana-link** with a **package.json** file inside it, skip the next command and continue to Step 3. If your existing app has a different name, use that name in Step 3.

For a new app, run:

```bash
npx create-next-app@latest ohana-link --use-npm
```

If asked to install **create-next-app**, type **y** and press **Return**. When asked about the recommended Next.js defaults, select **Yes, use recommended defaults** and press **Return**.

This creates **ohana-link** inside your current webdev folder and installs Next.js and the app's packages there. Wait for the success message and the terminal prompt to return. If the folder already exists but is not a working app, ask for help before creating another copy.

## 3. Run the app

From the **webdev** folder in the same terminal, enter your app folder:

```bash
cd ohana-link
```

Start the development server:

```bash
npm run dev
```

Open the **Local** address shown in the terminal in your browser. It is usually **http://localhost:3000**. If the terminal shows another port, use that address.

**Done:** Your Next.js page appears in the browser. Keep the terminal running while you use the app. To stop the server, click the terminal and press **Control+C**.

To edit the project, use **File > Open Folder** in VS Code and select this **ohana-link** folder. You should see **package.json** in Explorer. When you reopen the project later, open a new terminal in that folder and run `npm run dev` again.

### Existing app with missing packages

A newly created app already has its packages. For an existing app without **node_modules**, restore them from the app folder before running the server.

If **package-lock.json** is present, run:

```bash
npm ci
```

If there is no package-lock.json, run this instead:

```bash
npm install
```

Then run `npm run dev`.

[Setup help](HELP.md) · [Publish the app to GitHub when assigned](GITHUB.md#4-open-your-course-project) · [Official Next.js instructions](https://nextjs.org/docs/app/getting-started/installation)
