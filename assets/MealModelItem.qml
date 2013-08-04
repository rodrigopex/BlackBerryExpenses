import bb.cascades 1.0

QtObject {
    id: self
    property int receiptNumber
    property int type: 0 //Breakfast; 1 - Lunch; 2 - Dinner; 3 - other
    property double cost: 0.0
    property string currency: "US$"
    property string place
    property string restaurant
    property string notes
    property ArrayDataModel participants // [ {"name": <name>, "imageSource": <imageSource>}]
    function setParticipants(model) {
        self.participants = model
    }
}
