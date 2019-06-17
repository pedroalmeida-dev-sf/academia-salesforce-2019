({
	doInit : function(component, event, helper) {
		helper.getAccounts(Component, event, helper);
	},
    
    teste: function(component, event, helper){
        component.find("accountId").get("v.value");
    }
})