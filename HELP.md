# Setup Help

[Back to start](README.md)

## A command is not recognized

Save your work and completely close VS Code. On Mac, use **Command+Q**. Reopen VS Code, close any restored terminal with its trash can button, and open **Terminal > New Terminal**.

Check again before reinstalling. Run commands in PowerShell, Zsh, or Bash, not in Claude's message area. Press **Control+C twice** to leave Claude first.

If the command still fails, share the command and the exact error with your instructor. Leave out passwords and keys.

## PowerShell says npm.ps1 cannot be loaded

Use **npm.cmd** instead of **npm**, and **npx.cmd** instead of **npx**.

```powershell
npm.cmd --version
```

For example, run `npm.cmd run dev`. Changing PowerShell's execution policy is not required.

## Node.js version or installation problems

- **The helper prints KEEP for Node and npm:** Keep them. No reinstall is needed.
- **The helper does not recognize your Node version:** It checks Node 22, 24, and 26 against their LTS support dates. Compare your release with the [official Node.js releases](https://nodejs.org/en/about/previous-releases). Ask for help with a newer supported release before replacing it.
- **You use nvm, fnm, Volta, or Homebrew to manage Node:** Keep using that method to select or install a supported LTS version. Do not add the standalone installer on top of it. Ask for help if you are unsure which method you have.
- **You previously used the official Node installer:** Use the official LTS installer to update or repair that installation, then reopen VS Code and check Node and npm again.
- **Only one check works, or you do not know how Node was installed:** Ask for help before removing or adding tools.

Do not use administrator mode or `sudo npm install` to work around a project package error. Use a course folder owned by your normal account.

## Install Node manually

Use this only if the helper cannot finish and you do not use a Node version manager.

1. Open the [official Node.js download page](https://nodejs.org/en/download) and select **Node.js 24 LTS**.
2. Choose **Windows Installer (.msi)** or **macOS Installer (.pkg)**. On Windows, match the architecture in **Settings > System > About > System type**: usually x64, or ARM64 for an ARM computer.
3. Complete the installer. On Windows, keep npm and Add to PATH selected; leave additional Tools for Native Modules unchecked.
4. Reopen VS Code and a new terminal. Run the helper again to verify the result.

## Install Git manually on Windows

1. Open the [official Git for Windows page](https://git-scm.com/install/windows) and download the installer for your system type.
2. Complete the installer. Choose VS Code as the editor if asked. Keep Git available from the command line and third-party software.
3. Reopen VS Code and a new terminal. Run the helper again.

## Mac Git does not start

Wait until the Apple Command Line Tools installer has finished, reopen VS Code, and try `git --version` again.

If the tools are already installed but Git reports an invalid developer path, check **System Settings > General > Software Update** for a Command Line Tools update. If no update is offered or installation fails, ask for help and include your macOS version and the error. Do not delete the developer-tools folder.

## Git shows the wrong name or email

In your project folder, run:

```text
git config --show-origin --get user.name
git config --show-origin --get user.email
```

These show which settings file supplies each value. A project-specific value overrides the global value. If needed, set your details for this project with `git config user.name "Your Name"` and `git config user.email "Your GitHub Email"`, replacing the example text.

## Files that should not be uploaded

Keep `node_modules/`, `.next/`, and `.env*` in your project's **.gitignore**. Review Source Control again. Use the **minus** button to unstage an unwanted file without deleting it.

If a file was already committed, adding it to .gitignore does not stop Git tracking it. For an already tracked **.env.local**, run this from the project folder:

```text
git rm --cached -- .env.local
```

This keeps the local file and removes it from future tracked snapshots. Commit that change. It does not erase earlier commits. If a secret key or password was published, rotate it in the service that issued it and ask for help with the repository history.

If a generated folder such as node_modules was already committed, ask for help before publishing the project.

## GitHub does not connect or publish

- Confirm that the browser is signed in to the account you want to use.
- Complete the VS Code browser authorization and return to VS Code.
- If GitHub blocks a commit email for privacy, use the noreply address shown in GitHub email settings and ask for help updating any unpublished commit that still uses the old email.
- If your repository already exists or you see a different remote connection, keep it and ask for help selecting the correct destination. Do not replace it or force-push.
- If you see **nothing to commit**, your files may already be committed. Check Source Control Graph and continue to publishing.

## The app does not run

- **package.json not found:** Open the actual app folder, then open a new terminal.
- **Missing packages:** Follow the restore-packages step in [the Next.js guide](NEXTJS.md#2-run-the-app).
- **Port 3000 is in use:** Open the Local address printed by the current terminal. It may use another port.

## Supabase setup or data access fails

- Confirm that your cloud project is active and that its URL and publishable key come from the same project.
- Check **.env.local** in the folder containing **package.json**, then restart the app's development server.
- If the app connects but cannot read or save lesson data, check the table names, permissions, and RLS policies from the lesson. Keep RLS enabled while fixing the policy.

When asking for help, share the error and the step where it happened. Do not include environment-file contents, passwords, or secret keys.
