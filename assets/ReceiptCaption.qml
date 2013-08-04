import bb.cascades 1.0

Container {
    leftPadding: 20
    rightPadding: 20
    layout: DockLayout {

    }
    verticalAlignment: VerticalAlignment.Bottom
    horizontalAlignment: HorizontalAlignment.Fill
    background: Color.create("#880ABA0A")
    Container {
        preferredHeight: 2
        scaleX: 1.1
        horizontalAlignment: HorizontalAlignment.Fill
        background: Color.create("#550FF00A")

    }
    Label {
        text: "<html><b>#" + receiptNumber + "</b></html>"
        textFormat: TextFormat.Html
        textStyle.base: SystemDefaults.TextStyles.BigText
        textStyle.color: Color.create("#f8f8f8")
        verticalAlignment: VerticalAlignment.Center
    }
    Container {
        horizontalAlignment: HorizontalAlignment.Right
        verticalAlignment: VerticalAlignment.Center
        preferredHeight: 130
        Container {
            Label {
                text: {
                    var count = 0 //meal.participants.size()
                    var tmp = "<html><b><i>" + mealType.selectedOption.text + "</i></b> for <b>" + (count ? count : "Self" ) + "</b></html>"
                    return tmp
                }
                textFormat: TextFormat.Html
                textStyle.base: SystemDefaults.TextStyles.BodyText
                textStyle.color: Color.create("#f8f8f8")
            }
        }
        Container {
            //bottomPadding: 10
            //                                background: Color.Black
            maxHeight: 80
            maxWidth: 400
            ListView {
                layout: StackListLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                dataModel: mealPartModel
                listItemComponents: ListItemComponent {
                    ImageView {
                        imageSource: ListItemData["imageSource"]
                        scalingMethod: ScalingMethod.AspectFit
                    }
                }
            }
        }
    }
}