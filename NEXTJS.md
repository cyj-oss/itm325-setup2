# Create and Run the Next.js App

[Back to start](README.md)

Use this page when the lesson asks you to create **Ohana Link**. Finish the Windows or Mac tool checks first.

**Already created the app?** Open its existing folder and go to Step 2. Do not create another app over your work.

## 1. Create the app

In VS Code, choose **File > Open Folder** and open your **webdev** course folder. Open **Terminal > New Terminal**. The terminal should be in that folder.

Run the command for your computer.

**Windows PowerShell**

```powershell
npx.cmd create-next-app@latest ohana-link
```

**Mac**

```bash
npx create-next-app@latest ohana-link
```

Approve the download of **create-next-app** when prompted. Choose the recommended defaults with **TypeScript, ESLint, Tailwind CSS, and App Router**. Wait for the success message.

This installs Next.js, React, and the app's other packages inside the new project. They are not separate desktop applications.

If a folder named **ohana-link** already exists, open that folder and inspect it before proceeding. Keep existing work.

## 2. Run the app

Choose **File > Open Folder** and open **webdev/ohana-link**. Confirm that **package.json** is visible in the Explorer. Open a new terminal in this project folder.

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

Continue with the lesson. Use [GitHub connection](GITHUB.md#3-open-your-course-project) when you are ready to publish this project.

[Need help?](HELP.md) · [Official Next.js installation guide](https://nextjs.org/docs/app/getting-started/installation)
