'use strict';
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { test, after } = require('node:test');
const helper = require('./create-next-app.cjs');
const root = fs.mkdtempSync(path.join(os.tmpdir(), 'itm325-nextjs-test-'));
function folder(name) {
  const result = path.join(root, name, 'webdev');
  fs.mkdirSync(result, { recursive: true });
  return fs.realpathSync(result);
}
function writeApp(course) {
  const target = path.join(course, 'ohana-link');
  fs.mkdirSync(target);
  fs.writeFileSync(path.join(target, 'package.json'), JSON.stringify({ dependencies: { next: '16.0.0' }, scripts: { dev: 'next dev' } }));
  return target;
}
after(() => {
  const resolved = path.resolve(root);
  const parent = path.resolve(os.tmpdir());
  assert.equal(path.dirname(resolved), parent);
  assert.ok(path.basename(resolved).startsWith('itm325-nextjs-test-'));
  fs.rmSync(resolved, { recursive: true, force: true });
});

test('finds current course ancestor and separate home folder without duplicates', () => {
  const first = folder('current');
  const second = folder('home');
  const nested = path.join(first, 'earlier-project');
  fs.mkdirSync(nested);
  const actual = helper.findFolders({ cwd: nested, home: path.dirname(second), env: {}, platform: 'darwin' });
  assert.deepEqual(actual, [first, second]);
  assert.deepEqual(helper.findFolders({ cwd: first, home: path.dirname(first), env: {}, platform: 'darwin' }), [first]);
});
test('does not create a webdev folder when none is found', () => {
  const absent = path.join(root, 'absent');
  assert.deepEqual(helper.findFolders({ cwd: absent, home: absent, env: {}, platform: 'darwin' }), []);
  assert.equal(fs.existsSync(absent), false);
});
test('supports explicit choice, pasted quoted paths, and cancellation', () => {
  const first = folder('choice one');
  const second = folder('choice two');
  assert.equal(helper.chooseFolder('2', [first, second]), second);
  assert.equal(helper.chooseFolder('"' + first + '"', []), first);
  assert.equal(helper.chooseFolder("'" + first + "'", []), first);
  assert.equal(helper.chooseFolder('Q', [first]), null);
  assert.equal(helper.chooseFolder('', [first]), null);
  assert.throws(() => helper.chooseFolder('3', [first, second]));
  assert.throws(() => helper.chooseFolder('relative/webdev', []));
});
test('accepts home-relative Mac paths and rejects a project instead of webdev', () => {
  const course = folder('tilde');
  assert.equal(helper.courseFolder('~/webdev', path.dirname(course)), course);
  fs.mkdirSync(path.join(course, 'project'));
  assert.throws(() => helper.courseFolder(path.join(course, 'project')));
});
test('keeps an existing Next.js app and its files', () => {
  const course = folder('existing');
  const target = writeApp(course);
  fs.writeFileSync(path.join(target, 'student-work.txt'), 'KEEP THIS');
  assert.equal(helper.appState(course), 'existing');
  assert.throws(() => helper.createApp(course, () => { throw new Error('Must not run'); }));
  assert.equal(fs.readFileSync(path.join(target, 'student-work.txt'), 'utf8'), 'KEEP THIS');
  const lines = [];
  helper.showResult(course, line => lines.push(line), 'win32');
  assert.ok(lines.includes('\nAPP FOLDER: ' + target));
  assert.ok(lines.includes('Run: npm.cmd run dev'));
});
test('protects incomplete folders, malformed package files, and conflicting files', () => {
  for (const kind of ['empty', 'invalid', 'file']) {
    const course = folder('conflict-' + kind);
    const target = path.join(course, 'ohana-link');
    if (kind === 'file') fs.writeFileSync(target, 'KEEP');
    else {
      fs.mkdirSync(target);
      if (kind === 'invalid') fs.writeFileSync(path.join(target, 'package.json'), '{broken');
    }
    assert.equal(helper.appState(course), 'conflict');
    assert.throws(() => helper.createApp(course, () => { throw new Error('Must not run'); }));
    assert.ok(fs.existsSync(target));
  }
});
test('runs app creation in the chosen folder with fixed arguments on both operating systems', () => {
  for (const platform of ['win32', 'darwin']) {
    const course = folder('new-' + platform + ' spaces & apostrophe\'');
    let calls = 0;
    helper.createApp(course, (command, args, options) => {
      calls++;
      assert.equal(command, platform === 'win32' ? 'npx.cmd' : 'npx');
      assert.deepEqual(args, ['create-next-app@latest', 'ohana-link', '--use-npm']);
      assert.equal(options.cwd, course);
      assert.equal(options.shell, platform === 'win32');
      writeApp(course);
      return { status: 0 };
    }, platform);
    assert.equal(calls, 1);
    assert.equal(helper.appState(course), 'existing');
  }
});
test('reports generator failures and preserves partial work', () => {
  const course = folder('failed');
  assert.throws(() => helper.createApp(course, () => {
    fs.mkdirSync(path.join(course, 'ohana-link'));
    fs.writeFileSync(path.join(course, 'ohana-link', 'partial.txt'), 'KEEP');
    return { status: 1 };
  }));
  assert.equal(fs.readFileSync(path.join(course, 'ohana-link', 'partial.txt'), 'utf8'), 'KEEP');
  const noCommand = folder('no-command');
  assert.throws(() => helper.createApp(noCommand, () => ({ error: new Error('ENOENT') })));
});
test('does not report success if the generator failed to produce an app', () => {
  const course = folder('no-app');
  assert.throws(() => helper.createApp(course, () => ({ status: 0 })));
});
