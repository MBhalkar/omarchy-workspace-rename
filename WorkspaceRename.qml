import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "mbhalkar.workspace-rename"

  property var workspaceNames: ({})
  property int renamingWorkspaceId: 0

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
    root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
  }

  function workspaceLabel(id) {
    var customName = workspaceNames[String(id)]
    if (customName) {
      return customName
    }
    return String(id)
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
    renamingWorkspaceId = wsId
    renameInput.text = workspaceNames[String(wsId)] || ""
    renamePopup.open = true
    Qt.callLater(function() { renameInput.forceActiveFocus() })
  }

  function closeRenamePopup() {
    renamePopup.open = false
    renamingWorkspaceId = 0
  }

  function saveWorkspaceName() {
    var wsId = renamingWorkspaceId
    var newName = renameInput.text.trim()

    closeRenamePopup()

    if (wsId <= 0) return
    if (newName === "" || newName.indexOf(" ") !== -1) return

    root.bar.run("omarchy-workspace-rename " + wsId + " " + Util.shellQuote(newName))
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

  PopupCard {
    id: renamePopup
    anchorItem: root
    bar: root.bar
    open: false
    contentWidth: renameContent.implicitWidth + 32
    contentHeight: renameContent.implicitHeight + 24
    triggerMode: "click"

    anchor {
      adjustment: PopupAdjustment.Slide
      edges: Edges.Top | Edges.Left
      gravity: Edges.Bottom | Edges.Right
      rect.width: 1
      rect.height: 1

      onAnchoring: {
        if (!root.bar) return
        var popupWidth = renamePopup.contentWidth
        var popupHeight = renamePopup.contentHeight
        var cx = 0
        var cy = 0

        if (root.bar.position === "top" || root.bar.position === "bottom") {
          cx = root.width / 2 - popupWidth / 2
          cy = root.bar.position === "top" ? root.height + 6 : -popupHeight - 6
          cx = Math.max(6, Math.min(cx, root.width - popupWidth - 6))
        } else {
          cx = root.bar.position === "left" ? root.width + 6 : -popupWidth - 6
          cy = root.height / 2 - popupHeight / 2
          cy = Math.max(6, Math.min(cy, root.height - popupHeight - 6))
        }

        popupAnchor.rect.x = Math.round(cx)
        popupAnchor.rect.y = Math.round(cy)
      }
    }

    Column {
      id: renameContent
      anchors.centerIn: parent
      spacing: 6

      Text {
        text: "Rename Workspace " + root.renamingWorkspaceId
        color: Color.foreground
        font.family: Style.font.family
        font.pixelSize: Style.font.body
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
      }

      TextField {
        id: renameInput
        width: Style.space(160)
        placeholderText: "Enter name\u2026"
        Keys.onReturnPressed: root.saveWorkspaceName()
        Keys.onEnterPressed: root.saveWorkspaceName()
        Keys.onEscapePressed: root.closeRenamePopup()
      }
    }
  }
}
