import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "io.github.mbhalkar.workspace-rename"

  property var workspaceNames: ({})
  property int renamingWorkspaceId: 0
  property bool _skipNextClick: false

  // Every monitor has workspaces 1-10 of its own, which Hyprland numbers in a
  // block of ten per monitor: 1-10, 11-20, and so on (see
  // default/hypr/monitor-workspaces.lua). Each bar shows its own monitor's block,
  // numbered 1-10, and the one that monitor shows, whichever monitor has focus.
  readonly property int slots: 10

  readonly property var monitor: {
    var window = root.QsWindow.window
    var screen = window ? window.screen : null
    return screen ? Hyprland.monitorFor(screen) : Hyprland.focusedMonitor
  }
  readonly property string monitorName: root.monitor ? root.monitor.name : ""

  // Connector -> block, from the file Hyprland keeps them in.
  property var blocks: ({})

  function readBlocks(text) {
    var next = {}
    var lines = String(text || "").split("\n")
    for (var i = 0; i < lines.length; i++) {
      var fields = lines[i].split("\t")
      if (fields.length >= 3 && fields[1] !== "") next[fields[1]] = parseInt(fields[0], 10)
    }
    root.blocks = next
  }

  FileView {
    path: (Quickshell.env("XDG_STATE_HOME") || Quickshell.env("HOME") + "/.local/state") + "/omarchy/monitors/workspaces"
    watchChanges: true
    printErrors: false
    onFileChanged: reload()
    onLoaded: root.readBlocks(text())
    onLoadFailed: root.readBlocks("")
  }

  function blockOf(id) {
    return Math.floor((id - 1) / root.slots)
  }

  function slotOf(id) {
    return (id - 1) % root.slots + 1
  }

  function activeWorkspaceId() {
    return root.monitor && root.monitor.activeWorkspace ? root.monitor.activeWorkspace.id : -1
  }

  // Until Hyprland has written the file, the workspace a monitor shows is in
  // its own block.
  readonly property int block: {
    var block = root.blocks[root.monitorName]
    if (block !== undefined) return block
    var active = root.activeWorkspaceId()
    return active > 0 ? root.blockOf(active) : 0
  }

  function workspaceById(id) {
    var values = Hyprland.workspaces.values
    for (var i = 0; i < values.length; i++) {
      if (values[i].id === id) return values[i]
    }

    return null
  }

  // The first five of the monitor's own, and any of the rest that exist. After
  // them come workspaces that are only visiting: those of a monitor that is
  // unplugged, which had no room to join this one's.
  function workspaceIds() {
    var base = root.block * root.slots
    var ids = [base + 1, base + 2, base + 3, base + 4, base + 5]
    var guests = []
    var values = Hyprland.workspaces.values

    for (var i = 0; i < values.length; i++) {
      var id = values[i].id
      if (id <= 0) continue
      if (root.blockOf(id) === root.block) {
        if (ids.indexOf(id) === -1) ids.push(id)
      } else if (values[i].monitor && values[i].monitor.name === root.monitorName) {
        guests.push(id)
      }
    }

    ids.sort(function(left, right) { return left - right })
    guests.sort(function(left, right) { return left - right })
    return ids.concat(guests)
  }

  function dispatch(expression) {
    if (root.bar) root.bar.run("hyprctl dispatch " + Util.shellQuote(expression))
  }

  function focusWorkspace(id) {
    if (root.blockOf(id) === root.block) {
      root.dispatch("o.workspaces.focus(" + root.slotOf(id) + ", \"" + root.monitorName + "\")")
    } else {
      root.dispatch("hl.dsp.focus({ workspace = \"" + id + "\" })")
    }
  }

  function workspaceLabel(id) {
    var customName = root.workspaceNames[String(id)]
    if (customName) {
      return customName
    }
    var slot = root.slotOf(id)
    return slot === root.slots ? "0" : String(slot)
  }

  function loadWorkspaceNames() {
    try {
      var text = stateFileView.text()
      if (text === "" || text === null) {
        workspaceNames = {}
        return
      }
      var data = JSON.parse(text)
      workspaceNames = data || {}
    } catch (e) {
      workspaceNames = {}
    }
  }

  function openRenamePopup(wsId) {
    renameError = ""
    renamingWorkspaceId = wsId
    renameInput.text = workspaceNames[String(wsId)] || ""
    _skipNextClick = true
    renamePopup.open = true
    renameInput.forceActiveFocus()
  }

  function closeRenamePopup() {
    renamePopup.open = false
    renamingWorkspaceId = 0
  }

  property string renameError: ""

  function saveWorkspaceName() {
    if (renameProcess.running || renamingWorkspaceId <= 0) return
    var newName = renameInput.text.trim()
    if (newName !== "" && !/^[a-zA-Z0-9_-]{1,30}$/.test(newName)) {
      renameError = "Use up to 30 letters, numbers, underscores or hyphens."
      return
    }
    renameError = ""
    // Use the installed filesystem path, independent of Quickshell's qs: URLs.
    var script = Quickshell.env("HOME") + "/.config/omarchy/plugins/io.github.mbhalkar.workspace-rename/omarchy-workspace-rename"
    renameProcess.command = newName === ""
      ? [script, "--reset", String(renamingWorkspaceId)]
      : [script, String(renamingWorkspaceId), newName]
    renameProcess.running = true
  }

  Process {
    id: renameProcess
    property string errorOutput: ""
    onStarted: errorOutput = ""
    stderr: StdioCollector {
      onStreamFinished: renameProcess.errorOutput = text.trim()
    }
    onExited: function(exitCode, exitStatus) {
      if (exitCode === 0 && exitStatus === 0) {
        stateFileView.reload()
        root.closeRenamePopup()
      } else {
        root.renameError = errorOutput || "Rename failed (exit " + exitCode + ")."
        console.warn("WorkspaceRename submit:", root.renameError)
      }
    }
  }

  readonly property real trailingGap: root.vertical ? 0 : Style.spaceReal(1.5)

  implicitWidth: grid.implicitWidth + trailingGap
  implicitHeight: grid.implicitHeight

  Component.onCompleted: {
    loadWorkspaceNames()
  }

  FileView {
    id: stateFileView
    path: Quickshell.env("HOME") + "/.local/share/omarchy-workspace-rename/workspace-names.json"
    watchChanges: true
    atomicWrites: true
    printErrors: false
    onLoaded: root.loadWorkspaceNames()
    onFileChanged: reload()
  }

  Connections {
    target: root.monitor
    function onActiveWorkspaceChanged() {
      if (renamePopup.open && !renameProcess.running) root.closeRenamePopup()
    }
  }

  Connections {
    target: Hyprland
    function onRawEvent(event) {
      var name = event ? String(event.name) : ""
      var switched = name === "workspacev2" && root.monitor !== null && root.monitor.focused
      if (switched || name === "moveworkspacev2" || name === "changeworkspaceid") {
        Hyprland.refreshMonitors()
        Hyprland.refreshWorkspaces()
      }
    }
  }

  GridLayout {
    id: grid
    anchors.fill: parent
    anchors.rightMargin: root.trailingGap
    columns: root.vertical ? 1 : root.workspaceIds().length
    columnSpacing: root.vertical ? 0 : Style.space(1)
    rowSpacing: root.vertical ? Style.space(2) : 0

    Repeater {
      model: root.workspaceIds()

      WidgetButton {
        required property int modelData

        readonly property var workspace: root.workspaceById(modelData)
        readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
        readonly property bool focused: root.activeWorkspaceId() === modelData

        bar: root.bar
        readonly property string customLabel: root.workspaceLabel(modelData)
        text: customLabel !== "" && customLabel !== null ? customLabel : (focused ? "󰻿" : String(modelData))
        active: focused
        opacity: occupied || focused ? 1 : 0.5
        horizontalMargin: 6
        verticalPadding: 6
        fixedWidth: customLabel !== "" && customLabel !== null ? (root.vertical ? root.barSize : -1) : (root.vertical ? root.barSize : Style.space(20))
        fixedHeight: root.barSize
        onPressed: function(button) {
          if (button === Qt.LeftButton && focused) {
            root.openRenamePopup(modelData)
          } else {
            root.focusWorkspace(modelData)
          }
        }
      }
    }
  }

  MouseArea {
    anchors.fill: parent
    visible: renamePopup.open
    z: 50
    onPressed: function(mouse) {
      if (root._skipNextClick) {
        root._skipNextClick = false
        mouse.accepted = false
        return
      }
      root.closeRenamePopup()
      mouse.accepted = true
    }
  }

  PopupCard {
    id: renamePopup
    anchorItem: root
    bar: root.bar
    open: false
    grabFocus: true
    contentWidth: renameContent.implicitWidth + 32
    contentHeight: renameContent.implicitHeight + 24
    triggerMode: "hover"

    Column {
      id: renameContent
      anchors.centerIn: parent
      spacing: 6

      Text {
        textFormat: Text.PlainText
        text: "Rename Workspace " + root.slotOf(root.renamingWorkspaceId)
        color: Color.foreground
        font.family: Style.font.family
        font.pixelSize: Style.font.body
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
      }

      TextField {
        id: renameInput
        width: Style.space(160)
        focus: true
        enabled: !renameProcess.running
        placeholderText: "Enter name\u2026"
        Keys.onReturnPressed: root.saveWorkspaceName()
        Keys.onEnterPressed: root.saveWorkspaceName()
        Keys.onEscapePressed: root.closeRenamePopup()
      }

      Text {
        visible: root.renameError !== ""
        textFormat: Text.PlainText
        text: root.renameError
        color: Color.foreground
        width: renameInput.width
        wrapMode: Text.Wrap
        font.pixelSize: Style.font.body
      }
    }
  }
}
