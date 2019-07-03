({
	doInit : function(component, event, helper) {
		//alert('TESTES');
		var contacts = component.get("c.contactList");
		
		contacts.setCallback(this, function(action){
			var state = action.getState();
			if(state === 'SUCCESS'){
				var response = action.getReturnValue();
				component.set("v.contactos", response);
				helper.CreateColumns(component,helper,event);
			}
		});
		$A.enqueueAction(contacts);
	}
})