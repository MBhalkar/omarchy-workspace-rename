import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Ui

Overlay {
  id: root
  moduleName: "omarchy.workspace-rename"

  property int workspaceId: -1
  property string currentName: ""
  readonly property string stateFile: Quickshell.env("HOME") + "/.local/share/omarchy-workspace-rename/workspace-names.json"
  readonly property string scriptPath: Qt.resolvedUrl("omarchy-workspace-rename").toString().replace(/^file:\/\//, "")

  function loadCurrentName() {
    if (workspaceId < 0) return ""
    if (stateFileView.text() === "") return ""
    try {
      var data = JSON.parse(stateFileView.text())
      return data[String(workspaceId)] || ""
    } catch (e) {
      return ""
    }
  }

  function saveName(name) {
    if (workspaceId < 0) return
    saveProcess.command = [scriptPath, String(workspaceId), name]
    saveProcess.running = true
  }

  function resetName() {
    if (workspaceId < 0) return
    resetProcess.command = [scriptPath, "--reset", String(workspaceId)]
    resetProcess.running = true
  }

  visible: false
  mask: Rectangle {
    anchors.fill: parent
    color: "transparent"
  }

  onVisibleChanged: {
    if (visible) {
      // Get workspace ID from bar widget
      var barWidget = shell.findWidget("omarchy.workspace-rename")
      if (barWidget && barWidget.renamingWorkspaceId > 0) {
        workspaceId = barWidget.renamingWorkspaceId
        currentName = loadCurrentName()
        textField.text = currentName
        textField.forceActiveFocus()
      }
    }
  }

  FileView {
    id: stateFileView
    path: root.stateFile
    watchChanges: true
    atomicWrites: true
    printErrors: false
  }

  Process {
    id: saveProcess
    command: []
    onExited: function(exitCode) {
      if (exitCode === 0) {
        root.visible = false
      }
    }
  }

  Process {
    id: resetProcess
    command: []
    onExited: function(exitCode) {
      if (exitCode === 0) {
        root.visible = false
      }
    }
  }

  MouseArea {
    anchors.fill: parent
    onClicked: root.visible = false
  }

  Rectangle {
    id: panel
    anchors.centerIn: parent
    width: 400
    height: 150
    color: Color.bg.base
    border.color: Color.border.base
    border.width: 1
    radius: Style.radius

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: Style.space(2)
      spacing: Style.space(2)

      Text {
        Layout.fillWidth: true
        text: "Rename Workspace " + root.workspaceId
        font.pixelSize: Style.fontSize(1.2)
        font.weight: Font.Bold
        color: Color.text.base
        horizontalAlignment: Text.AlignHCenter
      }

      TextField {
        id: textField
        Layout.fillWidth: true
        Layout.preferredHeight: 40
        placeholderText: "Enter workspace name (no spaces)"
        font.pixelSize: Style.fontSize(1)
        color: Color.text.base
        background: Rectangle {
          color: Color.bg.hover
          border.color: textField.activeFocus ? Color.accent.base : Color.border.base
          border.width: 1
          radius: Style.radius
        }

        Keys.onReturnPressed: {
          if (text.trim() !== "") {
            root.saveName(text.trim().replace(/\s+/g, "_"))
          }
        }

        Keys.onEscapePressed: {
          root.visible = false
        }
      }

      RowLayout {
        Layout.fillWidth: true
        spacing: Style.space(1)

        Button {
          Layout.fillWidth: true
          text: "Save"
          enabled: textField.text.trim() !== ""
          onClicked: {
            if (textField.text.trim() !== "") {
              root.saveName(textField.text.trim().replace(/\s+/g, "_"))
            }
          }

          background: Rectangle {
            color: parent.enabled ? (parent.pressed ? Color.accent.hover : Color.accent.base) : Color.bg.hover
            radius: Style.radius
          }

          contentItem: Text {
            text: parent.text
            font.pixelSize: Style.fontSize(1)
            color: parent.enabled ? Color.text.base : Color.text.disabled
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
          }
        }

        Button {
          Layout.fillWidth: true
          text: "Reset"
          onClicked: root.resetName()

          background: Rectangle {
            color: parent.pressed ? Color.bg.hover : Color.bg.base
            border.color: Color.border.base
            border.width: 1
            radius: Style.radius
          }

          contentItem: Text {
            text: parent.text
            font.pixelSize: Style.fontSize(1)
            color: Color.text.base
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
          }
        }

        Button {
          Layout.fillWidth: true
          text: "Cancel"
          onClicked: root.visible = false

          background: Rectangle {
            color: parent.pressed ? Color.bg.hover : Color.bg.base
            border.color: Color.border.base
            border.width: 1
            radius: Style.radius
          }

          contentItem: Text {
            text: parent.text
            font.pixelSize: Style.fontSize(1)
            color: Color.text.base
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
          }
        }
      }
    }
  }
}
