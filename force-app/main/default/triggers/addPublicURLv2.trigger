trigger addPublicURLv2 on ContentVersion (after insert) {

    system.debug('TRIGGER.newMap:::'+trigger.newMap.keySet() );
    
    //get contentversion data
    map<ID,ID> mapParentInvoiceId = new Map<ID,ID>();
    for(ContentVersion selContVersion : trigger.new)
    {
        mapParentInvoiceId.put(selContVersion.Id,selContVersion.FirstPublishLocationId);
        system.debug('ContentVersionId:::::'+selContVersion.Id);
        system.debug('FirstPublishLocationId:::::'+selContVersion.FirstPublishLocationId);
        //idContent = selContVersion.Id;
        //system.debug('idContent:::'+idContent);
    } 
    
    //get contentdistribution data created before
    map<ID,String> mapContentURL = new Map<ID,String>();
    for(ContentDistribution selContDist : [SELECT DistributionPublicUrl,ContentVersionId 
                                           FROM ContentDistribution 
                                           WHERE ContentVersionId IN:mapParentInvoiceId.keySet()]){    
        mapContentURL.put(selContDist.ContentVersionId,selContDist.DistributionPublicUrl);
        system.debug('ContentVersionId FROM CONTENT DISTRIBUTION:::::'+selContDist.ContentVersionId);
        system.debug('DistributionPublicUrl:::::'+selContDist.DistributionPublicUrl);
    }

    system.debug(':::mapContentURL:::'+mapContentURL);
    if(mapContentURL.isEmpty()){
        system.debug('::::::::::mapContentURL NULL:::::::::');
        List<ContentDistribution> lstDistPublicUrl = new List<ContentDistribution>();
        
        system.debug(':::mapParentInvoiceId::'+mapParentInvoiceId);
        for(ContentVersion selContVersion : [SELECT Id 
                                              FROM ContentVersion 
                                              WHERE Id IN:mapParentInvoiceId.keySet()]){
            ContentDistribution cntDist = new ContentDistribution();
            cntDist.name = 'PUBLIC URL';
            cntDist.ContentVersionId = selContVersion.Id;
            system.debug('cntDist.ContentVersionId:::'+cntDist.ContentVersionId);
            
            insert cntDist;
            lstDistPublicUrl.add(cntDist);
            cntDist = [SELECT DistributionPublicUrl FROM ContentDistribution WHERE ID = :cntDist.Id];
            System.debug('cntDist.DistributionPublicUrl:::'+cntDist.DistributionPublicUrl);
        }  

        for(ContentDistribution selContDist : [SELECT DistributionPublicUrl,ContentVersionId,Id FROM ContentDistribution WHERE Id IN :lstDistPublicUrl]){
            mapContentURL.put(selContDist.ContentVersionId,selContDist.DistributionPublicUrl);
            system.debug('ContentVersionId FROM CONTENT DISTRIBUTION:::::'+selContDist.ContentVersionId);
            system.debug('DistributionPublicUrl:::::'+selContDist.DistributionPublicUrl);
        } 
    }
    
    //get invoice data
    Map<ID, Fatura__c> mapInvoices = new Map<ID, Fatura__c>();
    for(Fatura__c selFactura : [SELECT Id, Invoice_Public_URL__c 
                                FROM Fatura__c 
                                WHERE Id IN: mapParentInvoiceId.values()])
    { 
        mapInvoices.put(selFactura.id,selFactura);
        system.debug('Id Invoice:::::'+selFactura.id);
        system.debug('Invoice_Public_URL__c:::::'+selFactura);     
    }

    for(ContentVersion selContVersion : trigger.new)
    {
        Fatura__c selInvoice = mapInvoices.get(mapParentInvoiceId.get(selContVersion.ID));
        system.debug('INVOICE'+selInvoice);
        
        if(selInvoice != NULL){
        
            //only update URL if Invoice_Public_URL__c is null
            if(selInvoice.Invoice_Public_URL__c == NULL)
            {
                system.debug('Nao existe URL:::UPDATE');
                selInvoice.Invoice_Public_URL__c = mapContentURL.get(selContVersion.ID);
                system.debug('URL::::::'+selInvoice.Invoice_Public_URL__c);
            }          
            mapInvoices.put(selInvoice.id,selInvoice);
        }  
    }
  
    if(!mapInvoices.values().isEmpty()){
        update mapInvoices.values(); 
    }  
}