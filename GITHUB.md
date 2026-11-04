# Part 2 | GitHub Account and Connection

[Back to start](README.md)

Git should already work in your VS Code terminal. **GitHub is an online service.** You do not need to install GitHub Desktop or buy GitHub Copilot for these steps.

## 1. Create or use your GitHub account

1. Open [GitHub](https://github.com/).
2. Sign in to your existing account, or select **Sign up** and create a free account.
3. Complete email verification and any sign-in steps GitHub requests.

**Check:** Your profile menu shows the account you will use for class.

## 2. Check your Git name and email

In a regular VS Code terminal, run:

```text
git config --get user.name
git config --get user.email
```

Keep these values if they already identify you. If a value is missing or belongs to someone else, set your own details below. Replace the example text inside the quotation marks before running the commands.

```text
git config --global user.name "Your Name"
git config --global user.email "Your GitHub Email"
```

Use an email verified in GitHub, or copy your GitHub-provided **noreply** address from [GitHub email settings](https://github.com/settings/emails). Your name and email are recorded in commits; these commands do not sign you in.

Run the two checks again. If they still show someone else's details, see [Git identity help](HELP.md#git-shows-the-wrong-name-or-email).

## 3. Open your course project

Choose **File > Open Folder** in VS Code and open the actual project folder. For Ohana Link, this is **ohana-link**, not the parent **webdev** folder.

If you have not created a project yet, your account preparation is complete. Return to this step when the lesson asks you to publish a project. For the Next.js lesson, use [Create and run the Next.js app](NEXTJS.md).

If your project is already connected to your GitHub account, keep the connection and go to Step 5.

## 4. Commit and publish

1. Open **View > Source Control**. Select **Initialize Repository** only if the project is not already a Git repository.
2. Check the **.gitignore** file in your project. Keep its existing contents and add any missing entries below. Create the file if it does not exist.

   ```gitignore
   node_modules/
   .next/
   .env*
   ```

3. Review the files under **Changes**. Environment files, passwords, `node_modules`, and `.next` must not be included. If they appear, follow [Files that should not be uploaded](HELP.md#files-that-should-not-be-uploaded) before continuing.
4. Stage your project files with the **+** button. Enter a message such as **Save course project** and select **Commit**. If there are no changes and you already have a commit, continue.
5. Open the Command Palette with **Ctrl+Shift+P** on Windows or **Command+Shift+P** on Mac. Run **Publish to GitHub**. A **Publish Branch** button in Source Control may open the same flow.
6. When prompted, sign in to your GitHub account in the browser and authorize **Visual Studio Code**. Return to VS Code. If Git asks for a second browser sign-in, complete it with the same account.
7. Choose an available repository name for your project. Select **Private** unless the assignment requires a public repository. Let publishing finish.

You do not need to create an empty repository on the GitHub website first. Publishing from VS Code creates it in your account.

## 5. Check the result

Open your GitHub profile menu, select **Your repositories**, and open the project.

**Done:** Your project files and at least one commit appear in your own repository. Environment files and generated folders are absent.

Signing in alone does not upload files. After future edits, **Commit** saves changes locally and **Push** uploads those commits.

[Need help?](HELP.md) · [Official VS Code GitHub guide](https://code.visualstudio.com/docs/sourcecontrol/github)
