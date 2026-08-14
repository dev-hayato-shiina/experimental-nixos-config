import Quickshell
import QtQuick

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 32
    color: "#ffffff"

    Text {
        anchors.centerIn: parent
        text: "Quickshell"
        color: "#000000"
        font.pixelSize: 14
    }
}
