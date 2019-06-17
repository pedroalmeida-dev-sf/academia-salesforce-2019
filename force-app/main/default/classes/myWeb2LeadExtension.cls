public class myWeb2LeadExtension {

    private final Lead weblead;
    
    public myWeb2LeadExtension(ApexPages.StandardController
                                stdController) {
       weblead = (Lead)stdController.getRecord();
    }

    /*public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Name, Description, type, isActive FROM Campaign WHERE isActive = true AND Type = 'Webinar']));
            }
            return setCon;
        }
        set;
    }*/
    /*public List<Campaign> getCampaigns() {
         return (List<Campaign>) setCon.getRecords();
    }*/

    //vai buscar as campanhas destinadas ao site    
    /*List<Campaign> campaigns;
	public List<Campaign> getCampaigns() {
		if(campaigns == null) 
            campaigns = [SELECT Name, Description, type, isActive, URL_Imagem__c FROM Campaign WHERE isActive = true AND Type = 'Webinar' LIMIT 3];
		return campaigns;
    }*/

    List<Lead> leads;
    public List<Lead> getLeads(){
        if(leads == null)
            leads = [SELECT NAME, DESCRIPTION, CreatedById FROM Lead WHERE CreatedById ='0051r000008jFyGAAU'  order By LastModifiedDate DESC LIMIT 3];
        return leads;  
    }

    //guarda a lead no salesforce
     public PageReference saveLead() {
       try {
       insert(weblead);
       }
       catch(System.DMLException e) {
           ApexPages.addMessages(e);
           return null;
       }
       //redirecciona para uma página de agradecimento
       PageReference p = Page.ThankYou;
       p.setRedirect(true);
       return p;
     }

     public PageReference novaEncomenda(){
         PageReference p = Page.nova_encomenda;
         p.setRedirect(true);
        return p;
     }
}