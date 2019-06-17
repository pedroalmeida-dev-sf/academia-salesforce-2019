public with sharing class novoContactoController {
	/* private final Contact cont;

	public novoContactoController(ApexPages.StandardController
                                stdController) {
		cont = (Contact)stdController.getRecord();
	}

	//guarda a lead no salesforce
     public PageReference saveContact() {
       try {
       insert(cont);
       }
       catch(System.DMLException e) {
           ApexPages.addMessages(e);
           return null;
       }
       //redirecciona para uma página de agradecimento
       PageReference p = Page.ThankYou;
       p.setRedirect(true);
       return p;
     } */

	 public String inputFirstName {get;set;}
	 public String inputLastName {get;set;}
	 public String inputPhone {get;set;}
	 public String inputEmail {get;set;}
	 public String inputDescription {get;set;}


 	 public void save(){
		 Contact c = new Contact();
		 c.FirstName = inputFirstName;
		 c.LastName = inputLastName;
		 c.Phone = inputPhone;
		 c.Email = inputEmail;
		 c.Description = inputDescription;
		 try{
			 insert c;
		 }
		 catch(DMLException e){
			System.debug('DMLException Caught: '+e.getMessage());
		 }
		 
	 }
}