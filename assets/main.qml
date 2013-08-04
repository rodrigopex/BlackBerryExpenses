import bb.cascades 1.0

Page {
    property int receiptNumber: 55467
    property MealModelItem meal: newModelItem
    titleBar: TitleBar {
        title: "Meal expense"
        dismissAction: ActionItem {
            title: "Cancel"
            onTriggered: {
                console.log("cancel")
            }
        }
        acceptAction: ActionItem {
            title: "Save"
            onTriggered: {
                console.log("Save!!!")
                meal.receiptNumber = receiptNumber
                //nav.addItem(meal)
            }
        }
    }
    attachedObjects: [
        MealModelItem {
            id: newModelItem
        },
        ArrayDataModel {
            id: mealPartModel
        }
    ]
    Container {
        ScrollView {
            scrollRole: ScrollRole.Main
            scrollViewProperties.scrollMode: ScrollMode.Vertical
            scrollViewProperties.initialScalingMethod: ScalingMethod.None
            scrollViewProperties.pinchToZoomEnabled: false
            scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.None
            Container {
                id: form
                maxHeight: 1600
                //                property double price: 0.0
                function setPadding(component, padding) {
                    component.leftPadding = padding
                    component.rightPadding = padding
                    component.topPadding = padding
                    component.bottomPadding = padding
                }
                Container {
                    background: backgroundPaint.imagePaint
                    horizontalAlignment: HorizontalAlignment.Fill
                    layout: DockLayout {
                    }
                    attachedObjects: [
                        ImagePaintDefinition {
                            id: backgroundPaint
                            repeatPattern: RepeatPattern.XY
                            imageSource: "asset:///images/Tile_nistri_16x16.amd"
                        }
                    ]
                    ImageView {
                        id: receipt
                        imageSource: "images/01.png"
                        maxHeight: 300
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Center
                        scalingMethod: ScalingMethod.AspectFit
                        gestureHandlers: TapHandler {
                            onTapped: {
                                //controller.invokeCamera()
                            }
                        }
                        function newPhoto(path) {
                            receipt.imageSource = "file://" + path
                        }
                        onCreationCompleted: {
                            //controller.newReceiptPhoto.connect(receipt.newPhoto)
                        }
                    }
                    ReceiptCaption {
                    }
                }
                Container {
                    layout: DockLayout {
                    }
                    Header {
                        title: "Details"
                    }
                    ImageView {
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Center
                        imageSource: "/images/ic_overflow_tab_small.png"
                    }
                }

                Container {
                    id: meal
                    topPadding: 15
                    leftPadding: 15
                    rightPadding: 15
                    DropDown {
                        id: mealType
                        title: "Meal"
                        horizontalAlignment: HorizontalAlignment.Fill
                        options: [
                            Option {
                                text: "Breakfast"
                            },
                            Option {
                                text: "Lunch"

                            },
                            Option {
                                text: "Dinner"
                                selected: true
                            },
                            Option {
                                text: "Other"
                            }
                        ]
                        onSelectedIndexChanged: {
                            meal.type = selectedIndex
                        }
                    }
                }
                LabelTextField {
                    label: "Cost"
                    addButton: true
                    titleButton: "US$"
                    verticalAlignment: VerticalAlignment.Center
                    //hintText: "300000.00"
                    onTextFieldTextChanged: {
                        meal.cost = parseFloat(textFieldText)
                    }
                    onAddButtonClicked: {
                        console.log("change currency")
                    }
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 45
                    }
                }
                LabelTextField {
                    label: "Place"
                    onTextFieldTextChanged: {
                        meal.place = textFieldText
                    }
                }
                LabelTextField {
                    label: "Restaurant"
                    onTextFieldTextChanged: {
                        meal.restaurant = textFieldText
                    }
                }
                LabelTextField {
                    label: "Notes"
                    onTextFieldTextChanged: {
                        meal.notes = textFieldText
                    }
                }
                ParticipantsItem {
                    id: participantsItem
                    participantsModel: mealPartModel
                    onCreationCompleted: {
                        meal.participants = mealPartModel
                    }
                }
            }
        }
    }
}