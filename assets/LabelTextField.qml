import bb.cascades 1.0

Container {
    id: self
    property alias label: textLabel.text
    property alias hintText: content.hintText
    property alias text: content.text
    property bool addButton: false
    property string titleButton: "" //"$"
    signal addButtonClicked
//    property bool addButton: true
//    property string titleButton: "$"
    signal textFieldTextChanged(string textFieldText)
    preferredHeight: 110
    maxHeight: 110
    layout: DockLayout {
    }
    Container {
        id: title
        leftPadding: 20
        function top() {
            title.verticalAlignment = VerticalAlignment.Top
            textLabel.textStyle.fontSize = FontSize.XSmall
        }
        function center() {
            title.verticalAlignment = VerticalAlignment.Center
            textLabel.textStyle.fontSize = FontSize.Medium

        }
        function changePosition(text) {
            if (text != "")
                top();
            else
                center()
        }
        onCreationCompleted: {
            center()
        }
        Label {
            id: textLabel
            text: "Place"
            textStyle {
                base: SystemDefaults.TextStyles.SubtitleText
            }
        }
    }
    Container {
        verticalAlignment: VerticalAlignment.Bottom
        horizontalAlignment: HorizontalAlignment.Fill
        TextArea  {
            id: content
            backgroundVisible: false
            hintText: ""
            onTextChanged: {
                textFieldTextChanged(text)
            }
            input {
                submitKey: SubmitKey.Next
                submitKeyFocusBehavior: SubmitKeyFocusBehavior.Next
            }
            onFocusedChanged: {
                if (focused) 
                    title.top()
                else if(text == "")
                    title.center()
                
            }
        }
    }
    Container {
        visible: addButton
        maxWidth: 150
        verticalAlignment: VerticalAlignment.Bottom
        horizontalAlignment: HorizontalAlignment.Right
        rightMargin: 10
        topPadding: -20
        bottomPadding: -20
        leftPadding: -20
        rightPadding: -20
        Button {
            preferredWidth: 40
            text: titleButton
            imageSource: (titleButton != "" ? "": "asset:///images/ic_add.png")
            onClicked: self.addButtonClicked()
        }
    }
    Divider {
        verticalAlignment: VerticalAlignment.Bottom
    }
}