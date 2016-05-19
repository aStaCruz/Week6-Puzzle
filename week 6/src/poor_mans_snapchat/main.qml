import QtQuick 2.1
import QtQuick.Controls 1.0

// Comment out
import QtMultimedia 5.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Poor Man's Snapchat")
    property int xpos
    property int ypos

    Camera {
        id: cam_selfie
    }
    Rectangle {
        id: big_wrapper
        anchors.fill: parent
        Image {
            id: img_crayon
            source: "../../img/crayon.png"
            height: 50
            width: 50
            opacity: 1
            anchors.right: big_wrapper.right
            anchors.rightMargin: 20
            z: 4
            MouseArea {
                id: ma_mousearea_crayon
                anchors.fill: parent
                onPressed: {
                    img_crayon.opacity = 0.2
                }
                onReleased: {
                    img_crayon.opacity = 1
                }
                preventStealing: false
            }
        }
        VideoOutput {
            anchors.fill: parent
            source: cam_selfie
            anchors.bottomMargin: 50
            anchors.topMargin: 50
        }
        Image {
            id: img_text
            source: "../../img/text.png"
            height: 50
            width: 50
            opacity: 1
            anchors.right: img_crayon.left
            anchors.rightMargin: 20
            z: 4
            MouseArea {
                id: ma_mousearea_text
                anchors.fill: parent
                onPressed: {
                    img_text.opacity = 0.2
                }
                onReleased: {
                    img_text.opacity = 1
                }
                preventStealing: false
            }
        }
        Image {
            id: img_pen
            source: "../../img/pen.png"
            height: 50
            width: 50
            opacity: 1
            anchors.right: img_text.left
            anchors.rightMargin: 20
            z: 4
            MouseArea {
                id: ma_mousearea_pen
                anchors.fill: parent
                onPressed: {
                    if(img_pen.opacity === .2) {
                        img_pen.opacity = 1
                    }
                    else {
                        img_pen.opacity = 0.2}
                    canvas_canvas.visible = true
                }
                preventStealing: false
            }
        }
        Canvas {
            id: canvas_canvas
            anchors.fill: parent
            z: 3
            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = "black"
                ctx.lineCap = "round"
                ctx.fillRect(xpos-1, ypos-1, 10, 10)

            }
            MouseArea {
                anchors.fill: parent
                onPositionChanged: {
                    if(img_pen.opacity == .2) {
                        xpos = mouseX
                        ypos = mouseY
                    canvas_canvas.requestPaint()}
                }
            }
        }
        Image {
            id: img_camera
            source: "../../img/camera.png"
            height: 50
            width: 50
            opacity: 1
            z:5
            anchors.horizontalCenter: big_wrapper.horizontalCenter
            anchors.bottom: big_wrapper.bottom
            MouseArea {
                id: ma_mousearea
                anchors.fill: parent
                onPressed: {
                    img_camera.opacity = 0.2
                }
                onReleased: {
                    img_camera.opacity = 1
                }
                onClicked: {
                    se_shutter_camera.play()
                    cam_selfie.imageCapture.captureToLocation("derpy looking person")
                    cam_selfie.imageCapture.capture()
                }
                preventStealing: false
            }
        }
        Audio {
            id: se_shutter_camera
            source: "../../sound_effects/shutter_camera.mp3"
        }
    }
}
