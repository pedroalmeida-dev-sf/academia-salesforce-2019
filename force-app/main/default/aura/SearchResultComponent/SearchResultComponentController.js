({
    handleSearch : function(component, event, helper) {
        var searchText = event.getParam("search");

        component.set("v.searchText",searchText);
    }
})
