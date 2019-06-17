public with sharing class myProductsExtension{

    public myProductsExtension(ApexPages.StandardController
                                stdController) {
      
    }

    List<Product2> products;
	public List<Product2> getProducts() {
		if(products == null) 
            products = [SELECT Name, Id, ProductCode FROM Product2 WHERE ProductCode LIKE 'TI%' order By LastModifiedDate DESC LIMIT 6];
		return products;
	}



    List<Product2> ids = [SELECT Name ,Id ,ProductCode FROM Product2 WHERE ProductCode LIKE 'TI%' order By LastModifiedDate DESC LIMIT 6];
    //imagem slider 1
    public String getFilePId0() {
        String fileId = 'NADA';
        List<Attachment> attachedFiles = [select Id from Attachment where parentId =:ids[0].Id order By LastModifiedDate DESC limit 1];
        if( attachedFiles != null && attachedFiles.size() > 0 ) {
            
            fileId = attachedFiles[0].Id;
            
        }
        return fileId;    
    }
    //imagem slider 2
    public String getFilePId1() {
        String fileId = 'NADA1';
        List<Attachment> attachedFiles = [select Id from Attachment where parentId =:ids[1].Id order By LastModifiedDate DESC limit 1];
        if( attachedFiles != null && attachedFiles.size() > 0 ) {
            
            fileId = attachedFiles[0].Id;
            
        }
        return fileId;    
    }
    //imagem slider 3
    public String getFilePId2() {
        String fileId = 'NADA2';
        List<Attachment> attachedFiles = [select Id from Attachment where parentId =:ids[2].Id order By LastModifiedDate DESC limit 1];
        if( attachedFiles != null && attachedFiles.size() > 0 ) {
            
            fileId = attachedFiles[0].Id;
            
        }
        return fileId;    
    }

    public String getFilePId3() {
        String fileId = 'NADA3';
        List<Attachment> attachedFiles = [select Id from Attachment where parentId =:ids[3].Id order By LastModifiedDate DESC limit 1];
        if( attachedFiles != null && attachedFiles.size() > 0 ) {
            
            fileId = attachedFiles[0].Id;
            
        }
        return fileId;    
    }

    public String getFilePId4() {
        String fileId = 'NADA4';
        List<Attachment> attachedFiles = [select Id from Attachment where parentId =:ids[4].Id order By LastModifiedDate DESC limit 1];
        if( attachedFiles != null && attachedFiles.size() > 0 ) {
            
            fileId = attachedFiles[0].Id;
            
        }
        return fileId;    
    }

    public String getFilePId5() {
        String fileId = 'NADA5';
        List<Attachment> attachedFiles = [select Id from Attachment where parentId =:ids[5].Id order By LastModifiedDate DESC limit 1];
        if( attachedFiles != null && attachedFiles.size() > 0 ) {
            
            fileId = attachedFiles[0].Id;
            
        }
        return fileId;    
    }

}