({
    handleSearch : function(component, event, helper) {
        var searchText = event.getParam("search");

        component.set("v.searchText",searchText);
    },

    appEventHandler :function(component, event, helper){
        var search = event.getParam("search");
        var contacts = component.get("c.getSearchedContacts");
        component.set("v.searchText2",search);

        contacts.setParams({
            searchTerm: search
        });

        contacts.setCallback(this,function(action){
            var state = action.getState();

            if(state === 'SUCCESS'){
                var response = action.getReturnValue();
                component.set("v.contactList",response);
            }
        });
        $A.enqueueAction(contacts)
    }
})
