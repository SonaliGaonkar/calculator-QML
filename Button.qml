import QtQuick 2.5
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.3
Rectangle {
    id: button


    signal clicked
    property alias text: text.text
    border.width: 9
    border.color: "#969696"
    opacity: enabled && !mouseArea.pressed ? 1: 0.2


    property real textHeight: height - 2
    property real fontHeight: 0.4
    property bool pressed: mouse.pressed
    property real implicitMargin: (width - text.implicitWidth) / 2
    radius: 60



    Text {
        id: text
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: parent.textHeight
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: height * fontHeight

        font.bold:true
        font.family: "Open Sans Regular"
       color : mouseArea.pressed ? "black" : "white"

    }



    MouseArea {
        id: mouseArea
        anchors.fill: parent


        onClicked: button.clicked()

    }
    }



