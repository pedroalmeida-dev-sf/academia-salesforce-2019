({
	CreateColumns : function(component, helper,event) {
		component.set("v.columns",[
			{label: 'Id', fieldName: 'Id', type: 'text'},
			{label: 'Name', fieldName: 'Name', type: 'text'},
			{label: 'Email', fieldName: 'Email', type: 'email'}
		])
	}
})