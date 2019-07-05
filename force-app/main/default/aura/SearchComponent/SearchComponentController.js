({
    search : function(component, event, helper) {
        //evento entre pai e filho
        var search = component.find("search").get("v.value");

        var eventSearch = component.getEvent("passSearch");

        eventSearch.setParams({
            search:search
        });
        eventSearch.fire(); 
        
        //evento entre irmaos 
        var appEvent = $A.get("e.c:searchAppEvent");
        appEvent.setParams({
            search:search
        });
        appEvent.fire();
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
