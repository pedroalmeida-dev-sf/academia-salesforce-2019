trigger addPublicURL on ContentDocument (after insert) {


    map<ID,String> mapContentURL = new Map<ID,STring>();
    system.debug('TRIGGER.newMap:::'+trigger.newMap.keySet() );
    // for(ContentDistribution selContDist : [SELECT DistributionPublicUrl FROM ContentDistribution WHERE ContentDocumentId IN: trigger.newMap.keySet() ]){
    //                               mapContentURL.put(selContDist.ContentDocumentId,selContDist.DistributionPublicUrl);
    //                           }
    

    


    system.debug('MAP CONTENT URL:::'+mapContentURL);
    map<ID,ID> mapParentInvoiceId = new Map<ID,ID>();
    for(ContentVersion selContVersion : [SELECT ContentDocumentId,FirstPublishLocationId,Id,Title FROM ContentVersion WHERE ContentDocumentId IN: trigger.newMap.keySet() ]){
        mapParentInvoiceId.put(selContVersion.ContentDocumentId,selContVersion.FirstPublishLocationId);
    }
    
    
    Map<ID, Fatura__c> mapInvoices = new Map<ID, Fatura__c>();
    for(Fatura__c selFact : [SELECT Id, Invoice_Public_URL__c FROM Fatura__c WHERE Id IN: mapParentInvoiceId.values()]){
    mapInvoices.put(selFact.id,selFact);
    }
    for(ContentDocument selContDoc : trigger.new){
        Fatura__c selInvoice = mapInvoices.get(mapParentInvoiceId.get(selContDoc.ID));
        system.debug('df'+selInvoice);
        if(selInvoice.Invoice_Public_URL__c != NULL){
                system.debug('Nao existe URL:::');
                selInvoice.Invoice_Public_URL__c = mapContentURL.get(selContDoc.ID);
            }          
        mapInvoices.put(selInvoice.id,selInvoice);
    } 

    if(!mapInvoices.values().isEmpty()){
        update mapInvoices.values(); 
    }  


}