import bb.cascades 1.0
import bb.cascades.pickers 1.0

Container {
    id: myContactsPicker
    signal contactsIdChanged (variant ids)
    function openContacts() {
        contactPicker.open()
    }
    attachedObjects: [
        ContactPicker {
            id: contactPicker
            mode: ContactSelectionMode.Multiple
            onContactsSelected: {
                //console.log("contacts selected: ", contactIds)
                myContactsPicker.contactsIdChanged(contactIds)    
            }
        }
    ]
}
