const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const os = require('node:os');
const path = require('node:path');
const {execFileSync} = require('node:child_process');
const source = fs.readFileSync(path.join(__dirname, '../BarWidget.qml'), 'utf8');
const root = {slots: 10, block: 1, monitorName: 'HDMI-A-1', workspaceNames: {1: 'code', 11: 'drawing'}};
const Hyprland = {workspaces: {values: [
  {id: 1, monitor: {name: 'DP-2'}},
  {id: 11, monitor: {name: 'HDMI-A-1'}},
  {id: 19, monitor: {name: 'HDMI-A-1'}},
  {id: 31, monitor: {name: 'DP-1'}},
  {id: 34, monitor: {name: 'HDMI-A-1'}},
  {id: -99, monitor: {name: 'HDMI-A-1'}},
]}};
// Execute the actual QML JavaScript helpers against monitor/workspace fixtures.
const context = vm.createContext({root, Hyprland});
for (const name of ['readBlocks', 'blockOf', 'slotOf', 'activeWorkspaceId', 'workspaceById', 'workspaceIds', 'focusWorkspace', 'workspaceLabel']) {
  const match = source.match(new RegExp('  function ' + name + '\\([^]*?\\n  }'));
  assert.ok(match, name);
  vm.runInContext(match[0], context);
  root[name] = context[name];
}
const ids = () => Array.from(root.workspaceIds());
assert.deepEqual(ids(), [11, 12, 13, 14, 15, 19, 34]);
root.monitor = {activeWorkspace: {id: 11}};
assert.equal(root.activeWorkspaceId(), 11);
assert.equal(root.workspaceLabel(11), 'drawing');
assert.equal(root.workspaceLabel(1), 'code');
assert.equal(root.workspaceLabel(19), '9');
assert.equal(root.workspaceLabel(20), '0');
root.readBlocks('0\tDP-2\tAcer\n1\tHDMI-A-1\tTablet\n3\tDP-1\tDell\n');
assert.equal(root.blocks['DP-1'], 3);
assert.equal(root.blocks['HDMI-A-1'], 1);
const commands = [];
root.dispatch = expression => commands.push(expression);
root.focusWorkspace(12);
root.focusWorkspace(34);
assert.deepEqual(commands, ['o.workspaces.focus(2, "HDMI-A-1")', 'hl.dsp.focus({ workspace = "34" })']);
root.block = 3;
root.monitorName = 'DP-1';
assert.deepEqual(ids(), [31, 32, 33, 34, 35]);
root.block = 0;
root.monitorName = 'DP-2';
assert.deepEqual(ids(), [1, 2, 3, 4, 5]);
// Exercise the actual submit handler: invalid input stays open, valid input
// passes argv directly to Process, and blank input resets only the selected ID.
const renameProcess = {running: false};
const renameInput = {text: 'bad name'};
context.renameProcess = renameProcess;
context.renameInput = renameInput;
context.Quickshell = {env: name => name === 'HOME' ? '/home/test' : ''};
context.renamingWorkspaceId = 31;
vm.runInContext(source.match(/  function saveWorkspaceName\([^]*?\n  }/)[0], context);
context.saveWorkspaceName();
assert.equal(renameProcess.running, false);
assert.match(context.renameError, /30 letters/);
renameInput.text = 'MF-agent';
context.saveWorkspaceName();
assert.equal(renameProcess.running, true);
assert.deepEqual(Array.from(renameProcess.command), ['/home/test/.config/omarchy/plugins/io.github.mbhalkar.workspace-rename/omarchy-workspace-rename', '31', 'MF-agent']);
renameProcess.running = false;
renameInput.text = '';
context.saveWorkspaceName();
assert.deepEqual(Array.from(renameProcess.command).slice(1), ['--reset', '31']);
// Test CLI persistence with an isolated config and fake compositor. Never reload the desktop.
const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'workspace-rename-test-'));
try {
  const config = path.join(tmp, 'hyprland.lua');
  fs.writeFileSync(config, '-- user config\n');
  fs.writeFileSync(path.join(tmp, 'hyprctl'), '#!/bin/sh\ntouch "$HYPRLAND_CONFIG.reloaded"\nexit 1\n', {mode: 0o755});
  const env = {...process.env, PATH: tmp + ':' + process.env.PATH, STATE_FILE: path.join(tmp, 'names.json'), HYPRLAND_CONFIG: config};
  const cli = (...args) => execFileSync(path.join(__dirname, '../omarchy-workspace-rename'), args, {env, stdio: 'pipe'});
  cli('1', 'code');
  cli('11', 'drawing');
  cli('31', 'chat');
  assert.deepEqual(JSON.parse(fs.readFileSync(env.STATE_FILE)), {1: 'code', 11: 'drawing', 31: 'chat'});
  cli('--reset', '11');
  assert.deepEqual(JSON.parse(fs.readFileSync(env.STATE_FILE)), {1: 'code', 31: 'chat'});
  for (const id of ['0', '-1', '01', '2147483648', '999999999999999999', 'abc']) {
    assert.throws(() => cli(id, 'invalid'));
  }
  assert.equal(fs.readFileSync(config, 'utf8'), '-- user config\n');
  assert.equal(fs.existsSync(config + '.reloaded'), false, 'rename must not reload Hyprland');
  assert.equal(fs.readdirSync(tmp).some(name => name.includes('.bak.')), false);
} finally {
  fs.rmSync(tmp, {recursive: true, force: true});
}
console.log('Multi-monitor workspace selection, labels, routing and CLI persistence passed.');
