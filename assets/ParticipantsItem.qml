import bb.cascades 1.0

Container {
    id: self
    //signal addParticipantsClicked
    property ArrayDataModel participantsModel
    preferredHeight: 110
    //maxHeight: 110
    layout: DockLayout {
    }
    attachedObjects: [
        MyContactPicker {
            id: contactPicker
            onContactsIdChanged: {
                for (var i = 0; i < ids.length; i ++) {
                    console.log("contacts: ", controller.contactDetails(ids[i]))
                    participantsModel.append(controller.contactDetails(ids[i]))
                }
            }
        }
    ]
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
        onCreationCompleted: {
            //center()
        }
        Label {
            id: textLabel
            text: "Participants"
            textStyle {
                base: SystemDefaults.TextStyles.SubtitleText
            }
        }
    }
    Container {
        leftPadding: 20
        preferredHeight: 70
        verticalAlignment: VerticalAlignment.Bottom
        horizontalAlignment: HorizontalAlignment.Fill
        ListView {
            id: partList
            dataModel: participantsModel
            preferredWidth: 675
            layout: FlowListLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            onFocusedChanged: {
                if (! focused)
                    partList.clearSelection()
            }
            onTriggered: {
                if (partList.selected() != indexPath) {
                    partList.clearSelection()
                    partList.select(indexPath, true)
                    console.log("Selected: ", indexPath)
                }
            }
            onCreationCompleted: {
//                var p1 = {
//                    "name": "Fulano",
//                    "imageSource": "asset:///images/rodrigo.png"
//                }
//                var p2 = {
//                    "name": "Cicrano",
//                    "imageSource": "asset:///images/rodrigo.png"
//                }
//                participantsModel.append([ p1, p2, p1, p2 ])
            }
            listItemComponents: [
                ListItemComponent {
                    ParticipantCell {
                        name: ListItemData["name"]
                        selected: ListItem.selected
                    }
                }
            ]
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
            imageSource: "asset:///images/ic_add.png"
            onClicked: {
                contactPicker.openContacts()
            }
        }
    }
    Divider {
        verticalAlignment: VerticalAlignment.Bottom
    }
}