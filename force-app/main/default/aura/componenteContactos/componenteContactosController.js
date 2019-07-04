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
	},

	showTabela : function(component,event,helper){
		component.set("v.showContacts",true);
	},

	hideTabela : function(component,event,helper){
		component.set("v.showContacts",false);
	},

	createContact : function(component,event,helper){
		var nome = component.find("firstName").get("v.value");
		var apelido = component.find("lastName").get("v.value");
		var email = component.find("email").get("v.value");

		var create = component.get("c.createNewContact");

		create.setParams({
			firstName : nome,
			lastName : apelido,
			email : email
		});
		create.setCallback(this,function(action){
			var state = action.getState();
			if(state === 'SUCCESS'){
				var response = action.getReturnValue();
				if(response != null){
					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						"title": "Success!",
						"message": "The record has been created successfully.",
						"type" : "success"
					});
					toastEvent.fire();
				}
			}
		});
		$A.enqueueAction(create);
	}

})