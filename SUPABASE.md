# Part 3 | Supabase Setup

[Back to start](README.md)

**Start after your Next.js app runs. Windows and Mac use this same page.**

**Finish line: A Supabase project, app connection settings, and an app that starts.** Database read/write testing comes later in the lesson.

## 1. Sign in and create a project

**Where: Your browser → [Supabase](https://supabase.com/)**

1. Select **Start your project**. Sign in or sign up; you may use your GitHub account.
2. Select your existing free organization or create one on the **Free** plan.
3. Open your existing **ohana-link** project, or create one with these settings:

| Setting | Choose |
| --- | --- |
| Project name | **ohana-link** |
| Database password | Generate one and save it in your password manager |
| Region | **Americas** |
| Data API | **Enabled** |
| Row Level Security (RLS) | **Enabled**, including automatic RLS if offered |

![Supabase project creation screen with Americas selected](supabase-project-americas.png)

*Example screen. Use your own organization and password.*

Create the project and wait. If the free plan cannot create another project, ask for help before paying or deleting a project.

> **CHECK 1 — Your project dashboard is ready. Continue to Step 2.**

## 2. Get the app connection details

**Where: Supabase project dashboard → Connect → Next.js / App Router**

Under **Add files**, select the **.env.local** tab. It shows two lines:

- **`NEXT_PUBLIC_SUPABASE_URL`** — your Project URL.
- **`NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY`** — your publishable key.

Keep this tab open. You will copy these lines in **Step 3B** below.

Continue to **Step 3** below. Claude will prepare the packages and files; you do not need to run the dashboard's installation commands separately.

> **CHECK 2 — You have both values from the same project. Continue to Step 3.**
>
> Use the **publishable key**, never a secret key, service_role key, or database password.

## 3. Prepare the connection in your app

### A. Ask Claude to prepare the files

1. In VS Code, open your existing **ohana-link** folder.
2. Check that **.gitignore** includes `.env*`; keep its other entries.
3. Start Claude Code in this project.

Paste the entire prompt and press **Enter** to send:

> **Where to paste:** **Claude Code input** · in the VS Code terminal panel

```text
Connect this existing Next.js App Router project to Supabase.
Follow the current official Supabase Next.js instructions at https://supabase.com/docs/guides/getting-started/quickstarts/nextjs.
Inspect the existing files first and preserve my app and any working connection.
Install missing Supabase packages locally in this project using its existing package manager.
Create or update the appropriate Supabase client files for this app.
Use NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY from .env.local.
If a value is missing, leave a clear placeholder for me to fill in locally. Do not print existing values or overwrite them.
Ensure .env.local is ignored by Git. Do not use a secret key, service_role key, or database password.
Keep Row Level Security enabled. Do not create tables, change database policies, add authentication screens, or publish anything yet.
Show me the files you changed and the exact command to start the app.
Tell me which setup checks you completed. Do not claim that database reads or writes work until they have been tested against the lesson tables.
```

Review Claude's proposed changes and installation commands before approving them.

### B. Add your project's values

1. In VS Code, open **.env.local** in your **ohana-link** folder, beside **package.json**.
2. Return to Supabase's **Add files → .env.local** tab. Copy only the **two complete lines**, including each name, `=`, and full value. Scroll horizontally if needed to reach the ends.
3. In your project's **.env.local**, replace the two matching placeholder lines with the copied lines. Keep any other settings and save the file.

Your two lines should have this format, with your own project's values:

> **Where to paste:** VS Code editor · **.env.local** · beside **package.json**

```dotenv
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=your-publishable-key
```

> **CHECK 3 — Claude created or updated the connection files, and .env.local has your real values instead of placeholders. Continue to Step 4.**

<details>
<summary>Is the publishable key a password?</summary>

No. It is intended for app code, including browser code. Database permissions and RLS policies control access to data. Secret keys and database passwords must stay private.

Supabase runs online; no local database server, Docker, or Supabase CLI is required here. Signing in with GitHub does not connect Supabase to your app.

</details>

## 4. Check the setup

Run commands outside Claude Code. **Copy both checks together:**

> **Where to paste:** VS Code terminal · **PowerShell on Windows / Zsh or Bash on Mac** · in **ohana-link**

```text
git check-ignore .env.local
git ls-files .env.local
```

> **CHECK — The first command prints .env.local. The second prints nothing.**

If either result differs, use [file help](HELP.md#files-that-should-not-be-uploaded) before publishing.

Stop the running development server with **Control+C**. Restart it in the **app's terminal** using only your computer's command:

> **Where to paste:** VS Code terminal · **PowerShell** · in **ohana-link**

```powershell
npm.cmd run dev
```

> **Where to paste:** VS Code terminal · **Zsh or Bash** · in **ohana-link**

```bash
npm run dev
```

**Where: Your browser**  
Open the **Local** address printed in the terminal. Check that the app starts without setup errors.

> **DONE — Check all three:**
>
> - Your Supabase project exists.
> - Connection files and real settings are saved; .env.local is ignored and untracked.
> - Your app starts.
>
> **Stop here for Part 3 setup.** This does not yet prove database reads or writes work.

[![Return to book — Lesson 8.2, Step 1](https://raw.githubusercontent.com/cyj-oss/itm325-vibecoding/main/return-to-book.svg)](https://cyj-oss.github.io/itm325-vibecoding/#lesson=8.2&step=0&resume=1)

<details>
<summary>When do we test reading and saving data?</summary>

In the database lesson, create the tables and access policies. Save a test item in the app, confirm it appears in Supabase, and reload the app to confirm it is read back. That is the final connection check.

</details>

[Need help?](HELP.md) · [Official Next.js connection guide](https://supabase.com/docs/guides/getting-started/quickstarts/nextjs) · [Supabase API keys](https://supabase.com/docs/guides/getting-started/api-keys)
