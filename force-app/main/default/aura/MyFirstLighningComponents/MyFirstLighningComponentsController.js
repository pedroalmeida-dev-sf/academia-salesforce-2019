({
	firstFunction : function(component, event, helper) {
		component.set("v.msg","Adeus Mundo")
        alert("olá mundo")
        helper.secondFunction(component,event, helper)
	}
})