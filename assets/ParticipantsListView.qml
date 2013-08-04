import bb.cascades 1.0

Container {
    //maxHeight: 400
    function addParticipant(nameAndImageSource) {
        console.log("Contact information: ", nameAndImageSource[0], ",", nameAndImageSource[1])
        pModel.append([ nameAndImageSource ])
    }
    ListView {
        id: pList
        function deleteSelection() {
            pModel.removeAt(pList.selected())
        }
        dataModel: ArrayDataModel {
            id: pModel
        }
        onSelectionChanged: {
            console.log("selected!")
        }
        onTriggered: {

        }
        contextActions: ActionSet {
            DeleteActionItem {
                //                title: "Deleting item"
                //                enabled: pList.isSelected(pList.selected())
                onTriggered: {
                    if (pList.isSelected(pList.selected()))
                        pList.deleteSelection()
                }
            }
        }
        listItemComponents: [
            ListItemComponent {
                function deleteItem() {
                    ListItem.view.deleteSelection()
                }
                Container {
                    background:bg.imagePaint 
                    StandardListItem {
                        //imageSource: ListItemData[1]
                        title: ListItemData[0]
                        imageSpaceReserved: true

                    }
                    attachedObjects: ImagePaintDefinition {
                        id: bg
                        imageSource: "asset:///images/participant.amd"
                    }
                }
            }
        ]
    }
}
