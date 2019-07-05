({
    search : function(component, event, helper) {
        var search = component.find("search").get("v.value");

        var eventSearch = component.getEvent("passSearch");

        eventSearch.setParams({
            search:search
        });
        eventSearch.fire();
    },

    handleKeyUp : function(component, event, helper) {
        var isEnterKey = event.keyCode === 13;
        if (isEnterKey) {
            var search = component.find("search").get("v.value");
            var eventSearch = component.getEvent("passSearch");

            eventSearch.setParams({
                search:search
            });
            eventSearch.fire();
            
        }
        
    }
})
