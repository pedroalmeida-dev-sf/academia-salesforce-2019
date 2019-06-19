trigger addCVPublicURL on ContentVersion (after insert) {
    map<ID,String> mapContentURL = new Map<ID,STring>();
    system.debug('TRIGGER.newMap:::'+trigger.newMap.keySet() );
     
    //é preciso guardar contentversionid para criar distributionpublicurl
    map<ID,ID> mapParentInvoiceId = new Map<ID,ID>();
    ContentDistribution cntDist = new ContentDistribution();
    List<ContentDistribution> lstDistPublicUrl = new List<ContentDistribution>();
    //get contentversion data
    for(ContentVersion selContVersion : [SELECT ContentDocumentId,FirstPublishLocationId,Id,Title FROM ContentVersion WHERE /*ContentDocumentId*/Id IN: trigger.newMap.keySet() ]){
        mapParentInvoiceId.put(selContVersion.Id,selContVersion.FirstPublishLocationId);
        //system.debug('selContVersion.ContentDocumentId:::'+selContVersion.ContentDocumentId+'selContVersion.FirstPublishLocationId::::'+selContVersion.FirstPublishLocationId);
        system.debug('ContentVersionId:::::'+selContVersion.Id);
        system.debug('FirstPublishLocationId:::::'+selContVersion.FirstPublishLocationId);
        
        //create ContentDistributionPublicURL
        cntDist = new ContentDistribution();
        cntDist.ContentVersionId = selContVersion.Id;
        cntDist.Name = 'PublicShare';
        insert cntDist;

        lstDistPublicUrl.add(cntDist);
        
        system.debug('ContentDocumentID:::::'+selContVersion.ContentDocumentId);
    }
    
    //cntDist = [SELECT DistributionPublicUrl FROM ContentDistribution WHERE Id = :cntDist.Id];
    
    system.debug('New DistributionPublicURL:::'+cntDist);
    //get contentdistribution data created before
    
    for(ContentDistribution selContDist : [SELECT DistributionPublicUrl,ContentVersionId,ContentDocumentId,Id FROM ContentDistribution WHERE Id IN :lstDistPublicUrl]){
        
        mapContentURL.put(selContDist.ContentVersionId,selContDist.DistributionPublicUrl);
        system.debug('ContentDocumentId FROM CONTENT DISTRIBUTION:::::'+selContDist.ContentVersionId);
        system.debug('DistributionPublicUrl:::::'+selContDist.DistributionPublicUrl);

    }
    
    //get invoice data
    Map<ID, Fatura__c> mapInvoices = new Map<ID, Fatura__c>();
    for(Fatura__c selFactura : [SELECT Id, Invoice_Public_URL__c FROM Fatura__c WHERE Id IN: mapParentInvoiceId.values()]){
        
        mapInvoices.put(selFactura.id,selFactura);
        system.debug('Id:::::'+mapInvoices.keySet());
        system.debug('Invoice_Public_URL__c:::::'+mapInvoices.values());
        
    }


    for(ContentVersion selContVersion : trigger.new){
        Fatura__c selInvoice = mapInvoices.get(mapParentInvoiceId.get(selContVersion.ID));
        system.debug('FATURAAAAAAAA'+selInvoice);
        if(selInvoice.Invoice_Public_URL__c == NULL){
                system.debug('Nao existe URL:::ATUALIZARRRRRRRR');
                selInvoice.Invoice_Public_URL__c = mapContentURL.get(selContVersion.ID);
                system.debug('URL::::::'+selInvoice.Invoice_Public_URL__c);
            }          
        mapInvoices.put(selInvoice.id,selInvoice);
    }
  
    if(!mapInvoices.values().isEmpty()){
        update mapInvoices.values(); 
    }  

}