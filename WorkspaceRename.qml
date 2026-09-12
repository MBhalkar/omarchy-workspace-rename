import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "omarchy.workspace-rename"

  property var workspaceNames: ({})
  property int renamingWorkspaceId: -1
  readonly property string stateFile: Quickshell.env("HOME") + "/.local/share/omarchy-workspace-rename/workspace-names.json"
  readonly property string scriptPath: Qt.resolvedUrl("omarchy-workspace-rename").toString().replace(/^file:\/\//, "")

  function workspaceById(id) {
    var values = Hyprland.workspaces.values
    for (var i = 0; i < values.length; i++) {
      if (values[i].id === id) return values[i]
    }
    return null
  }

  function workspaceIds() {
    var ids = [1, 2, 3, 4, 5]
    var values = Hyprland.workspaces.values

    for (var i = 0; i < values.length; i++) {
      var id = values[i].id
      if (id > 0 && id <= 10 && ids.indexOf(id) === -1) ids.push(id)
    }

    ids.sort(function(left, right) { return left - right })
    return ids
  }

  function focusWorkspace(id) {
    if (!root.bar) return
    root.bar.run("hyprctl dispatch workspace " + id)
  }

  function workspaceLabel(id) {
    var customName = workspaceNames[String(id)]
    if (customName) {
      return id + "_" + customName
    }
    return String(id)
  }

  function loadWorkspaceNames() {
    if (stateFileView.text() === "") return
    try {
      var data = JSON.parse(stateFileView.text())
      workspaceNames = data || {}
    } catch (e) {
      workspaceNames = {}
    }
  }

  function showRenamePanel(workspaceId) {
    renamingWorkspaceId = workspaceId
    if (root.bar && root.bar.shell) {
      root.bar.shell.showOverlay("omarchy.workspace-rename", true)
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
    path: root.stateFile
    watchChanges: true
    atomicWrites: true
    printErrors: false
    onLoaded: root.loadWorkspaceNames()
    onFileChanged: reload()
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
        readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === modelData

        bar: root.bar
        text: root.workspaceLabel(modelData)
        active: focused
        opacity: occupied || focused ? 1 : 0.5
        horizontalMargin: 6
        verticalPadding: 6
        fixedWidth: root.vertical ? root.barSize : -1
        fixedHeight: root.barSize
        
        onPressed: function() { 
          root.showRenamePanel(modelData)
        }
      }
    }
  }
}
