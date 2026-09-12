import QtQuick
import QtQuick.Controls
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
  property bool showingRenamePanel: false
  property int renamingWorkspaceId: -1
  property string currentRenamingName: ""
  readonly property string stateFile: Quickshell.env("HOME") + "/.local/share/omarchy-workspace-rename/workspace-names.json"
  readonly property string scriptPath: Quickshell.env("HOME") + "/.local/bin/omarchy-workspace-rename"

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

  function openRenamePanel(workspaceId) {
    renamingWorkspaceId = workspaceId
    currentRenamingName = workspaceNames[String(workspaceId)] || ""
    showingRenamePanel = true
  }

  function saveName(name) {
    if (renamingWorkspaceId < 0) return
    
    var cleanName = name.trim().replace(/\s+/g, "_")
    if (cleanName === "") {
      showingRenamePanel = false
      renamingWorkspaceId = -1
      return
    }
    
    if (cleanName.length > 30) {
      cleanName = cleanName.substring(0, 30)
    }
    
    if (root.bar) {
      root.bar.run(scriptPath + " " + renamingWorkspaceId + " " + cleanName)
    }
    
    showingRenamePanel = false
    renamingWorkspaceId = -1
  }

  function resetName() {
    if (renamingWorkspaceId < 0) return
    
    if (root.bar) {
      root.bar.run(scriptPath + " --reset " + renamingWorkspaceId)
    }
    
    showingRenamePanel = false
    renamingWorkspaceId = -1
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

      Item {
        required property int modelData
        
        Layout.fillWidth: root.vertical
        Layout.fillHeight: !root.vertical
        implicitWidth: wsButton.implicitWidth
        implicitHeight: wsButton.implicitHeight

        readonly property var workspace: root.workspaceById(modelData)
        readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
        readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === modelData

        WidgetButton {
          id: wsButton
          anchors.fill: parent
          
          bar: root.bar
          text: root.workspaceLabel(parent.modelData)
          active: parent.focused
          opacity: parent.occupied || parent.focused ? 1 : 0.5
          horizontalMargin: 6
          verticalPadding: 6
          fixedWidth: root.vertical ? root.barSize : -1
          fixedHeight: root.barSize
          
          // Left click = switch workspace (default behavior)
          onPressed: function() { 
            root.focusWorkspace(parent.modelData)
          }
        }
        
        // Right click handler on top
        MouseArea {
          anchors.fill: parent
          acceptedButtons: Qt.RightButton
          onClicked: function(mouse) {
            if (mouse.button === Qt.RightButton) {
              root.openRenamePanel(parent.modelData)
            }
          }
        }
      }
    }
  }

  // Rename panel overlay
  Item {
    visible: root.showingRenamePanel
    anchors.fill: parent
    z: 1000

    MouseArea {
      anchors.fill: parent
      onClicked: root.showingRenamePanel = false
    }

    Rectangle {
      id: renamePanel
      x: 10
      y: root.barSize + 5
      width: 350
      height: 140
      color: "#2e3440"
      border.color: "#4c566a"
      border.width: 2
      radius: 8

      MouseArea {
        anchors.fill: parent
        onClicked: {}
      }

      ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        Text {
          Layout.fillWidth: true
          text: "Rename Workspace " + root.renamingWorkspaceId
          font.pixelSize: 16
          font.weight: Font.Bold
          color: "#eceff4"
          horizontalAlignment: Text.AlignHCenter
        }

        TextField {
          id: nameField
          Layout.fillWidth: true
          implicitHeight: 36
          placeholderText: "Enter name (spaces → underscores)"
          font.pixelSize: 14
          color: "#eceff4"
          text: root.currentRenamingName
          
          background: Rectangle {
            color: "#3b4252"
            border.color: nameField.activeFocus ? "#88c0d0" : "#4c566a"
            border.width: 1
            radius: 4
          }
          
          Keys.onReturnPressed: {
            root.saveName(text)
          }
          
          Keys.onEscapePressed: {
            root.showingRenamePanel = false
          }
          
          Component.onCompleted: {
            forceActiveFocus()
          }
        }

        RowLayout {
          Layout.fillWidth: true
          spacing: 8

          Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 32
            color: saveButton.pressed ? "#4c7a9e" : "#5e81ac"
            opacity: nameField.text.trim().length > 0 ? 1 : 0.5
            radius: 4
            
            Text {
              anchors.centerIn: parent
              text: "Save"
              font.pixelSize: 13
              color: "#eceff4"
            }
            
            MouseArea {
              id: saveButton
              anchors.fill: parent
              enabled: nameField.text.trim().length > 0
              onClicked: root.saveName(nameField.text)
            }
          }

          Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 32
            color: resetButton.pressed ? "#3b4252" : "#4c566a"
            radius: 4
            
            Text {
              anchors.centerIn: parent
              text: "Reset"
              font.pixelSize: 13
              color: "#eceff4"
            }
            
            MouseArea {
              id: resetButton
              anchors.fill: parent
              onClicked: root.resetName()
            }
          }

          Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 32
            color: cancelButton.pressed ? "#3b4252" : "#4c566a"
            radius: 4
            
            Text {
              anchors.centerIn: parent
              text: "Cancel"
              font.pixelSize: 13
              color: "#eceff4"
            }
            
            MouseArea {
              id: cancelButton
              anchors.fill: parent
              onClicked: root.showingRenamePanel = false
            }
          }
        }
      }
    }
  }
}
