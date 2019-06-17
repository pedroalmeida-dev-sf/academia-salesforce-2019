public class dataList{

    List<Campaign> campaigns;

	public List<Campaign> getCampaigns() {
		if(campaigns == null) campaigns = [SELECT Name, Description, type, isActive FROM Campaign WHERE isActive = true AND Type = 'Webinar' LIMIT 3];
		return campaigns;
	}

}