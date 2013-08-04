import bb.cascades 1.0

Container {
    id: self
    signal deleteClicked
    minHeight: 55
    property string name: "Fulano"
    property bool selected: false
    layout: StackLayout {
        orientation: LayoutOrientation.LeftToRight
    }
    background: bg.imagePaint
    leftMargin: 10
    leftPadding: 10
    rightPadding: selected ? 0 : 10
    Container {
        verticalAlignment: VerticalAlignment.Center
        Label {
            text: name
            textStyle.base: SystemDefaults.TextStyles.SubtitleText
            textStyle.color: Color.create("#262626")
        }
    }
    ImageView {
        visible: selected
        horizontalAlignment: HorizontalAlignment.Right
        verticalAlignment: VerticalAlignment.Center
        imageSource: "asset:///images/delete.png"
        gestureHandlers: TapHandler {
            onTapped: {
                self.deleteClicked()
                console.log("delete item!")
            }
        }
    }
    attachedObjects: ImagePaintDefinition {
        id: bg
        imageSource: "asset:///images/participant.amd"
    }
}