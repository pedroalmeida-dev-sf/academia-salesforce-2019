public class showCampaign{

//SELECT Name, Description, type, isActive FROM Campaign WHERE isActive = true AND Type = 'Webinar'

 public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Name, Description, type, isActive FROM Campaign WHERE isActive = true AND Type = 'Webinar']));
            }
            return setCon;
        }
        set;
    }
    public List<Campaign> getCampaigns() {
         return (List<Campaign>) setCon.getRecords();
    }

}