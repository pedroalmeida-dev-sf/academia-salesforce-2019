public class propostaPDF_controller {
	
	public list<Opportunity> opptyList;
	


	public propostaPDF_controller(ApexPages.StandardController stdController) {

		opptyList = [SELECT Id,Name,Account.Name, (SELECT Quantity, UnitPrice, TotalPrice,PricebookEntry.Name, PricebookEntry.Product2.Family 
						FROM OpportunityLineItems) 
                        FROM Opportunity 
						WHERE Id =: ApexPages.currentPage().getParameters().get('id')];
	
        System.debug('opptyList ='+opptyList);
									
		
	}


	/*public propostaPDF_controller(){
		opptyList = [SELECT Id,Name,Account.Name, (SELECT Quantity, UnitPrice, TotalPrice,PricebookEntry.Name, PricebookEntry.Product2.Family 
						FROM OpportunityLineItems) 
                        FROM Opportunity 
						WHERE Id =: ApexPages.currentPage().getParameters().get('opptyID')];
    
        System.debug('opptyList ='+opptyList);

	}*/


	public list<Opportunity> getopptyList(){
		return opptyList;
	}
	  
	


}