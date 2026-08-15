import QtQuick
import Quickshell
import Quickshell.Io
import qs.Ui

BarWidget {
    id: root
    moduleName: "omarchy.monitor"

    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    Process {
        id: hyprmoncfgProc
        command: ["xdg-terminal-exec", "--app-id=TUI.float", "-e", "hyprmoncfg"]
    }

    BarIconButton {
        id: button
        anchors.fill: parent
        bar: root.bar
        text: Quickshell.screens.length > 1 ? "󰍺" : "󰍹"
        tooltipText: "Monitor settings"
        onPressed: function (b) {
            hyprmoncfgProc.running = true;
        }
    }
}
