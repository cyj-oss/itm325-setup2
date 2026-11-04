# Part 3 | Supabase Setup

[Back to start](README.md)

Start this page in the database lesson, after your Next.js app runs locally. Windows and Mac follow the same steps.

Supabase hosts the database online. This setup does not require a local database server, Docker, or the Supabase CLI.

## 1. Sign in and create a project

1. Open [Supabase](https://supabase.com/) and select **Start your project**.
2. Use your existing account, or sign up. You can use the GitHub account you prepared in Part 2.
3. Create an organization with the **Free** plan, or select your existing free organization.
4. Create a project named **ohana-link**, or open the project you already created for this app.
5. Generate a database password and save it in your password manager. Choose an available **West US** region for the Hawaii course.
6. Keep the **Data API** enabled. Keep **Row Level Security**, including automatic RLS if offered, enabled. Create the project and wait until its dashboard is ready.

If the free plan cannot create another project, stop and ask for help before choosing a paid plan or removing an existing project.

Signing in with GitHub identifies your account. It does not automatically connect the database to your app.

## 2. Get the app connection details

In the project dashboard, open **Connect** and select the **Next.js / App Router** instructions. You can also find the project URL and **publishable key** in the project's settings and API Keys section.

Use the **Project URL** and **publishable key**. Do not use the database password, a secret key, or a `service_role` key for this browser-based connection.

## 3. Prepare the connection in your app

1. Open your existing **ohana-link** folder in VS Code.
2. Check that **.gitignore** includes `.env*`. Keep its other entries.
3. Start Claude Code in that project and paste the following prompt into Claude's message area.

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

4. Review Claude's proposed changes and installation commands before approving them.
5. Open **.env.local** in the same folder as **package.json**. Add or update these two entries with the values from your own Supabase project. Preserve other settings in the file.

   ```dotenv
   NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
   NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=your-publishable-key
   ```

The publishable key is intended for use in an app, including its browser code. Data access is controlled by database permissions and RLS policies. A secret key or database password must stay private.

## 4. Check the setup

1. Review the new or updated Supabase connection files in VS Code. File names can differ between projects.
2. Confirm that **.env.local** contains your project's URL and publishable key instead of placeholders.
3. In a regular terminal inside your project, run:

   ```text
   git check-ignore .env.local
   git ls-files .env.local
   ```

   The first command should print `.env.local`. The second should print nothing. If either result is different, use [Setup help](HELP.md#files-that-should-not-be-uploaded) before publishing.

4. Stop the development server with **Control+C** and restart it with `npm.cmd run dev` on Windows or `npm run dev` on Mac. Open the Local address and check for setup errors.

**Prepared for the database lesson:** Your Supabase project exists, the connection files and settings are in place, and the app starts. This is not yet a database read or write test.

Continue with the lesson to create the tables and access policies. Then save a test item in the app, confirm it appears in Supabase, and reload the app to confirm it is read back. That is the final connection check.

[Need help?](HELP.md) · [Official Next.js connection guide](https://supabase.com/docs/guides/getting-started/quickstarts/nextjs) · [Supabase API keys](https://supabase.com/docs/guides/getting-started/api-keys)
