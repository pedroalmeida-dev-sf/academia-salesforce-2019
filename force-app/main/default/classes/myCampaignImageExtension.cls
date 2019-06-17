public with sharing class myCampaignImageExtension{

public final Campaign imagem;
    String recId;
    public myCampaignImageExtension(ApexPages.StandardController
                                stdController) {
       //imagem = (Campaign)stdController.getRecord();
       //recId = stdcontroller.getId();    
    }

    List<Campaign> campaigns;
	public List<Campaign> getCampaigns() {
		if(campaigns == null) 
            campaigns = [SELECT Name, Description, type, isActive, URL_Imagem__c FROM Campaign WHERE isActive = true AND Type = 'Webinar' LIMIT 3];
		return campaigns;
	}

    List<Campaign> imagens;
    public List<Campaign> getImage(){
        if(imagens == null) 
            imagens = [SELECT URL_Imagem__c FROM Campaign WHERE isActive = true AND Type = 'Webinar' LIMIT 3];
		return imagens;
    }


    List<Campaign> ids = [SELECT Id FROM Campaign WHERE isActive = true AND Type = 'Webinar' LIMIT 3];
    //imagem slider 1
    public String getFileId0() {
        String fileId = 'NADA';
        List<Attachment> attachedFiles = [select Id from Attachment where parentId =:ids[0].Id order By LastModifiedDate DESC limit 1];
        if( attachedFiles != null && attachedFiles.size() > 0 ) {
            
            fileId = attachedFiles[0].Id;
            
        }
        return fileId;    
    }
    //imagem slider 2
    public String getFileId1() {
        String fileId = 'NADA1';
        List<Attachment> attachedFiles = [select Id from Attachment where parentId =:ids[1].Id order By LastModifiedDate DESC limit 1];
        if( attachedFiles != null && attachedFiles.size() > 0 ) {
            
            fileId = attachedFiles[0].Id;
            
        }
        return fileId;    
    }
    //imagem slider 3
    public String getFileId2() {
        String fileId = 'NADA2';
        List<Attachment> attachedFiles = [select Id from Attachment where parentId =:ids[2].Id order By LastModifiedDate DESC limit 1];
        if( attachedFiles != null && attachedFiles.size() > 0 ) {
            
            fileId = attachedFiles[0].Id;
            
        }
        return fileId;    
    }
}