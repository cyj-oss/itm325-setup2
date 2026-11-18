'use strict';

const fs = require('node:fs');
const path = require('node:path');
const os = require('node:os');
const { spawnSync } = require('node:child_process');
const { createInterface } = require('node:readline/promises');

function courseFolder(value, home = os.homedir()) {
  let input = value.trim();
  if ((input.startsWith('"') && input.endsWith('"')) ||
      (input.startsWith("'") && input.endsWith("'"))) input = input.slice(1, -1);
  if (/^~[\\/]/.test(input)) input = path.join(home, input.slice(2));
  if (!path.isAbsolute(input)) throw new Error('Enter the full path to your existing webdev folder.');
  const normalized = path.resolve(input);
  if (path.basename(normalized).toLowerCase() !== 'webdev') {
    throw new Error('Choose the webdev folder, not a project inside it.');
  }
  if (!fs.statSync(normalized).isDirectory()) throw new Error('That path is not a folder.');
  return fs.realpathSync(normalized);
}

function findFolders({ cwd = process.cwd(), home = os.homedir(), env = process.env,
  platform = process.platform } = {}) {
  const guesses = [];
  let parent = path.resolve(cwd);
  while (true) {
    if (path.basename(parent).toLowerCase() === 'webdev') guesses.push(parent);
    const next = path.dirname(parent);
    if (next === parent) break;
    parent = next;
  }
  guesses.push(path.join(cwd, 'webdev'), path.join(home, 'webdev'),
    path.join(home, 'Desktop', 'webdev'), path.join(home, 'Documents', 'webdev'));
  if (platform === 'win32') {
    const root = (env.SystemDrive || 'C:') + '\\';
    guesses.push(path.join(root, 'webdev'), path.join(root, 'Users', 'webdev'));
    for (const key of ['OneDrive', 'OneDriveConsumer', 'OneDriveCommercial']) {
      if (env[key]) guesses.push(path.join(env[key], 'webdev'),
        path.join(env[key], 'Desktop', 'webdev'), path.join(env[key], 'Documents', 'webdev'));
    }
  }
  const found = [];
  const seen = new Set();
  for (const guess of guesses) {
    try {
      const folder = courseFolder(guess, home);
      const key = platform === 'win32' ? folder.toLowerCase() : folder;
      if (!seen.has(key)) { seen.add(key); found.push(folder); }
    } catch { /* Missing or inaccessible folders are not choices. */ }
  }
  return found;
}

function chooseFolder(answer, folders, home = os.homedir()) {
  const input = answer.trim();
  if (!input || /^q$/i.test(input)) return null;
  if (/^\d+$/.test(input)) {
    const selected = folders[Number(input) - 1];
    if (!selected) throw new Error('Choose one of the displayed numbers, or enter the full folder path.');
    return selected;
  }
  return courseFolder(input, home);
}

function appState(folder) {
  const target = path.join(folder, 'ohana-link');
  try { fs.lstatSync(target); }
  catch (error) { if (error.code === 'ENOENT') return 'missing'; throw error; }
  try {
    if (!fs.statSync(target).isDirectory()) return 'conflict';
    const pkg = JSON.parse(fs.readFileSync(path.join(target, 'package.json'), 'utf8').replace(/^\uFEFF/, ''));
    return (pkg.dependencies?.next || pkg.devDependencies?.next) && pkg.scripts?.dev ? 'existing' : 'conflict';
  } catch { return 'conflict'; }
}

function createApp(folder, runner = spawnSync, platform = process.platform) {
  // Never send an existing folder, even an empty or incomplete one, to the generator.
  if (appState(folder) !== 'missing') throw new Error('ohana-link already exists. Keep it and check the folder before continuing.');
  fs.accessSync(folder, fs.constants.W_OK);
  const windows = platform === 'win32';
  // Windows needs cmd for npx.cmd. Arguments are fixed; the selected path is passed as cwd, not shell code.
  const result = runner(windows ? 'npx.cmd' : 'npx',
    ['create-next-app@latest', 'ohana-link', '--use-npm'],
    { cwd: folder, stdio: 'inherit', shell: windows });
  if (result.error) throw new Error('npx could not start. Finish the Node.js setup and reopen your terminal.');
  if (result.status !== 0) throw new Error('App creation did not finish. Keep any files it created and review the error above before retrying.');
  if (appState(folder) !== 'existing') throw new Error('The expected Next.js app was not found. Keep the files and ask for help.');
}

function showResult(folder, log = console.log, platform = process.platform) {
  const target = fs.realpathSync(path.join(folder, 'ohana-link'));
  log('\nAPP FOLDER: ' + target);
  log('In VS Code, choose File > Open Folder and open this exact folder.');
  log('Then open Terminal > New Terminal.');
  log('Run: ' + (platform === 'win32' ? 'npm.cmd run dev' : 'npm run dev'));
  log('If dependencies are missing, follow Step 2 in the Next.js guide.');
  log('Open the Local address printed by the development server.');
}

async function main() {
  console.log('ITM 325 | Find your course folder and prepare Ohana Link');
  if (!['win32', 'darwin'].includes(process.platform)) throw new Error('Use this helper on Windows or Mac.');
  const folders = findFolders();
  console.log('\nExisting webdev folders:');
  folders.forEach((folder, index) => console.log(`${index + 1}. ${folder}`));
  if (!folders.length) console.log('No folder found in the usual locations.');
  console.log('Choose the folder containing your earlier course projects.');
  console.log('If it is not listed, paste its full path. No folders will be moved.');
  const prompt = createInterface({ input: process.stdin, output: process.stdout });
  let selected;
  let create = false;
  try {
    while (true) {
      const answer = await prompt.question('\nFolder number or full path (Enter or Q to stop): ');
      try { selected = chooseFolder(answer, folders); break; }
      catch (error) { console.log('Folder not selected: ' + error.message); }
    }
    if (!selected) { console.log('Stopped. No project changes were made.'); return; }
    const state = appState(selected);
    if (state === 'conflict') throw new Error('This webdev folder already contains ohana-link, but a complete Next.js app was not found there. Nothing was overwritten. Check that folder before continuing.');
    if (state === 'existing') {
      console.log('\nExisting Next.js app found. Keeping it without reinstalling.');
    } else {
      console.log('\nNew app location: ' + path.join(selected, 'ohana-link'));
      const answer = await prompt.question('Create the app here? Type Y to continue: ');
      create = /^y(es)?$/i.test(answer.trim());
      if (!create) { console.log('Stopped. No project changes were made.'); return; }
    }
  } finally { prompt.close(); }
  if (create) {
    console.log('\nIf prompted, approve create-next-app and choose the recommended Next.js defaults.');
    createApp(selected);
  }
  showResult(selected);
}

module.exports = { courseFolder, findFolders, chooseFolder, appState, createApp, showResult };
if (require.main === module) main().catch(error => {
  console.error('\nSETUP NEEDS ATTENTION\n' + error.message);
  console.error('Help: https://github.com/cyj-oss/itm325-setup2/blob/main/HELP.md');
  process.exitCode = 1;
});
