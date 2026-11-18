# Part 2 | Create and Run the Next.js App

[Back to start](README.md)

First prepare Node.js and npm using the **[Windows](WINDOWS.md)** or **[Mac](MAC.md)** guide. Then use this page in the Ohana Link lesson.

## 1. Choose your course folder and prepare the app

The helper looks for an existing **webdev** folder in your current location, home folder, and common course locations. It shows the full paths and asks you to choose. If your folder is not listed, paste its full path. Choose the folder containing your earlier course projects.

**Windows PowerShell**

Open **Windows PowerShell**. The prompt should start with **PS**. If it does not, type `powershell` and press Enter first. Copy and run the entire block:

```powershell
& {
    $ErrorActionPreference = 'Stop'
    $courseHelper = Join-Path ([IO.Path]::GetTempPath()) ('itm325-nextjs-' + [guid]::NewGuid().ToString('N') + '.cjs')
    Invoke-WebRequest -UseBasicParsing -Uri 'https://raw.githubusercontent.com/cyj-oss/itm325-setup2/main/create-next-app.cjs' -OutFile $courseHelper
    & node $courseHelper
}
```

**Mac**

Open **Terminal**. Copy and run the entire command:

```bash
course_helper_dir="$(/usr/bin/mktemp -d /tmp/itm325-nextjs.XXXXXX)" && /usr/bin/curl --fail --show-error --location --proto '=https' https://raw.githubusercontent.com/cyj-oss/itm325-setup2/main/create-next-app.cjs --output "$course_helper_dir/create-next-app.cjs" && node "$course_helper_dir/create-next-app.cjs"
```

1. Enter the number beside your **webdev** folder, or paste its full path. Press Enter. To stop, enter **Q**.
2. If **ohana-link** already contains a Next.js app, the helper keeps it and displays **APP FOLDER**. Continue to Step 2 below.
3. For a new app, check the displayed location and type **Y**. Approve the download of **create-next-app** if prompted. Choose the recommended defaults with **TypeScript, ESLint, Tailwind CSS, and App Router**.
4. Wait for **APP FOLDER** and note the full path. If the helper reports an incomplete existing folder, check that folder before continuing. Existing files are not overwritten or moved.

This installs Next.js, React, and the app's packages inside **ohana-link** in your chosen **webdev** folder. No new **webdev** folder is created.

## 2. Run the app

In VS Code, choose **File > Open Folder** and open the exact **APP FOLDER** printed by the helper. Confirm that **package.json** is visible in the Explorer. Open **Terminal > New Terminal** in this project folder.

For an existing app without its `node_modules` folder, restore packages first: use `npm.cmd ci` on Windows or `npm ci` on Mac if **package-lock.json** exists. If there is no lock file, use `npm.cmd install` or `npm install` instead.

**Windows PowerShell**

```powershell
npm.cmd run dev
```

**Mac**

```bash
npm run dev
```

Open the **Local** address printed in the terminal, usually **http://localhost:3000**. Leave the terminal running while using the app. To stop it, press **Control+C** on either computer.

**Done:** The app opens in your browser without an error. If another port is printed, use that address.

Continue with the lesson. Use [GitHub connection](GITHUB.md#4-open-your-course-project) when you are ready to publish this project. Open **ohana-link** as the project folder for that step.

[Need help?](HELP.md) · [Official Next.js installation guide](https://nextjs.org/docs/app/getting-started/installation)
