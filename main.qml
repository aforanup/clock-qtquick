import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: iWindow
    visible: true
    width: 400
    height: 450
    title: "Clock"

    x: screen.desktopAvailableWidth - width - 5
    y: screen.desktopAvailableHeight - height - 5
    flags: Qt.Window 
    // | Qt.WindowStaysOnTopHint
    | Qt.FramelessWindowHint
    // | Qt.WindowSystemMenuHint

    property string currTime: "00:00:00"
    property var hms: {"hours":0, "minutes": 0, "seconds": 0}
    property QtObject backend
    // property bool held: false

    color: "transparent"

    Connections {
        target: backend

        function onUpdated(msg) {
            currTime = msg;
        }

        function onHms(hours, minutes, seconds) {
            hms={
                "hours": hours,
                "minutes": minutes,
                "seconds": seconds
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        id: mouseRegion
        // acceptedButtons: Qt.RightButton
        // | Qt.LeftButton
        onClicked: {
            console.log("button clicked")
            acceptedButtons: QtRightButton
            }
        // hoverEnabled: true
        // onPressAndHold: held = true
        // onEntered: console.log("mouse entered the area")
        // onExited: console.log("mouse left the area")

        property variant clickPos: "1,1"

        onPressed: {
            clickPos  = Qt.point(mouse.x,mouse.y)
        }

        onPositionChanged: {
            // var windowPos = {x: iWindow.x-clickPos.x, y: iWindow.y-clickPos.y}
            // var delta = Qt.point(iWindow.x-mouse.x, iWindow.y-mouse.y)
            var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
            iWindow.x += delta.x;
            iWindow.y += delta.y;
        }
        // onPressAndHold:  clickPos = { x: mouse.x, y: mouse.y }

        // onPositionChanged: {
        //     // var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
        //     var delta = {x: mouse.x-clickPos.x, y: mouse.y-clickPos.y}
        //     iWindow.x += delta.x;
        //     iWindow.y += delta.y;
        //     // iWindow.x = mouse.x - clickPos.x
        //     // iWindow.y = mouse.y - clickPos.y
        // }
    }

        Image {
            id: clockface
            sourceSize.width: parent.width
            fillMode: Image.PreserveAspectFit
            source: "./images/clockface.png"

            Image {
                x: clockface.width/2 - width/2
                y: (clockface.height/2) - height/2
                scale: clockface.width/500
                source: "./images/hour.png"
                transform: Rotation {
                    origin.x:12.5;
                    origin.y:166;
                    angle: (hms.hours * 30) + (hms.minutes * 0.5)
                }
            }

            Image {
                x: clockface.width/2 - width/2
                y: (clockface.height/2) - height/2
                scale: clockface.width/500
                source: "./images/minute.png"
                transform: Rotation {
                    origin.x:5.5;
                    origin.y:201;
                    angle: hms.minutes * 6
                    Behavior on angle {
                        SpringAnimation {
                            spring:1;
                            damping:0.2;
                            modulus:360
                        }
                    }
                }
            }

            Image {
                x: clockface.width/2 - width/2
                y: (clockface.height/2) - height/2
                scale: clockface.width/500
                source: "./images/second.png"
                transform: Rotation {
                    origin.x:2;
                    origin.y:202;
                    angle: hms.seconds * 6
                    Behavior on angle {
                        SpringAnimation {
                            spring:3;
                            damping:0.2;
                            modulus:360
                        }
                    }
                }
            }

            Image {
                x: clockface.width/2 - width/2
                y: (clockface.height/2) - height/2
                scale: clockface.width/400
                source: "./images/cap.png"
            }
        }

        Rectangle {
            anchors.bottom : parent.bottom 
            color: "red"

            Text {

                anchors {
                    bottom: parent.bottom
                    bottomMargin: 12
                    left: parent.left
                    leftMargin: 50
                }
                
                text: currTime
                font.pixelSize: 24
                color: "white"
            }
        }
}