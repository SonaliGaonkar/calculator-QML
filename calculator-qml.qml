import CalculatorStateMachine 1.0
import QtQuick 2.5
import QtQuick.Window 2.0
import QtScxml 5.8
//import QtGraphicalEffects 1.12

Window {
    id: window
    height: 500
    width: 500
    visible: true
    color: "#7e7e7e"

    CalculatorStateMachine {
        id: statemachine
        running: true
        EventConnection {
            events: ["updateDisplay"]
            onOccurred: resultText.text = event.data.display
        }
    }

    Rectangle {
        id: resultArea
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: parent.height * 3 / 8 - 10
        border.color: "#7e7e7e"
        border.width: 9
        radius:50
        gradient: Gradient{
        GradientStop{position: 0.0; color:"white"}
        GradientStop{position: 0.60; color: "black"}
        }


        Text {
            id: resultText
            anchors.fill: parent
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            anchors.rightMargin: 34
            anchors.bottomMargin: 35
            anchors.leftMargin: -34
            anchors.topMargin: -35
            text: "0"
            color: "white"
            font.pixelSize: window.height * 3 / 32
            font.family: "Open Sans Regular"
            fontSizeMode: Text.Fit

        }
    }

    Item {
        id: buttons
        anchors.top: resultArea.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom


        property real implicitMargin: {
            var ret = 0;
            for (var i = 0; i < visibleChildren.length; ++i) {
                var child = visibleChildren[i];
                ret += (child.implicitMargin || 0);
            }
            return ret / visibleChildren.length;
        }

        Repeater {
            id: operations
            model: ["÷", "×", "+", "-"]
            Button {
                y: 0
                x: index * width
                width: parent.width / 4
                height: parent.height / 5

                gradient: Gradient{
                GradientStop{position: 0.0; color:"white"}
                GradientStop{position: 0.60; color: "black"}
                }


                text: modelData


                fontHeight: 0.4

                onClicked: statemachine.submitEvent(eventName)
                property string eventName: {
                    switch (text) {
                    case "÷": return "OPER.DIV"
                    case "×": return "OPER.STAR"
                    case "+": return "OPER.PLUS"
                    case "-": return "OPER.MINUS"
                    }
                }
            }
        }

        Repeater {
            id: digits
            model: ["7", "8", "9", "4", "5", "6", "1", "2", "3", "0", ".", "C"]
            Button {
                x: (index % 3) * width
                y: Math.floor(index / 3 + 1) * height
                width: parent.width / 4
                height: parent.height / 5

                gradient: Gradient{
                GradientStop{position: 0.0; color:"white"}
                GradientStop{position: 0.60; color: "black"}
                }

                text: modelData
                onClicked: statemachine.submitEvent(eventName)
                property string eventName: {
                    switch (text) {
                    case ".": return "POINT"
                    case "C": return "C"
                    default: return "DIGIT." + text
                    }
                }
            }
        }

        Button {
            id: resultButton
            x: 3 * width
            y: parent.height / 5

            textHeight: y - 2
            fontHeight: 0.4
            width: parent.width / 4
            height: y * 4


            text: "="

            onClicked: statemachine.submitEvent("EQUALS")

            gradient: Gradient{
            GradientStop{position: 0.0; color:"white"}
            GradientStop{position: 0.2; color: "black"}
            }
            }
        }
}






/*##^##
Designer {
    D{i:0;formeditorZoom:3}D{i:1}D{i:4}D{i:3}D{i:7}D{i:6}D{i:9}D{i:8}D{i:10}D{i:5}
}
##^##*/
